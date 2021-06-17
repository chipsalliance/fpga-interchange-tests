function(add_xc7_test)
    # ~~~
    # add_xc7_test(
    #    name <name>
    #    board <board>
    #    netlist <logical netlist>
    #    phys <physical netlist>
    #    fasm <fasm file>
    #    top <top>
    # )
    #
    # Generates targets to run xc7-specific test steps such as bitstream generation
    #
    # Arguments:
    #   - name: test name
    #   - board: name of the board
    #   - netlist: path to the generated logical netlist
    #   - phys: path to the generated physical netlist
    #   - fasm: path to the generated fasm file
    #   - top: top level module
    #
    # Targets generated:
    #   - <arch>-<name>-<board>-dcp     : dcp generation
    #   - <arch>-<name>-<board>-dcp-bit : dcp to bitstream generation
    #   - <arch>-<name>-<board>-bit     : bitstream generation

    set(options)
    set(oneValueArgs name board netlist phys fasm top)
    set(multiValueArgs sources)

    cmake_parse_arguments(
        add_xc7_test
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(name ${add_xc7_test_name})
    set(board ${add_xc7_test_board})
    set(netlist ${add_xc7_test_netlist})
    set(phys ${add_xc7_test_phys})
    set(top ${add_xc7_test_top})
    set(sources ${add_xc7_test_sources})

    set(quiet_cmd ${CMAKE_SOURCE_DIR}/utils/quiet_cmd.sh)

    get_target_property(PYTHON3 programs PYTHON3)
    get_target_property(XCFASM programs XCFASM)

    # Get board properties
    get_property(device_family TARGET board-${board} PROPERTY DEVICE_FAMILY)
    get_property(part TARGET board-${board} PROPERTY PART)
    get_property(arch TARGET board-${board} PROPERTY ARCH)

    set(test_name "${name}-${board}")
    set(xdc ${CMAKE_CURRENT_SOURCE_DIR}/${board}.xdc)
    set(run_vivado ${CMAKE_SOURCE_DIR}/utils/run_vivado.sh)

    # Bitstream generation target from DCP
    set(vivado_tcl ${CMAKE_SOURCE_DIR}/tests/common/vivado.tcl)
    set(vivado_bit ${output_dir}/${name}.vivado.bit)
    add_custom_command(
        OUTPUT ${vivado_bit}
        COMMAND ${CMAKE_COMMAND} -E env
            VIVADO_SETTINGS=${VIVADO_SETTINGS}
            OUTPUT_DIR=${output_dir}/${name}
            NAME=${name}
            PART=${part}
            TOP=${top}
            XDC=${xdc}
            SOURCES="${sources}"
            BIT_FILE=${vivado_bit}
            ${quiet_cmd}
            ${run_vivado} -mode batch -source ${vivado_tcl}
        DEPENDS
            ${run_vivado}
            ${vivado_tcl}
            ${sources}
    )

    add_custom_target(${arch}-${test_name}-vivado-bit DEPENDS ${vivado_bit})
    add_dependencies(all-vendor-bit-tests ${arch}-${test_name}-vivado-bit)
    add_dependencies(all-${device}-vendor-bit-tests ${arch}-${test_name}-vivado-bit)

    # DCP generation target
    set(dcp ${output_dir}/${name}.dcp)
    add_custom_command(
        OUTPUT ${dcp}
        COMMAND ${CMAKE_COMMAND} -E env
            RAPIDWRIGHT_PATH=${RAPIDWRIGHT_PATH}
            ${INVOKE_RAPIDWRIGHT} ${JAVA_HEAP_SPACE}
            com.xilinx.rapidwright.interchange.PhysicalNetlistToDcp
            ${netlist} ${phys} ${xdc} ${dcp}
        DEPENDS
            ${INVOKE_RAPIDWRIGHT}
            ${arch}-${test_name}-netlist
            ${arch}-${test_name}-phys
            ${netlist}
            ${phys}
            ${xdc}
    )

    add_custom_target(${arch}-${test_name}-dcp DEPENDS ${dcp})

    # Bitstream generation target from DCP
    set(dcp_vivado_tcl ${CMAKE_SOURCE_DIR}/tests/common/dcp_vivado.tcl)
    set(dcp_bit ${output_dir}/${name}.dcp.bit)
    add_custom_command(
        OUTPUT ${dcp_bit}
        COMMAND ${CMAKE_COMMAND} -E env
            VIVADO_SETTINGS=${VIVADO_SETTINGS}
            OUTPUT_DIR=${output_dir}
            DCP_FILE=${dcp}
            BIT_FILE=${dcp_bit}
            ${quiet_cmd}
            ${run_vivado} -mode batch -source ${dcp_vivado_tcl}
        DEPENDS
            ${arch}-${test_name}-dcp
            ${run_vivado}
            ${dcp_vivado_tcl}
            ${dcp}
    )

    add_custom_target(${arch}-${test_name}-dcp-bit DEPENDS ${dcp_bit})
    add_dependencies(all-vendor-bit-tests ${arch}-${test_name}-dcp-bit)
    add_dependencies(all-${device}-vendor-bit-tests ${arch}-${test_name}-dcp-bit)

    # Bitstream generation target
    set(bit ${output_dir}/${name}.bit)
    add_custom_command(
        OUTPUT ${bit}
        COMMAND ${CMAKE_COMMAND} -E env
            ${quiet_cmd}
            ${XCFASM}
                --db-root ${PRJXRAY_DB_DIR}/${device_family}
                --part ${part}
                --part_file ${PRJXRAY_DB_DIR}/${device_family}/${part}/part.yaml
                --sparse
                --emit_pudc_b_pullup
                --fn_in ${fasm}
                --bit_out ${bit}
        DEPENDS
            ${arch}-${test_name}-fasm
            ${fasm}
        )

    add_custom_target(${arch}-${test_name}-bit DEPENDS ${bit})
    add_dependencies(all-tests ${arch}-${test_name}-bit)
    add_dependencies(all-${device}-tests ${arch}-${test_name}-bit)
endfunction()

function(add_xc7_validation_test)
    # ~~~
    # add_xc7_validation_test(
    #    name <name>
    #    board_list <board>
    #    [disable_vivado_test]
    #    [testbench]
    # )
    #
    # Generates targets to run desired tests
    #
    # Arguments:
    #   - name: test name. This must be unique and no other tests with the same
    #           name should exist
    #   - board_list: list of boards, one for each test
    #   - disable_vivado_test (optional): disables the Vivado bitstream generation to run DRC checks
    #   - testbench (optional): verilog testbench to verify the correctness of the design
    #                           generated by fasm2bels
    #
    # Targets generated:
    #   - <device>-channels-db              : device database for fasm2bels
    #   - xc7-<name>-<board>-fasm2bels      : target to run fasm2bels
    #   - xc7-<name>-<board>-fasm2bels-dcp  : dcp from the fasm2bels outputs
    #   - xc7-<name>-<board>-tcl            : tcl file to run Vivado
    #   - xc7-<name>-<board>-fasm2bels-bit  : vivado-generated bitstream

    set(options disable_vivado_test)
    set(oneValueArgs name testbench)
    set(multiValueArgs board_list sources)

    cmake_parse_arguments(
        add_xc7_validation_test
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(name ${add_xc7_validation_test_name})
    set(disable_vivado_test ${add_xc7_validation_test_disable_vivado_test})
    set(testbench ${add_xc7_validation_test_testbench})

    set(quiet_cmd ${CMAKE_SOURCE_DIR}/utils/quiet_cmd.sh)

    get_target_property(PYTHON3 programs PYTHON3)
    get_target_property(YOSYS programs YOSYS)
    get_target_property(BITREAD programs BITREAD)

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
                    ${quiet_cmd}
                    ${PYTHON3} -mfasm2bels.database.create_channels
                        --db-root ${PRJXRAY_DB_DIR}/${device_family}
                        --part ${part}
                        --connection-database ${device_channels}
                )

            add_custom_target(${device}-channels-db DEPENDS ${device_channels})
        endif()

        set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/${board})
        set(bit ${output_dir}/${name}.bit)
        set(bit_target xc7-${test_name}-bit)

        # Run fasm2bels to get logical and physical netlists
        set(netlist ${output_dir}/${name}.fasm2bels.netlist)
        set(phys ${output_dir}/${name}.fasm2bels.phys)
        set(interchange_xdc ${output_dir}/${name}.fasm2bels.inter.xdc)
        set(fasm ${output_dir}/${name}.fasm2bels.fasm)
        set(verilog ${output_dir}/${name}.fasm2bels.v)
        set(xdc ${output_dir}/${name}.fasm2bels.xdc)
        add_custom_command(
            OUTPUT ${netlist} ${phys} ${xdc} ${fasm} ${interchange_xdc} ${verilog}
            COMMAND
                ${quiet_cmd}
                ${YOSYS} -p "read_json ${output_dir}/${name}.json\; write_blif ${output_dir}/${name}.eblif"
            COMMAND
                ${quiet_cmd}
                ${PYTHON3} -mfasm2bels
                    --db_root ${PRJXRAY_DB_DIR}/${device_family}
                    --part ${part}
                    --connection_database ${device_channels}
                    --bitread ${BITREAD}
                    --bit_file ${bit}
                    --fasm_file ${fasm}
                    --eblif ${output_dir}/${name}.eblif
                    --verilog_file ${verilog}
                    --input_xdc ${CMAKE_CURRENT_SOURCE_DIR}/${board}.xdc
                    --xdc_file ${xdc}
                    --logical_netlist ${netlist}
                    --physical_netlist ${phys}
                    --interchange_xdc ${interchange_xdc}
                    --interchange_capnp_schema_dir ${INTERCHANGE_SCHEMA_PATH}
            DEPENDS
                ${bit_target}
                ${device}-channels-db
                ${bit}
        )

        add_custom_target(
            xc7-${test_name}-fasm2bels
            DEPENDS
                ${netlist}
                ${phys}
                ${interchange_xdc}
                ${fasm}
                ${verilog}
                ${xdc}
        )

        # DCP generation target
        set(dcp ${output_dir}/${name}.fasm2bels.dcp)
        add_custom_command(
            OUTPUT ${dcp}
            COMMAND ${CMAKE_COMMAND} -E env
                RAPIDWRIGHT_PATH=${RAPIDWRIGHT_PATH}
                ${quiet_cmd}
                ${INVOKE_RAPIDWRIGHT} ${JAVA_HEAP_SPACE}
                com.xilinx.rapidwright.interchange.PhysicalNetlistToDcp
                ${netlist} ${phys} ${xdc} ${dcp}
            DEPENDS
                ${INVOKE_RAPIDWRIGHT}
                xc7-${test_name}-fasm2bels
        )

        add_custom_target(xc7-${test_name}-fasm2bels-dcp DEPENDS ${dcp})

        # Generate bitstream from Vivado
        set(tcl ${CMAKE_SOURCE_DIR}/tests/common/dcp_vivado.tcl)
        set(run_vivado ${CMAKE_SOURCE_DIR}/utils/run_vivado.sh)
        set(vivado_bit ${output_dir}/${name}.fasm2bels.bit)
        add_custom_command(
            OUTPUT ${vivado_bit}
            COMMAND ${CMAKE_COMMAND} -E env
                VIVADO_SETTINGS=${VIVADO_SETTINGS}
                OUTPUT_DIR=${output_dir}
                DCP_FILE=${dcp}
                BIT_FILE=${vivado_bit}
                ${quiet_cmd}
                ${run_vivado} -mode batch -source ${tcl}
            DEPENDS
                xc7-${test_name}-fasm2bels-dcp
                ${dcp}
                ${run_vivado}
                ${tcl}
        )

        add_custom_target(xc7-${test_name}-fasm2bels-bit DEPENDS ${vivado_bit})

        if(NOT ${disable_vivado_test})
            add_dependencies(all-vendor-bit-tests xc7-${test_name}-fasm2bels-bit)
            add_dependencies(all-${device}-vendor-bit-tests xc7-${test_name}-fasm2bels-bit)
        endif()

        add_dependencies(all-validation-tests xc7-${test_name}-fasm2bels-dcp)
        add_dependencies(all-${device}-validation-tests xc7-${test_name}-fasm2bels-dcp)

        if(DEFINED testbench)
            add_simulation_test(
                name fasm2bels-${name}
                board ${board}
                sources ${verilog}
                deps xc7-${test_name}-fasm2bels-dcp
                testbench ${testbench}
                simlib_dir ${XILINX_UNISIM_DIR}
                extra_libs ${XILINX_UNISIM_DIR}/../glbl.v
            )
        endif()
    endforeach()
endfunction()
