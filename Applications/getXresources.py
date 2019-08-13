import subprocess as sp
import re

# Credit to racer290 for the script
# Except for making it not look absolutely hideous,
# that was all me


def get_Xresources():
    resources_raw = sp.run(["xrdb", "-query"],
                           universal_newlines=True, capture_output=True).stdout
    resources = {}
    pattern = re.compile(r':\s*')

    for resource in resources_raw.split("\n"):
        if len(resource) == 0:
            continue
        if resource[0] == "*":
            resource = resource[1:]
        split_resource = pattern.split(resource)
        resources[split_resource[0]] = split_resource[1]

    return resources
