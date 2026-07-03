#!/usr/bin/env bash

# Intentionally broken for Lesson 18.
input=$1
for file in $(find ../logs -name *.log); do
  echo Processing $file
  grep ERROR $file >> ../out/broken-errors.txt
done
echo Done reading $input
