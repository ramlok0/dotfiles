#!/bin/bash

pnMixerPix=$(pgrep -l pnmixer)
pnMixerPid=$(pgrep -l pnmixer | wc -l)
echo $pnMixerPix
echo $pnMixerPid
if [[ "$pnMixerPid" -eq 0 ]]; then
  pnmixer &
fi
