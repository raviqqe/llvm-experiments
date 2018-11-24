#!/bin/sh

set -ex

for file in *.ll
do
	scripts/compile.sh $file
done
