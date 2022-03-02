generate_xc7_device_db(
    device xc7s25
    part xc7s25csga324-1
    device_target xc7s25_target
    family spartan7
)

generate_chipdb(
    device xc7s25
    part xc7s25csga324-1
    device_target ${xc7s25_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package csga324
)
