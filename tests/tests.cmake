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
    #   - validate: adds targets to run a validation step of the generated bitstream
    #               with the support of the fasm2bels library
    #
    # Targets generated:
    #   - xc7-<name>-<board>-json     : synthesis output
    #   - xc7-<name>-<board>-netlist  : logical interchange netlist
    #   - xc7-<name>-<board>-phys     : physical interchange netlist
    #   - xc7-<name>-<board>-fasm     : fasm file
    #   - xc7-<name>-<board>-bit      : bitstream
    #   - xc7-<name>-<board>-dcp      : DCP

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

    foreach(board ${add_xc7_test_board_list})
        # Get board properties
        get_property(device_family TARGET board-${board} PROPERTY DEVICE_FAMILY)
        get_property(device TARGET board-${board} PROPERTY DEVICE)
        get_property(package TARGET board-${board} PROPERTY PACKAGE)
        get_property(part TARGET board-${board} PROPERTY PART)

        set(test_name "${name}-${board}")
        set(xdc ${CMAKE_CURRENT_SOURCE_DIR}/${board}.xdc)
        set(device_loc ${NEXTPNR_SHARE_DIR}/devices/${device}.device)
        set(chipdb_loc ${NEXTPNR_SHARE_DIR}/chipdb/${device}.bin)

        set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/${board})
        add_custom_command(
            OUTPUT ${output_dir}
            COMMAND ${CMAKE_COMMAND} -E make_directory ${output_dir}
        )

    add_custom_target(xc7-${test_name}-output-dir DEPENDS ${output_dir})

        # Synthesis
        set(synth_json ${output_dir}/${name}.json)
        add_custom_command(
            OUTPUT ${synth_json}
            COMMAND ${CMAKE_COMMAND} -E env
                SOURCES="${sources}"
                OUT_JSON=${synth_json}
                TECHMAP=${techmap}
                yosys -c ${tcl}
            DEPENDS
                ${sources}
                ${techmap}
                ${tcl}
                xc7-${test_name}-output-dir
        )

        add_custom_target(xc7-${test_name}-json DEPENDS ${synth_json})

        # Logical netlist
        set(netlist ${output_dir}/${name}.netlist)
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
                xc7-${test_name}-json
                ${device_loc}
        )

        add_custom_target(xc7-${test_name}-netlist DEPENDS ${netlist})

        # Physical netlist
        set(phys ${output_dir}/${name}.phys)
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
                xc7-${test_name}-netlist
                ${xdc}
                ${chipdb_loc}
        )

        add_custom_target(xc7-${test_name}-phys DEPENDS ${phys})

        # DCP generation target
        set(dcp ${output_dir}/${name}.dcp)
        add_custom_command(
            OUTPUT ${dcp}
            COMMAND ${CMAKE_COMMAND} -E env
                RAPIDWRIGHT_PATH=${RAPIDWRIGHT_PATH}
                ${INVOKE_RAPIDWRIGHT}
                com.xilinx.rapidwright.interchange.PhysicalNetlistToDcp
                ${netlist} ${phys} ${xdc} ${dcp}
            DEPENDS
                ${INVOKE_RAPIDWRIGHT}
                xc7-${test_name}-netlist
                xc7-${test_name}-phys
        )

        add_custom_target(xc7-${test_name}-dcp DEPENDS ${dcp})

        # Output FASM target
        set(fasm ${output_dir}/${name}.fasm)
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
                xc7-${test_name}-netlist
                xc7-${test_name}-phys
                xc7-${test_name}-dcp
        )

        add_custom_target(xc7-${test_name}-fasm DEPENDS ${fasm})

        # Bitstream generation target
        set(bit ${output_dir}/${name}.bit)
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
                xc7-${test_name}-fasm
            )

        add_custom_target(xc7-${test_name}-bit DEPENDS ${bit})
        add_dependencies(all-xc7-tests xc7-${test_name}-bit)
    endforeach()

endfunction()

function(add_xc7_validation_test)
    # ~~~
    # add_xc7_validation_test(
    #    name <name>
    #    board_list <board>
    #    [enable_vivado_test]
    # )
    #
    # Generates targets to run desired tests
    #
    # Arguments:
    #   - name: test name. This must be unique and no other tests with the same
    #           name should exist
    #   - board_list: list of boards, one for each test
    #
    # Targets generated:
    #   - <device>-channels-db              : device database for fasm2bels
    #   - xc7-<name>-<board>-fasm2bels      : target to run fasm2bels
    #   - xc7-<name>-<board>-fasm2bels-dcp  : dcp from the fasm2bels outputs
    #   - xc7-<name>-<board>-tcl            : tcl file to run Vivado
    #   - xc7-<name>-<board>-vivado-bit     : vivado-generated bitstream

    set(options enable_vivado_test)
    set(oneValueArgs name)
    set(multiValueArgs board_list)

    cmake_parse_arguments(
        add_xc7_validation_test
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(name ${add_xc7_validation_test_name})
    set(enable_vivado_test ${add_xc7_validation_test_enable_vivado_test})
    foreach(board ${add_xc7_validation_test_board_list})
        get_property(device_family TARGET board-${board} PROPERTY DEVICE_FAMILY)
        get_property(device TARGET board-${board} PROPERTY DEVICE)
        get_property(package TARGET board-${board} PROPERTY PACKAGE)
        get_property(part TARGET board-${board} PROPERTY PART)

        set(test_name "${name}-${board}")

        set(device_channels_dir ${CMAKE_BINARY_DIR}/channels)
        set(device_channels ${device_channels_dir}/${device}.db)
        if(NOT TARGET ${device}-channels-db)
            # Build the channels.db file required by fasm2bels
            add_custom_command(
                OUTPUT ${device_channels}
                COMMAND
                    ${CMAKE_COMMAND} -E make_directory ${device_channels_dir}
                COMMAND
                    python3 -mfasm2bels.database.create_channels
                        --db-root ${PRJXRAY_DB_DIR}/${device_family}
                        --part ${part}
                        --connection-database ${device_channels}
                )

            add_custom_target(${device}-channels-db DEPENDS ${device_channels})
        endif()

        find_program(BITREAD bitread REQUIRED)

        set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/${board})
        set(bit ${output_dir}/${name}.bit)
        set(bit_target xc7-${test_name}-bit)

        # Run fasm2bels to get logical and physical netlists
        set(netlist ${output_dir}/${name}.bit.netlist)
        set(phys ${output_dir}/${name}.bit.phys)
        set(xdc ${output_dir}/${name}.bit.xdc)
        set(fasm ${output_dir}/${name}.bit.fasm)
        add_custom_command(
            OUTPUT ${netlist} ${phys} ${xdc} ${fasm}
            COMMAND
                python3 -mfasm2bels
                    --db_root ${PRJXRAY_DB_DIR}/${device_family}
                    --part ${part}
                    --connection_database ${device_channels}
                    --bitread ${BITREAD}
                    --bit_file ${bit}
                    --fasm_file ${fasm}
                    --logical_netlist ${netlist}
                    --physical_netlist ${phys}
                    --interchange_xdc ${xdc}
                    --interchange_capnp_schema_dir ${INTERCHANGE_SCHEMA_PATH}
            DEPENDS
                xc7-${test_name}-bit
                ${device}-channels-db
        )

        add_custom_target(xc7-${test_name}-fasm2bels DEPENDS ${netlist} ${phys} ${xdc} ${fasm})

        # DCP generation target
        set(dcp ${output_dir}/${name}.bit.dcp)
        add_custom_command(
            OUTPUT ${dcp}
            COMMAND ${CMAKE_COMMAND} -E env
                RAPIDWRIGHT_PATH=${RAPIDWRIGHT_PATH}
                ${INVOKE_RAPIDWRIGHT}
                com.xilinx.rapidwright.interchange.PhysicalNetlistToDcp
                ${netlist} ${phys} ${xdc} ${dcp}
            DEPENDS
                ${INVOKE_RAPIDWRIGHT}
                xc7-${test_name}-fasm2bels
        )

        add_custom_target(xc7-${test_name}-fasm2bels-dcp DEPENDS ${dcp})

        # Generate tcl script to run DCP to bitstream generation
        set(tcl ${output_dir}/runme.tcl)
        set(vivado_bit ${output_dir}/${name}.vivado.bit)
        add_custom_command(
            OUTPUT ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "open_checkpoint ${dcp}"                                               >  ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "${XDC_EXTRA_ARGS}"                                                    >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "set_property CFGBVS VCCO [current_design]"                            >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "set_property CONFIG_VOLTAGE 3.3 [current_design]"                     >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "set_property BITSTREAM.GENERAL.PERFRAMECRC YES [current_design]"      >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "set_property IS_ENABLED 0 [get_drc_checks {LUTLP-1}]"                 >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "set_property IS_ENABLED 0 [get_drc_checks {NSTD-1}]"                  >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "report_utilization -file ${output_dir}/utilization.rpt"               >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "report_clock_utilization -file ${output_dir}/clock_utilization.rpt"   >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "report_timing_summary -datasheet -max_paths 10 -file ${output_dir}/timing_summary.rpt" >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "report_power -file ${output_dir}/power.rpt"                           >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "report_route_status -file ${output_dir}/route_status.rpt"             >> ${tcl}
            COMMAND ${CMAKE_COMMAND} -E echo "write_bitstream -force ${vivado_bit}"                                 >> ${tcl}
            DEPENDS
                xc7-${test_name}-fasm2bels-dcp
        )

        add_custom_target(xc7-${test_name}-tcl DEPENDS ${tcl})

        # Generate bitstream from Vivado
        add_custom_command(
            OUTPUT ${vivado_bit}
            COMMAND
                vivado -mode batch -source ${tcl}
            DEPENDS
                xc7-${test_name}-tcl
        )

        add_custom_target(xc7-${test_name}-vivado-bit DEPENDS ${vivado_bit})

        if (enable_vivado_test)
            add_dependencies(all-xc7-validation-tests xc7-${test_name}-vivado-bit)
        else()
            add_dependencies(all-xc7-validation-tests xc7-${test_name}-fasm2bels-dcp)
        endif()
    endforeach()

endfunction()
