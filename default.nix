{ pkgs ? import <nixpkgs> {} }:

let
in pkgs.python3Packages.buildPythonPackage {
  pname = "ecl";
  version = "1.2.3";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    backward-cpp
    cmake
    fmt
    fmt.dev
    ninja
    python3Packages.scikit-build
  ];

  propagatedBuildInputs = with pkgs.python3Packages; [
    pandas
    cwrap
  ];

  doCheck = false;

  nativeCheckInputs = with pkgs.python3Packages; [
    pytestCheckHook
  ];
  checkPhase = "";

  dontUseCmakeConfigure = true;
  preConfigure = with pkgs; ''
    export CPATH=${fmt.dev}/include:${backward-cpp}/include''${CMAKE_INCLUDE_PATH:+:''${CMAKE_INCLUDE_PATH}}
    export LIBRARY_PATH=${fmt}/lib
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = "1.2.3";
}
