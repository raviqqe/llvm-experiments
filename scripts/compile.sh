#!/bin/sh

set -ex

if [ $# -ne 1 ]; then
  exit 1
fi

opt -enable-coroutines -O0 <$1 | llc
