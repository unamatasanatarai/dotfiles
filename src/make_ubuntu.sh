#!/usr/bin/env bash

echo "Will produce a runnable ubuntu file from sources"

cat utils.sh ubuntu.sh > ../ubuntu.sh
chmod +x ../ubuntu.sh

echo " [✔]"
