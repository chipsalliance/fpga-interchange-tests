generate_xcup_device_db(
    device xczu7ev
    part xczu7ev-ffvc1156-2-e
    device_target xczu7ev_target
)

generate_chipdb(
    family ${family}
    device xczu7ev
    part xczu7ev-ffvc1156-2-e
    device_target ${xczu7ev_target}
    device_config ${PYTHON_INTERCHANGE_PATH}/test_data/xcup_device_config.yaml
    test_package ffvc1156
)
