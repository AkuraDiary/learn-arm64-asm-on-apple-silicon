#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"
src="src/${filename%}.s"
obj="build/${filename}.o"
out="build/out/${filename%.o}"

as "$src" -o "$obj"
ld -e _start "$obj" -o "$out"
"$out"
