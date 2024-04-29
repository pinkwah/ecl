import os
from setuptools import find_packages
from skbuild import setup


# Corporate networks tend to be behind a proxy server with their own non-public
# SSL certificates. Conan keeps its own certificates, whose path we can override
if "CONAN_CACERT_PATH" not in os.environ:
    # Look for a RHEL-compatible system-wide file
    for file_ in ("/etc/pki/tls/cert.pem",):
        if not os.path.isfile(file_):
            continue
        os.environ["CONAN_CACERT_PATH"] = file_
        break


setup(
    packages=find_packages(where="python", exclude=("tests",)),
    package_dir={"": "python"},
    cmake_args=[
        "-DBUILD_TESTS=OFF",
        "-DUSE_CONAN=OFF",
        # we can safely pass OSX_DEPLOYMENT_TARGET as it's ignored on
        # everything not OS X. We depend on C++11, which makes our minimum
        # supported OS X release 10.9
        "-DCMAKE_OSX_DEPLOYMENT_TARGET=10.9",
    ],
)
