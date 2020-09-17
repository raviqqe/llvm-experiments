#!/bin/sh

set -ex

if [ $# -ne 1 ]; then
  exit 1
fi

opt \
  -S \
  -O3 \
  --enable-coroutines \
  --coro-early \
  --coro-cleanup \
  --coro-elide \
  --tailcallopt \
  --tailcallelim \
  <$1
