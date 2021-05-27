#!/bin/bash

set -exuo pipefail

# Please keep this comment around. It may help if this problem reoccurs.
# if [[ ${target_platform} =~ linux-* ]]; then
#   # TODO: remove this when lief's internal pybind is updated (with lief=0.10.0 probably)
#   export CXXFLAGS="${CXXFLAGS} -Wno-deprecated-declarations"
#   export CFLAGS="${CFLAGS} -Wno-deprecated-declarations"
#   # export LDFLAGS="${LDFLAGS} -Wl,--trace -Wl,--cref -Wl,--trace-symbol,_ZTIN4LIEF5MachO16BuildToolVersionE"
#   # export LDFLAGS="${LDFLAGS} -Wl,--trace-symbol,_ZTIN4LIEF5MachO16BuildToolVersionE -Wl,--trace-symbol,_ZTIN4LIEF5MachO12BuildVersionE"
# fi

mkdir build || true
pushd build

cmake -LAH -G "Ninja"  \
  -DCMAKE_BUILD_TYPE="Release"  \
  -DBUILD_STATIC_LIBS=OFF  \
  -DBUILD_SHARED_LIBS=ON  \
  -DCMAKE_SKIP_RPATH=ON  \
  -DLIEF_PYTHON_API=OFF  \
  -DLIEF_INSTALL_PYTHON=OFF  \
  ..

if [[ ! $? ]]; then
  echo "configure failed with $?"
  exit 1
fi

popd
