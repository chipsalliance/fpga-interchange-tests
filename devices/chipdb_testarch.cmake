function(generate_testarch_device_db)
    # ~~~
    # create_testarch_device_db(
    #    device <common device>
    #    package <package>
    #    output_target <output device target>
    # )
    # ~~~
    #
    # Generates a device database from the python test architecture generator
    #
    # If output_target is specified, the output_target_name variable
    # is set to the generated output_device_file target.
    #
    # Arguments:
    #   - device: common device name of a set of parts. E.g. xc7a35tcsg324-1 and xc7a35tcpg236-1
    #             share the same xc7a35t device prefix
    #   - package: one among the parts available for a given package
    #   - output_target: variable name that will hold the output device target for the parent scope
    #
    # Targets generated:
    #   - rapidwright-<device>-device

    set(options)
    set(oneValueArgs device package output_target)
    set(multiValueArgs)

    cmake_parse_arguments(
        create_testarch_device_db
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(device ${create_testarch_device_db_device})
    set(package ${create_testarch_device_db_package})
    set(output_target ${create_testarch_device_db_output_target})

    get_target_property(PYTHON3 programs PYTHON3)

    set(out_file ${CMAKE_CURRENT_BINARY_DIR}/${device}.device)
    add_custom_command(
        OUTPUT ${out_file}
        COMMAND
            ${PYTHON3} -mfpga_interchange.testarch_generators.generate_testarch
                --schema-dir ${INTERCHANGE_SCHEMA_PATH}
                --out-file ${out_file}
                --package ${package}
    )

    add_custom_target(testarch-${device}-device DEPENDS ${out_file})
    set_property(TARGET testarch-${device}-device PROPERTY LOCATION ${out_file})

    add_custom_target(testarch-${device}-device-json
        COMMAND
            ${PYTHON3} -mfpga_interchange.convert
                --schema_dir ${INTERCHANGE_SCHEMA_PATH}
                --schema device
                --input_format capnp
                --output_format json
                ${out_file}
                ${out_file}.json
        DEPENDS ${out_file})


    if (DEFINED output_target)
        set(${output_target} testarch-${device}-device PARENT_SCOPE)
    endif()
endfunction()
