# - Find GMPXX library
# Once done, this will define
#  GMPXX_FOUND
#  GMPXX_INCLUDE_DIR
#  GMPXX_LIBRARIES
include(FindPackageHandleStandardArgs)
find_package(PkgConfig)

if (PKG_CONFIG_FOUND)
  pkg_check_modules(GREENX_GMPXX IMPORTED_TARGET GLOBAL gmpxx)
  pkg_check_modules(GREENX_GMP IMPORTED_TARGET GLOBAL gmp)
endif()

find_path(GREENX_GMPXX_INCLUDE_DIR NAMES gmpxx.h)

if(NOT GREENX_GMP_FOUND)
  find_library(GREENX_GMPXX_LIBRARIES NAMES gmpxx)
  find_library(GREENX_GMP_LIBRARIES NAMES gmp)
else()
  set(GREENX_GMPXX_LIBRARIES "${GREENX_GMPXX_LINK_LIBRARIES}")
  set(GREENX_GMP_LIBRARIES "${GREENX_GMP_LINK_LIBRARIES}")
endif()

find_package_handle_standard_args(GMPXX DEFAULT_MSG GREENX_GMPXX_INCLUDE_DIR GREENX_GMPXX_LIBRARIES GREENX_GMP_LIBRARIES)
set(GREENX_GMPXX_LIBRARIES ${GREENX_GMPXX_LIBRARIES} ${GREENX_GMP_LIBRARIES})


if (NOT TARGET greenX::gmpxx)
  add_library(greenX::gmpxx INTERFACE IMPORTED)
  set_target_properties(greenX::gmpxx
                        PROPERTIES
                        INTERFACE_LINK_LIBRARIES "${GREENX_GMPXX_LIBRARIES}")
  if (GREENX_GMPXX_INCLUDE_DIR)
    set_target_properties(greenX::gmpxx
                          PROPERTIES
                          INTERFACE_INCLUDE_DIRECTORIES ${GREENX_GMPXX_INCLUDE_DIR})
  endif()
endif()

mark_as_advanced(GREENX_GMPXX_INCLUDE_DIR GREENX_GMPXX_LIBRARIES)
