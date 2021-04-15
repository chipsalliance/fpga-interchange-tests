function(add_xc7_test)
    # ~~~
    # add_xc7_test(
    #    name <name>
    #    board_list <board_list>
    #    tcl <tcl>
    #    sources <sources list>
    #    [top <top name>]
    #    [techmap <techmap file>]
    # )
    #
    # Generates targets to run desired tests
    #
    # Arguments:
    #   - name: test name. This must be unique and no other tests with the same
    #           name should exist
    #   - board_list: list of boards, one for each test
    #   - tcl: tcl script used for synthesis
    #   - sources: list of HDL sources
    #   - top (optional): name of the top level module.
    #                     If not provided, "top" is assigned as top level module
    #   - techmap (optional): techmap file used during synthesis
    #
    # Targets generated:
    #   - xc7-test-<name>-json     : synthesis output
    #   - xc7-test-<name>-netlist  : logical interchange netlist
    #   - xc7-test-<name>-phys     : physical interchange netlist
    #   - xc7-test-<name>-fasm     : fasm file
    #   - xc7-test-<name>-bit      : bitstream
    #   - xc7-test-<name>-dcp      : DCP

    set(options)
    set(oneValueArgs name tcl top techmap)
    set(multiValueArgs board_list sources)

    cmake_parse_arguments(
        add_xc7_test
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(name ${add_xc7_test_name})
    set(top ${add_xc7_test_top})
    set(tcl ${CMAKE_CURRENT_SOURCE_DIR}/${add_xc7_test_tcl})
    set(techmap ${CMAKE_CURRENT_SOURCE_DIR}/${add_xc7_test_techmap})

    set(sources)
    foreach(source ${add_xc7_test_sources})
        list(APPEND sources ${CMAKE_CURRENT_SOURCE_DIR}/${source})
    endforeach()

    if (NOT DEFINED top)
        # Setting default top value
        set(top "top")
    endif()

    message(${name})
    foreach(board ${add_xc7_test_board_list})
        set(test_name "${name}_${board}")
        get_property(device_family TARGET board-${board} PROPERTY DEVICE_FAMILY)
        get_property(device TARGET board-${board} PROPERTY DEVICE)
        get_property(package TARGET board-${board} PROPERTY PACKAGE)
        get_property(part TARGET board-${board} PROPERTY PART)
        set(xdc ${CMAKE_CURRENT_SOURCE_DIR}/${board}.xdc)
        set(device_loc ${NEXTPNR_SHARE_DIR}/devices/${device}.device)
        set(chipdb_loc ${NEXTPNR_SHARE_DIR}/chipdb/${device}.bin)

        # Synthesis
        set(synth_json ${CMAKE_CURRENT_BINARY_DIR}/${test_name}.json)
        add_custom_command(
            OUTPUT ${synth_json}
            COMMAND ${CMAKE_COMMAND} -E env
                SOURCES="${sources}"
                OUT_JSON=${synth_json}
                TECHMAP=${techmap}
                yosys -c ${tcl}
            DEPENDS ${sources} ${techmap} ${tcl}
        )

        add_custom_target(xc7-${test_name}-json DEPENDS ${synth_json})

        # Logical netlist
        set(netlist ${CMAKE_CURRENT_BINARY_DIR}/${test_name}.netlist)
        add_custom_command(
            OUTPUT ${netlist}
            COMMAND ${CMAKE_COMMAND} -E env
                python3 -mfpga_interchange.yosys_json
                    --schema_dir ${INTERCHANGE_SCHEMA_PATH}
                    --device ${device_loc}
                    --top ${top}
                    ${synth_json}
                    ${netlist}
            DEPENDS
                ${synth_json}
                ${device_loc}
        )

        add_custom_target(xc7-${test_name}-netlist DEPENDS ${netlist})

        # Physical netlist
        set(phys ${CMAKE_CURRENT_BINARY_DIR}/${test_name}.phys)
        add_custom_command(
            OUTPUT ${phys}
            COMMAND
                nextpnr-fpga_interchange
                    --chipdb ${chipdb_loc}
                    --xdc ${xdc}
                    --netlist ${netlist}
                    --phys ${phys}
                    --package ${package}
            DEPENDS
                ${netlist}
                ${xdc}
                ${chipdb_loc}
        )

        add_custom_target(xc7-${test_name}-phys DEPENDS ${phys})

        # DCP generation target
        set(dcp ${CMAKE_CURRENT_BINARY_DIR}/${test_name}.dcp)
        add_custom_command(
            OUTPUT ${dcp}
            COMMAND ${CMAKE_COMMAND} -E env
                RAPIDWRIGHT_PATH=${RAPIDWRIGHT_PATH}
                ${INVOKE_RAPIDWRIGHT}
                com.xilinx.rapidwright.interchange.PhysicalNetlistToDcp
                ${netlist} ${phys} ${xdc} ${dcp}
            DEPENDS
                ${INVOKE_RAPIDWRIGHT}
                ${phys}
                ${netlist}
        )

        add_custom_target(xc7-${test_name}-dcp DEPENDS ${dcp})

        # Output FASM target
        set(fasm ${CMAKE_CURRENT_BINARY_DIR}/${test_name}.fasm)
        add_custom_command(
            OUTPUT ${fasm}
            COMMAND ${CMAKE_COMMAND} -E env
                python3 -mfpga_interchange.fasm_generator
                    --schema_dir ${INTERCHANGE_SCHEMA_PATH}
                    --family xc7
                    ${device_loc}
                    ${netlist}
                    ${phys}
                    ${fasm}
            DEPENDS
                ${device_target}
                ${netlist}
                ${phys}
                ${dcp}
        )

        add_custom_target(xc7-${test_name}-fasm DEPENDS ${fasm})

        # Bitstream generation target
        set(bit ${CMAKE_CURRENT_BINARY_DIR}/${test_name}.bit)
        add_custom_command(
            OUTPUT ${bit}
            COMMAND ${CMAKE_COMMAND} -E env
                xcfasm
                    --db-root ${PRJXRAY_DB_DIR}/${device_family}
                    --part ${part}
                    --part_file ${PRJXRAY_DB_DIR}/${device_family}/${part}/part.yaml
                    --sparse
                    --emit_pudc_b_pullup
                    --fn_in ${fasm}
                    --bit_out ${bit}
            DEPENDS
                ${fasm}
            )

        add_custom_target(xc7-${test_name}-bit DEPENDS ${bit})
        add_dependencies(all-xc7-tests xc7-${test_name}-bit)
    endforeach()

endfunction()
