get_python_cpu_data(
    VexRiscv.v
    pythondata_cpu_vexriscv
    vexriscv
)

set(arty_gateware_dir ${CMAKE_CURRENT_BINARY_DIR}/digilent_arty/gateware)

set(retarget ${CMAKE_SOURCE_DIR}/tests/common/retarget_xc7.v)

add_litex_test(
    litex_board digilent_arty
    generated_sources
        digilent_arty.v
        digilent_arty.xdc
    flags
        --cpu-type vexriscv
        --cpu-variant minimal
        --sys-clk-freq 50e6
        --integrated-main-ram-size 0x1000
)

add_generic_test(
    name litex_base
    board_list arty35t
    top digilent_arty
    built_sources
        digilent_arty/gateware/digilent_arty.v
    absolute_sources ${vexriscv}
    generated_xdc ${arty_gateware_dir}/digilent_arty.xdc
    retarget ${retarget}
    failure_allowed
)

