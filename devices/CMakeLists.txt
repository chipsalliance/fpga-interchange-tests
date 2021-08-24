# A cutom target which gathers all device data preparation targets
add_custom_target(all-device-data)

# Artix-7 devices
add_subdirectory(xc7a35t)
add_subdirectory(xc7a100t)
add_subdirectory(xc7a200t)

# Zynq-7 devices
add_subdirectory(xc7z010)

# Zynq UltraScale+ devices
add_subdirectory(xczu7ev)

# Nexus devices
add_subdirectory(LIFCL-17)
add_subdirectory(LIFCL-40)
