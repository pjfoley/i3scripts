#!/bin/bash

MAX_DESKTOPS=20

WORKSPACES=$(seq -s '\n' 1 1 ${MAX_DESKTOPS})

EMPTY_WORKSPACE=$( (i3-msg -t get_workspaces | tr ',' '\n' | grep num | awk -F:  '{print int($2)}' ; \
            echo -e ${WORKSPACES} ) | sort -n | uniq -u | head -n 1)

CONFIG_FILE=$HOME/.i3/config
if [ -f $CONFIG_FILE ]; then
	grep "set \$w" $CONFIG_FILE
	if [ $? -eq 0 ]; then
		NAMED_EMPTY_WORKSPACE=$(grep "set \$w" $CONFIG_FILE | grep $EMPTY_WORKSPACE | awk '{print $3,$4}')
	else
		NAMED_EMPTY_WORKSPACE=$EMPTY_WORKSPACE
	fi
else
	NAMED_EMPTY_WORKSPACE=$EMPTY_WORKSPACE
fi

i3-msg workspace ${NAMED_EMPTY_WORKSPACE}
