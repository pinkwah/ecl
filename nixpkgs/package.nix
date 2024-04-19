{ lib, src, buildPythonPackage, callPackage, scikit-build, setuptools_scm
, fmt, backward-cpp, ninja, cmake, pytest, pybind11, numpy, pandas }:

let

  cwrap = callPackage ./cwrap.nix { };
  name = "resdata";
  version = "0.0.0";

in buildPythonPackage {
  inherit name version src;

  format = "pyproject";

  nativeBuildInputs =
    [ scikit-build setuptools_scm cmake backward-cpp fmt.dev ninja pybind11 ];
  propagatedBuildInputs = [ cwrap fmt numpy pandas ];
  # checkInputs = [ pytest ];

  CMAKE_PREFIX_PATH = "${fmt.dev}:${backward-cpp}";

  dontUseCmakeConfigure = true;
  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  # checkPhase = ''
  #   python -m pytest $src/tests
  # '';
}
