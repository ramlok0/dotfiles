#!/bin/bash

focus_action ()
{
    # i3-msg [title="$1"] focus
    # i3-msg [instance='"^'$1'"' title='"^'$2'"'] focus
    i3-msg [ id="$1"] focus
}
handle_dismiss ()
{
    echo "nothing"
}

i3notifyPid=$(pgrep -l i3_notify.sh | wc -l)
if [[ "$i3notifyPid" -gt 2 ]]; then
    echo "already running "$i3notifyPid
    exit
fi
# https://faq.i3wm.org/question/5721/how-do-i-subscribe-to-i3-events-using-bash-easily/index.html
# i3-msg -t subscribe -m '[ "window" ]' | jq --unbuffered -Mrc '. | select(((.change == "title") and (.container.focused
# == false) and (.container.name|test("(.*[0-9].*)"))) or (.change == "urgent" and .container.urgent == true)) | .container.name' | xargs -i -n1 /bin/bash -c '/usr/bin/notify-send -t 30000 -i filesaveas --urgency=normal "{}"; aplay /home/pc/Downloads/happy.wav'
timestamp=$(date +%s)
i3-msg -t subscribe -m '[ "window" ]' | while read -r event; do
    # echo $event
    # .container.window_properties.instance'
    res=$(jq --unbuffered -Mrc '. | select(((.change == "title") and (.container.focused == false) and (.container.name|test("\\([0-9 ]*\\)"))) or (.change == "urgent" and .container.urgent == true)) | .container.window' <<< $event)
    if [[ "$res" != "" ]]; then
	winText=$(jq --unbuffered -Mrc '.container.name' <<< $event)
	timenow=$(date +%s)
	if [[ $(expr $timenow-$timestamp) -gt 4 ]]; then
	    # device=$(aplay -l | grep "HDMI 0" | awk '{ gsub(/:/, "" ); print $2","$7}')
	    # aplay -D "hw:$device" /home/pc/Downloads/happy.wav 2&> /dev/null &
	    mpv  /home/pc/Downloads/happy.wav 2&> /dev/null &
	    # /usr/bin/notify-send -t 30000 -i filesaveas --urgency=normal "$res"
	     # "action,label"
	    ACTION=$(/home/pc/tools/dunst/dunstify --action="focus,focus" -i empathy --urgency=normal "$winText")
	    case "$ACTION" in
	    "focus")
		# focus_action "$res" "$conName"
		focus_action "$res"
		;;
	    "2")
		handle_dismiss
		;;
	    esac
	    timestamp=$(date +%s)
	fi
    fi
done

    # echo $(i3-msg -t get_workspaces | jshon -a -e urgent -u -p -e name -u -p -e focused)
	#wname=( $(i3-msg -t get_workspaces | \
		       # jshon -a -e urgent -u -p -e name -u -p -e focused | \
		       # xargs -L3 | awk '$1 ~ /true/ && $3 ~ /false/ {print $2}') )

