function(dram_tests dram_num_instances dram_mode)
    add_generic_test(
        name dram_${dram_num_instances}_${dram_mode}
        board_list basys3
        sources dram_${dram_num_instances}_${dram_mode}.v
    )
endfunction()

function(dram_tests_diff dram_num_instances dram_mode)
    add_generic_test(
        name dram_${dram_num_instances}_${dram_mode}_diff
        board_list zcu104
        sources dram_${dram_num_instances}_${dram_mode}.v dram_${dram_num_instances}_${dram_mode}_diff.v
        top top_diff
    )
endfunction()

# dram_tests(<dram_num_instances> <dram_mode>)
dram_tests(4 32x1s)
dram_tests(8 32x1s)
dram_tests(2 32x1d)
dram_tests(4 32x2s)
dram_tests(2 64x1d)
dram_tests(4 64x1s)
dram_tests(2 128x1s)
dram_tests(1 128x1d)
dram_tests(1 256x1s)
dram_tests(1 32m)
dram_tests(1 64m)

dram_tests_diff(4 32x1s)
dram_tests_diff(8 32x1s)
dram_tests_diff(2 32x1d)
dram_tests_diff(4 32x2s)
# FIXME: Yosys error
#dram_tests_diff(1 32x16dr8)
dram_tests_diff(1 32m)
dram_tests_diff(1 32m16)
dram_tests_diff(4 64x1s)
dram_tests_diff(1 64x8sw)
dram_tests_diff(2 64x1d)
dram_tests_diff(1 64m)
dram_tests_diff(1 64m8)
dram_tests_diff(2 128x1s)
dram_tests_diff(1 128x1d)
dram_tests_diff(1 256x1s)
dram_tests_diff(1 256x1d)
dram_tests_diff(1 512x1s)
