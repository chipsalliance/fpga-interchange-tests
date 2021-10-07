function(set_program program)
    # Finds and adds the program as a property to the "programs" target
    #
    # If a program is specified in the environment variables, the path
    # in the env var is used instead

    string(TOUPPER ${program} program_upper)
    string(REPLACE "-" "_" program_upper ${program_upper})
    if(DEFINED ENV{${program_upper}})
        set(${program_upper} $ENV{${program_upper}})
    else()
        find_program(${program_upper} ${program} REQUIRED)
    endif()

    set_target_properties(
        programs PROPERTIES ${program_upper} ${${program_upper}}
    )
endfunction()

function(get_python_cpu_data data_file cpu_library output_var)
    # Executes the script to retrieve the data files for the LiteX CPUs
    # and saves the output in a variable

    get_target_property(PYTHON3 programs PYTHON3)
    set(script ${PROJECT_SOURCE_DIR}/utils/get_cpu_litex_data.py)
    execute_process(
        COMMAND
            ${PYTHON3} ${script}
                --data-file ${data_file}
                --cpu-library ${cpu_library}
        OUTPUT_VARIABLE
            output
    )

    set(${output_var} ${output} PARENT_SCOPE)
endfunction()
