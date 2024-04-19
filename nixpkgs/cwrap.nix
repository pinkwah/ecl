{ lib, buildPythonPackage, setuptools_scm, six, fetchFromGitHub }:

let

  version = "1.6.6";
  name = "cwrap";

in buildPythonPackage {
  inherit version name;

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "equinor";
    repo = name;
    rev = version;
    hash = "sha256-yyEDQqbKFFKu6suts+df78kBPBB+jLtws1+oOE/ylU8=";
  };

  nativeBuildInputs = [ setuptools_scm ];
  propagatedBuildInputs = [ six ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
