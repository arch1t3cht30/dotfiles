while read -r line; do
    DISP=$(echo $line | awk '{print $11}')
    if [[ -z "$DISP" ]]; then
        continue
    fi

    export DISPLAY=$DISP

    i3-nagbar -t warning -m 'Really shut down?' -b 'Yes' 'poweroff'
done <<< $(w | grep $(whoami))
