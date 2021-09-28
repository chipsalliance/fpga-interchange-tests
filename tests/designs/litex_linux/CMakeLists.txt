get_python_cpu_data(
    VexRiscvLitexSmpCluster_Cc1_Iw32Is4096Iy1_Dw32Ds4096Dy1_Ldw128_Ood.v
    pythondata_cpu_vexriscv_smp
    vexriscv
)

get_python_cpu_data(
    Ram_1w_1rs_Generic.v
    pythondata_cpu_vexriscv_smp
    ram
)

set(retarget ${CMAKE_SOURCE_DIR}/tests/common/retarget_xc7.v)

# TODO: add capability to build designs from https://github.com/litex-hub/linux-on-litex-vexriscv
#add_litex_test(
#    litex_board digilent_arty
#    generated_sources
#        digilent_arty.v
#        digilent_arty.xdc
#    flags
#        --cpu-type vexriscv
#        --cpu-variant linux
#        --sys-clk-freq 50e6
#        --with-ethernet
#        --uart-baudrate 1000000
#    loc_idelayctrl
#)

add_generic_test(
    name litex_linux
    board_list arty35t
    top arty
    sources
        arty.v
    absolute_sources
        ${vexriscv}
        ${ram}
    retarget ${retarget}
    failure_allowed
)

