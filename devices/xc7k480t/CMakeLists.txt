generate_xc7_device_db(
    device xc7k480t
    part xc7k480tffg901-1
    device_target xc7k480t_target
)

generate_chipdb(
    device xc7k480t
    part xc7k480tffg901-1
    device_target ${xc7k480t_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package ffg901
)
