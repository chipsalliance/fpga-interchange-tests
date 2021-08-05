function(diff_io_test name)
    add_generic_test(
        name ${name}
        board_list basys3
        constr_prefix ${name}
        sources ${name}.v
        testbench ${name}_tb.v
    )
endfunction()

diff_io_test(obuftds)
diff_io_test(obufds)
diff_io_test(ibufds)
diff_io_test(iobufds)
