#!/bin/bash
if [[ "$1" == "" ]]; then
  exit
fi

ffmpeg -i "$1" "$1".png
