#!/usr/bin/bash

set -e

~/Applications/lock.sh ; systemctl hibernate || killall i3lock
