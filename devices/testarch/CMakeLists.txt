generate_testarch_device_db(
    device testarch
    package test_package
    output_target test_arch_target
)

generate_chipdb(
    device testarch
    part testarch-test_package
    device_target ${test_arch_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/gen_device_config.yaml
    test_package test_package
)
