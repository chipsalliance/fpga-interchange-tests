set(vexriscv_dir ${CMAKE_SOURCE_DIR}/third_party/pythondata-cpu-vexriscv_smp/pythondata_cpu_vexriscv_smp/verilog)

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
        ${vexriscv_dir}/VexRiscvLitexSmpCluster_Cc1_Iw32Is4096Iy1_Dw32Ds4096Dy1_Ldw128_Ood.v
        ${vexriscv_dir}/Ram_1w_1rs_Generic.v
    retarget ${retarget}
    failure_allowed
)

