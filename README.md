# reolink_zone.sh #

First of all, thanks to @jasonk for his inspiring script https://gist.github.com/jasonk/4772d1cd5154069cfc9eed07acb2057a 
that I just simplified for my needs.

reolink_zone.sh is bash script to get, set zone of reolink https cameras (E1 zoom, E1 outdoor for example), 
with zones you can simply activate or deactivate cameras, and coupled with home assistant you can turn on alarm when at home and
disabled alarm when not, for example.

## Setup Credential ##

You must create a file .reolink_personal with your credential:

```bash
USER="USER"
PASS="PASS" 
declare -A CAMERA
CAMERA["room"]="192.168.1.250" 
```

## Get zone ##

you can get the current zone status with:

```bash
reolink_zone.sh room get zone_name
```

for example, if your camera at the moment is set with active zones, you can save this status with:


```bash
reolink_zone.sh room get enabled
```

the script will save the actual zone from (room) camera in room_enabled.json.

## Set zone ##

Converserly you can set the zone with:

```bash
reolink_zone.sh room set enabled
```

the script will load the file room_enabled.json and set it to (room) camera.


## Recap ##

Once you save your enabled, disable, personalized zone with get, you can switch from one to another with set.

