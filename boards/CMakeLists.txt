add_board(
    name arty35t
    device_family artix7
    device xc7a35t
    arch xc7
    package csg324
    speedgrade -1
)

add_board(
    name arty100t
    device_family artix7
    device xc7a100t
    arch xc7
    package csg324
    speedgrade -1
)

add_board(
    name arty_s7_25
    device_family spartan7
    device xc7s25
    arch xc7
    package csga324
    speedgrade -1
    no_fasm
)

add_board(
    name arty_s7_50
    device_family spartan7
    device xc7s50
    arch xc7
    package csga324
    speedgrade -1
)

add_board(
    name nexys_video
    device_family artix7
    device xc7a200t
    arch xc7
    package sbg484
    speedgrade -1
)

add_board(
    name basys3
    device_family artix7
    device xc7a35t
    arch xc7
    package cpg236
    speedgrade -1
)

add_board(
    name zybo
    device_family zynq7
    device xc7z010
    arch xc7
    package clg400
    speedgrade -1
)

add_board(
    name xc7k70t_board
    device_family kintex7
    device xc7k70t
    arch xc7
    package fbg484
    speedgrade -1
)

add_board(
    name xc7k160t_board
    device_family kintex7
    device xc7k160t
    arch xc7
    package ffg676
    speedgrade -1
    no_fasm
)

# Fake board, just to test the chip support
add_board(
    name xc7k480t_board
    device_family kintex7
    device xc7k480t
    arch xc7
    package ffg901
    speedgrade -1
    no_fasm
    no_bitstream
)

# Fake board, just to test the chip support
add_board(
    name xc7vx980t_board
    device_family virtex7
    device xc7vx980t
    arch xc7
    package ffg1926
    speedgrade -1
    no_fasm
    no_bitstream
)

add_board(
    name zcu104
    device_family zynqup
    device xczu7ev
    arch xcup
    package ffvc1156
    speedgrade -2
    part xczu7ev-ffvc1156-2-e
    no_fasm
    no_bitstream
)

add_board(
    name lifcl40evn
    device_family nexus
    device LIFCL-40
    arch nexus
    package CABGA400
    speedgrade -9
)

# Fake board to test the test architecture
add_board(
    name testboard
    device_family test
    device testarch
    arch testarch
    package test_package
    speedgrade -1
    no_fasm
    no_bitstream
)
