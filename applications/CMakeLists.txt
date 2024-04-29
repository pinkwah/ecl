project(resdata-applications)

function(target_link_resdata target)
  target_link_libraries(${target} resdata)
  if(SKBUILD)
    set_target_properties(${target} PROPERTIES INSTALL_RPATH "$ORIGIN/..")
  endif()
  install(TARGETS ${target} RUNTIME DESTINATION python/resdata/.bin)
endfunction()

  add_executable(sum_write resdata/sum_write.cpp)
  add_executable(make_grid resdata/make_grid.c)
  add_executable(grdecl_grid resdata/grdecl_grid.c)
  add_executable(summary resdata/view_summary.cpp)
  add_executable(kw_extract resdata/kw_extract.cpp)
  target_link_resdata(sum_write)
  target_link_resdata(make_grid)
  target_link_resdata(grdecl_grid)
  target_link_resdata(summary)
  target_link_resdata(kw_extract)

  list(APPEND apps make_grid grdecl_grid summary kw_extract)

  foreach(
    app
    rd_pack
    rd_unpack
    grid_info
    grid_dump
    grid_dump_ascii
    select_test
    load_test)
    add_executable(${app} resdata/${app}.c)
    target_link_resdata(${app})
    list(APPEND apps ${app})
    if(ERT_LINUX)
      # The .x extension creates problems on windows
      set_target_properties(${app} PROPERTIES SUFFIX ".x")
    endif()
  endforeach()

  if(ERT_LINUX)
    foreach(app convert grdecl_test kw_list)
      add_executable(${app} resdata/${app}.c)
      target_link_resdata(${app})
      # The .x extension creates problems on windows
      set_target_properties(${app} PROPERTIES SUFFIX ".x")
      list(APPEND apps ${app})
    endforeach()

    set_target_properties(summary PROPERTIES SUFFIX ".x")
  endif()

  add_executable(segment_info well/segment_info.c)
  add_executable(CF_dump well/well_CF_dump.c)
  add_executable(ri_well_test well/ri_well_test.c)

  target_link_resdata(segment_info)
  target_link_resdata(CF_dump)
  target_link_resdata(ri_well_test)

  list(APPEND apps segment_info CF_dump ri_well_test)
