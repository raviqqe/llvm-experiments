#!/bin/sh

set -ex

opt -enable-coroutines -O0 < $1 | llc
