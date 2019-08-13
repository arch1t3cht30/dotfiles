#!/usr/bin/env python

# Credit to racer290 for the script
# Except for making it not look absolutely hideous,
# that was all me

from getXresources import get_Xresources

import subprocess as sp
import gi
import re
import sys
# import signal
from math import floor
from collections import defaultdict
from threading import Thread
from queue import Queue
gi.require_version("Notify", "0.7")
from gi.repository import Notify

ICON_PATH = "/usr/share/icons/Vertex-Maia/status/scalable/"
MUTED_ICON = ICON_PATH + "audio-volume-muted-symbolic.svg"
HIGH_ICON = ICON_PATH + "audio-volume-high-symbolic.svg"
BRIGHTNESS_ICON = ICON_PATH + "display-brightness-symbolic.svg"
CONNECT_ICON = ICON_PATH + "network-connect.svgz"
DISCONNECT_ICON = ICON_PATH + "network-disconnect.svgz"
WIRED_ICON = ICON_PATH + "network-wired-symbolic.svgz"
WIRELESS_ICON = ICON_PATH + "network-wireless-connected-symbolic.svgz"
BAT_ICON = ICON_PATH + "battery-{}.svg"

resources = get_Xresources()
fg_filled_col = resources["notifications-color-bar-filled"]
fg_empty_col = resources["notifications-color-bar-empty"]
fg_muted_col = resources["notifications-color-muted"]

process_config = {
    "backlight": ["/usr/bin/inotifywait",
                  "/sys/class/backlight/intel_backlight/actual_brightness",
                  "-m"],
    "volume":    ["/usr/bin/pactl", "subscribe"],
    # "network":   ["/usr/bin/nmcli", "--color=no", "monitor"]
    "battery":   ["/usr/bin/inotifywait",
                  "/sys/class/power_supply/BAT0/capacity",
                  "-m"]
}
process_timeouts = {
    "backlight": 1200,
    "volume":    1200,
    # "network":   3000,
    "battery":    5000,
}

re_connected = re.compile('^(.*): connected$')
re_disconnected = re.compile('^(.*): (disconnected|unmanaged)$')
re_primary = re.compile('^\'(.*)\' is now the primary connection$')
re_no_connection = re.compile(
    '^NetworkManager is now in the \'disconnected\' state$')

q = Queue()


class SubsystemListener:

    def __init__(self, subsystem_name):
        self.name = subsystem_name
        # self.event_process = sp.Popen(
        #     ["stdbuf", "--output=L",
        #      " ".join(process_config[self.name])],
        #     bufsize=1, stdout=sp.PIPE, text=True, shell=True)
        self.event_process = sp.Popen(process_config[self.name], bufsize=1,
                                      stdout=sp.PIPE, text=True)
        self.thread = Thread(target=globals()[self.name + "_listen"],
                             args=[self.event_process.stdout, q])
        self.thread.daemon = True
        self.thread.start()
        self.notification = Notify.Notification.new(
            subsystem_name + " notifications", "", "")
        self.notification.set_timeout(process_timeouts[self.name])
        self.notification.set_app_name("system-status")

    def receive_event(self, event):
        if event["type"] != self.name:
            return
        self.notification.update(*(globals()[self.name + "_format"](event)))
        self.notification.show()

    def __del__(self):
        self.event_process.terminate()
        self.event_process.wait()


def volume_muted():
    return "[on]" not in sp.run(["amixer", "sget", "Master,0"],
                                capture_output=True, text=True).stdout


def get_volume():
    out = sp.run(["amixer", "sget", "Master,0"],
                 capture_output=True, text=True).stdout
    m = re.search(r'\[(\d+)%', out)
    val = 0
    for group in m.groups():
        val += int(group)
    return val / len(m.groups())


def volume_listen(volume_in, queue):
    prev_volume = -1 if volume_muted() else get_volume()
    for line in volume_in:
        if "sink #" not in line:
            continue
        volume = -1 if volume_muted() else get_volume()
        if volume == prev_volume:
            continue
        queue.put({"type": "volume", "value": volume})
        prev_volume = volume


def make_bar(full, length):
    """full in %, length is # of bar chars"""
    full_chars = floor(full / 100 * length)
    empty_chars = length - full_chars

    return '<span foreground="{}">{}</span><span foreground="{}">{}</span>' \
        .format(fg_filled_col, ("━" * full_chars),
                fg_empty_col, ("━" * empty_chars))


def volume_format(event):
    return (" ",
            '<span foreground="{}">Volume Muted</span>'.format(fg_muted_col)
            if event["value"] == -1
            else (make_bar(event["value"], 20)),
            MUTED_ICON if event["value"] == -1 else HIGH_ICON)


def get_brightness():
    return float(sp.run(["xbacklight"], capture_output=True, text=True).stdout)


def backlight_listen(light_in, queue):
    prev_brightness = get_brightness()
    for line in light_in:
        brightness = get_brightness()
        if int(brightness) == int(prev_brightness):
            continue
        queue.put({"type": "backlight", "value": brightness})
        prev_brightness = brightness


def backlight_format(event):
    return (" ", make_bar(get_brightness(), 20), BRIGHTNESS_ICON)


def network_listen(network_in, queue):
    for line in network_in:
        m_connected = re_connected.match(line)
        m_dc = re_disconnected.match(line)
        m_primary = re_primary.match(line)
        m_no_connection = re_no_connection.match(line)

        if m_connected:
            print("putput")
            queue.put({"type": "network", "connected": m_connected.group(1)})
        elif m_dc:
            queue.put({"type": "network", "disconnected": m_dc.group(1)})
        elif m_primary:
            queue.put({"type": "network", "primary": m_primary.group(1)})
        elif m_no_connection:
            queue.put({"type": "network", "no_connection": "dummy-value"})


def network_format(event):
    if event["connected"]:
        return (" ", "Network connected\non link " + event["connected"],
                CONNECT_ICON)
    if event["disconnected"]:
        return (" ", "Network disconnected\non link " +
                event["disconnected"], DISCONNECT_ICON)
    if event["primary"]:
        return (" ", "Primary connection\nset to " + event["primary"],
                WIRED_ICON
                if "ethernet" in get_connection_type(event["primary"])
                else WIRELESS_ICON)


def get_connection_type(name):
    return sp.run(["/usr/bin/nmcli", "--get-values=connction.type",
                   "connection", "show", "id", name],
                  capture_output=True, text=True).stdout


def get_battery_info():
    text = sp.run(["acpi"], capture_output=True, text=True).stdout
    text = text.split(": ")[1]
    text = text.split(", ")[:2]

    status = text[0]
    charge = int(text[1][:-1])

    if charge > 97:
        icon = "full"
    elif charge > 66:
        icon = "good"
    elif charge > 33:
        icon = "low"
    elif charge > 10:
        icon = "caution"
    else:
        icon = "empty-"

    icon = "{}{}-symbolic".format(icon,
                                  "-charging" if status == "Charging" else "")

    if icon == "full-charging-symbolic":
        icon = "full-charged-symbolic"

    return status, charge, BAT_ICON.format(icon)


def battery_listen(battery_in, queue):
    prev_status, prev_charge, _ = get_battery_info()
    for line in battery_in:
        status, charge, icon = get_battery_info()

        if status == "Unknown":
            continue

        if status != prev_status:
            queue.put({"type": "battery", "status": status, "charge": charge,
                       "icon": icon})
        elif any(charge <= i < prev_charge for i in [20, 10, 5, 4, 3, 2, 1]):
            queue.put({"type": "battery", "charge": charge, "icon": icon})

        prev_charge, prev_status = charge, status


def battery_format(event):
    if event["status"]:
        return (" ", "Battery " + event["status"].lower(), event["icon"])
    if event["charge"]:
        return (" ", "Battery at {}%".lower(), event["icon"])


if not Notify.init("system-status"):
    print("Could not initialize Notify for system-status",
          file=sys.stderr)

subsystems = [SubsystemListener(name) for name in process_config.keys()]

terminated = False

# def set_terminated(signum, frame): terminated = True
#
# signal.signal(signal.SIGTERM, set_terminated)
# signal.signal(signal.SIGINT, set_terminated)

while True:
    # if terminated: exit(0)
    event = q.get()
    for s in subsystems:
        s.receive_event(defaultdict(lambda: None, event))
