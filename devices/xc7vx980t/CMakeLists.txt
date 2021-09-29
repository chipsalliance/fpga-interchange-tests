generate_xc7_device_db(
    device xc7vx980t
    part xc7vx980tffg1926-1
    device_target xc7vx980t_target
)

generate_chipdb(
    device xc7vx980t
    part xc7vx980tffg1926-1
    device_target ${xc7vx980t_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package ffg1926
)
