function(add_board)
    # ~~~
    # add_board(
    #    name <board name>
    #    device_family <device family>
    #    device <common device>
    #    arch <arch>
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
    #   - arch: architecture name: e.g. xc7, nexus, etc.
    #   - package: one of the packages available for a given device. E.g. cpg236
    #   - speedgrade: speedgrade of the chip. E.g -1, -2, -3
    #   - part: the full vendor part name, if it's not of the form <device><package><speedgrade>
    #
    # Targets generated:
    #   - board-<name>

    set(options)
    set(oneValueArgs name device_family device arch package speedgrade part)
    set(multiValueArgs)

    cmake_parse_arguments(
        add_board
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(name ${add_board_name})
    set(device_family ${add_board_device_family})
    set(device ${add_board_device})
    set(arch ${add_board_arch})
    set(package ${add_board_package})
    set(speedgrade ${add_board_speedgrade})
    set(part ${add_board_part})

    if ("${part}" STREQUAL "")
        set(part ${device}${package}${speedgrade})
    endif()

    add_custom_target(board-${name} DEPENDS device-${device})
    set_target_properties(
        board-${name}
        PROPERTIES
            DEVICE_FAMILY ${device_family}
            DEVICE ${device}
            ARCH ${arch}
            PACKAGE ${package}
            SPEEDGRADE ${speedgrade}
            PART ${part}
    )
endfunction()
