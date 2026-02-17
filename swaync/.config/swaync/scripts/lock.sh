#!/usr/bin/bash

path="${HOME}/background/"
pic="$(ls $path | shuf -n 1)"

swaylock --image $path/$pic
