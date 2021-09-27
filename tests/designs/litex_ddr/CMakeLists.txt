set(vexriscv ${CMAKE_SOURCE_DIR}/third_party/pythondata-cpu-vexriscv/pythondata_cpu_vexriscv/verilog/VexRiscv.v)
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
    loc_idelayctrl
)

add_generic_test(
    name litex_ddr
    board_list arty35t
    top digilent_arty
    built_sources
        digilent_arty/gateware/digilent_arty.v
    absolute_sources ${vexriscv}
    generated_xdc ${arty_gateware_dir}/digilent_arty.xdc
    retarget ${retarget}
    failure_allowed
)

