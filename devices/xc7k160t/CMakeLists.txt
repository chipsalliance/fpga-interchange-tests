generate_xc7_device_db(
    device xc7k160t
    part xc7k160tffg676-1
    device_target xc7k160t_target
)

generate_chipdb(
    device xc7k160t
    part xc7k160tffg676-1
    device_target ${xc7k160t_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package ffg676
)
