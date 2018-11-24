#!/bin/sh

set -ex

opt -enable-coroutines -O0 -S < $1 | llc
