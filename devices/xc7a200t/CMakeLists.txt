generate_xc7_device_db(
    device xc7a200t
    part xc7a200tsbg484-1
    device_target xc7a200t_target
)

generate_chipdb(
    family ${family}
    device xc7a200t
    part xc7a200tsbg484-1
    device_target ${xc7a200t_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package sbg484
)

generate_xc7_device_with_timings(
    device xc7a200t
    input_device ${xc7a200t_target}
    output_device xc7a200t_timing_target
    family artix7
)
