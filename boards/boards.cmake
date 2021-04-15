function(add_xc7_board)
    # ~~~
    # add_board(
    #    name <board name>
    #    device_family <device family>
    #    device <common device>
    #    package <package>
    #    speedgrade <speedgrade>
    # )
    # ~~~
    #
    # Generates a board target containing information on the common device and package
    # of the board.
    #
    # Arguments:
    #   - name: name of the board. E.g. arty
    #   - device_family: the name of the family this device belongs to.
    #                    E.g. the xc7a35t device belongs to the artix7 family
    #   - device: common device name of a set of parts. E.g. xc7a35tcsg324-1 and xc7a35tcpg236-1
    #             share the same xc7a35t device prefix
    #   - package: one of the packages available for a given device. E.g. cpg236
    #   - speedgrade: speedgrade of the chip. E.g -1, -2, -3
    #
    # Targets generated:
    #   - board-<name>

    set(options)
    set(oneValueArgs name device_family device package speedgrade)
    set(multiValueArgs)

    cmake_parse_arguments(
        add_xc7_board
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(name ${add_xc7_board_name})
    set(device_family ${add_xc7_board_device_family})
    set(device ${add_xc7_board_device})
    set(package ${add_xc7_board_package})
    set(speedgrade ${add_xc7_board_speedgrade})

    add_custom_target(board-${name} DEPENDS device-${device})
    set_target_properties(
        board-${name}
        PROPERTIES
            DEVICE_FAMILY ${device_family}
            DEVICE ${device}
            PACKAGE ${package}
            SPEEDGRADE ${speedgrade}
            PART ${device}${package}${speedgrade}
    )
endfunction()
