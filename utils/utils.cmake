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
