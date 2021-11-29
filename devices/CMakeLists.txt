# A cutom target which gathers all device data preparation targets
add_custom_target(all-device-data)

# Artix-7 devices
add_subdirectory(xc7a35t)
add_subdirectory(xc7a100t)
add_subdirectory(xc7a200t)

# Spartan-7 devices
add_subdirectory(xc7s25)
add_subdirectory(xc7s50)

# Zynq-7 devices
add_subdirectory(xc7z010)

# Zynq UltraScale+ devices
add_subdirectory(xczu7ev)

# Kintex-7 devices
add_subdirectory(xc7k480t)

# Viterx-7 devices
add_subdirectory(xc7vx980t)

# Nexus devices
add_subdirectory(LIFCL-17)
add_subdirectory(LIFCL-40)

# Test architectures
add_subdirectory(testarch)
add_subdirectory(testarch-noffmux)
