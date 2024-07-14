#!/usr/bin/env zsh

set -eu

SCRIPT_DIT=$(cd "$(dirname "$0")"; pwd)
cd "$SCRIPT_DIT"
              
swift format --in-place ./Package.swift

swift format --in-place ./Sources/Hex/Data+Hex.swift
swift format --in-place ./Sources/Hex/Sequence+Hex.swift

swift format --in-place ./Sources/Hex/Data+HexTests.swift
swift format --in-place ./Sources/Hex/Sequence+HexTests.swift
