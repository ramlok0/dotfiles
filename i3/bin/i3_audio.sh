#!/bin/bash

pnMixerPid=$(pgrep -l pnmixer | wc -l)
if [[ "$pnMixerPid" -eq 0 ]]; then
  pnmixer &
fi
