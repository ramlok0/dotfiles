#!/bin/bash

newWorkSpace=$(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1)
let "newWorkSpace=newWorkSpace + 1"
echo $newWorkSpace
i3-msg "move container to workspace number $newWorkSpace"
i3-msg workspace $newWorkSpace, focus

# i3-msg "move container to workspace number $newWorkSpace"
# i3-msg "move scratchpad --role=scratch"
# 
	# 
	# 
# jolmg on Feb 26, 2019 [–]
# 
# Honestly, I don't like scratchpad. If you use it on multiple windows, doing `scratchpad show` multiple times causes one window to appear, then disappear, then next window appear, then disappear... and it does this across workspaces. I don't understand when I'd need something like that. It's a weird feature.
# 
# Instead, something I really wanted was to be able to toggle the hiding and showing of all floating windows per workspace. It sometimes happens that I just want to work with floating windows for a while, and the number of windows explodes, and I end up with all these floating windows on top of my tiled windows. Using i3 with the default configuration, I had to manually move all floating windows out of the way to get to the tiling windows below, and then move them back when I wanted to work with them again. That was cumbersome, so I did this:
# 
# bindsym $mod+Tab exec "current_workspace=\\"$(i3-msg -t get_tree | jq -r 'recurse(.nodes[]) | select(.type == \\"workspace\\" and ([recurse((.nodes, .floating_nodes)[])] | any(.focused))) | .name')\\"; floating_workspace=\\"F${current_workspace%:*}\\"; if i3-msg -t get_tree | jq -e \\"recurse(.nodes[]) | select(.type == \\\\"workspace\\\\" and .name == \\\\"$current_workspace\\\\") | .floating_nodes | length > 0\\"; then i3 \\"[workspace=$current_workspace floating] move to workspace $floating_workspace\\"; else i3 \\"[workspace=$floating_workspace floating] move to workspace $current_workspace\\"; fi"
# 
# Now, I just press Super+Tab and all floating windows on workspace e.g. 6:some-topic get moved to new workspace F6, and when I press it again they're moved back to 6:some-topic, right where they were. This is workspace independent; the windows belong to a workspace. I can hide the floating windows of however many workspace I want and call them back and they won't get mixed.
# 
# I think it's pretty cool that i3's configuration and tooling allow for this kind of advanced configuration. It's like I added a whole new feature.
# 
	# 
	# 
# wasted_intel on Feb 26, 2019 [–]
# 
# > If you use it on multiple windows, doing `scratchpad show` multiple times causes one window to appear, then disappear, then next window appear, then disappear... and it does this across workspaces.
# 
# You need to create a keybinding that calls `scratchpad show` using a window class qualifier to target the app you want. That's the key to making the scratchpad useful.
# 
	# 
	# 
# vivab0rg on Feb 27, 2019 [–]
# 
# I've been using i3 for years but somehow I missed the scratchpad. It does sound like a time-saver. Thanks for your tips!
# 
	# 
	# 
# p2t2p on Feb 26, 2019 [–]
# 
# bindsym $mod+grave for_window [class=“st-256color”] scratchpad show
# 
# Problem solved! Here is your quake terminal toggle.
