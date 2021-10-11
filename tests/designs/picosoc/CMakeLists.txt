set(picosoc_dir ${CMAKE_SOURCE_DIR}/third_party/picosoc)
set(picosoc_sources
    ${picosoc_dir}/picosoc_noflash.v
    ${picosoc_dir}/picorv32.v
    ${picosoc_dir}/progmem.v
    ${picosoc_dir}/simpleuart.v
)

add_generic_test(
    name picosoc
    board_list arty35t
    top top
    absolute_sources ${picosoc_dir}/arty35t.v ${picosoc_sources}
)

add_generic_test(
    name picosoc
    board_list basys3
    top top
    absolute_sources ${picosoc_dir}/basys3.v ${picosoc_sources}
)
