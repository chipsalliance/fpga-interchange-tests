generate_xc7_device_db(
    device xc7a35t
    part xc7a35tcsg324-1
    device_target xc7a35t_target
    family artix7
)

generate_chipdb(
    device xc7a35t
    part xc7a35tcsg324-1
    device_target ${xc7a35t_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/series7_device_config.yaml
    test_package csg324
)
