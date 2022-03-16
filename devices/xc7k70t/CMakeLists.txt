generate_xc7_device_db(
    device xc7k70t
    part xc7k70tfbg484-1
    device_target xc7k70t_target
)

generate_chipdb(
    device xc7k70t
    part xc7k70tfbg484-1
    device_target ${xc7k70t_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package fbg484
)
