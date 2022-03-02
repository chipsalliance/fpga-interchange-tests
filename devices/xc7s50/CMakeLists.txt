generate_xc7_device_db(
    device xc7s50
    part xc7s50csga324-1
    device_target xc7s50_target
    family spartan7
)

generate_chipdb(
    device xc7s50
    part xc7s50csga324-1
    device_target ${xc7s50_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package csga324
)
