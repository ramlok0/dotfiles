#!/bin/bash

newWorkSpace=$(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1)
let "newWorkSpace=newWorkSpace + 1"
echo $newWorkSpace
# i3-msg workspace $newWorkSpace
i3-msg "move container to workspace number $newWorkSpace"

