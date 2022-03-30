function(diff_io_test)
    set(options)
    set(oneValueArgs name)
    set(multiValueArgs boards)
    
    cmake_parse_arguments(
        diff_io_test
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(name ${diff_io_test_name})
    set(boards ${diff_io_test_boards})

    add_generic_test(
        name ${name}
        board_list ${boards}
        constr_prefix ${name}
        sources ${name}.v
        testbench ${name}_tb.v
    )
endfunction()

diff_io_test(
    name obuftds
    boards basys3
)
diff_io_test(
    name iobufds
    boards basys3
)
diff_io_test(
    name ibufds
    boards basys3 zcu104
)
diff_io_test(
    name obufds
    boards basys3 zcu104
)
