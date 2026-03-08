# Flameshot with GNOME Wayland clipboard fix
# Built from master branch which includes
# Fix copy failure on GNOME via GUI
# https://github.com/flameshot-org/flameshot/pull/4363
# which fixes:
# flameshot-org/flameshot#4298: "Screenshot copying to clipboard doesn't work"
# https://github.com/flameshot-org/flameshot/issues/4298
#
# This can be removed once nixpkgs updates flameshot past v13.3.0

{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      flameshot = prev.flameshot.overrideAttrs (old: {
        version = "master-2025-01-06";
        src = prev.fetchFromGitHub {
          owner = "flameshot-org";
          repo = "flameshot";
          rev = "bee989ec55e7034a782fd18bd4e694b74a62ac32";
          hash = "sha256-/Bq9/wqGEwkxmiXG8N220flBnoybm0/xVVC0pDkf7jw=";
        };
        patches = [];
        postPatch = ''
          substituteInPlace CMakeLists.txt \
            --replace-fail \
              '# Dependency can be fetched via flatpak builder
if(EXISTS "''${CMAKE_SOURCE_DIR}/external/Qt-Color-Widgets/CMakeLists.txt")
  add_subdirectory("''${CMAKE_SOURCE_DIR}/external/Qt-Color-Widgets" EXCLUDE_FROM_ALL)
else()
  FetchContent_Declare(
    qtColorWidgets
    GIT_REPOSITORY https://gitlab.com/mattbas/Qt-Color-Widgets.git
    GIT_TAG 352bc8f99bf2174d5724ee70623427aa31ddc26a
  )
  #Workaround for duplicate GUID in windows WIX installer
  if(WIN32)
    FetchContent_GetProperties(qtColorWidgets)
    if(NOT qtcolorwidgets_POPULATED)
      FetchContent_Populate(qtColorWidgets)
      add_subdirectory(''${qtcolorwidgets_SOURCE_DIR} ''${qtcolorwidgets_BINARY_DIR} EXCLUDE_FROM_ALL)
    endif()
  else()
    FetchContent_MakeAvailable(qtColorWidgets)
  endif()
endif()' \
              'find_package(QtColorWidgets REQUIRED)'
        '';
      });
    })
  ];
}
