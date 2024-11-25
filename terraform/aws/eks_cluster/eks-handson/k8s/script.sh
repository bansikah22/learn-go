#!/bin/bash
# Create folders from 0-example to 9-example
for i in {0..9}; do
  mkdir "${i}-example"
  #rm -rf "${i}-example"
done