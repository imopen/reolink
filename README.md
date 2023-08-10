# reolink_zone.sh #

First of all, thanks to @jasonk for his inspiring script https://gist.github.com/jasonk/4772d1cd5154069cfc9eed07acb2057a 
that I simplified for my needs.

reolink_zone.sh is bash script to get, set activation zone of reolink IP cameras with https web interface (E1 zoom, E1 outdoor for example), 
with activation zones you can simply turn on and off cameras alarm, and coupled with home assistant you can arm them when at home and
disarm when not, for example.

## Setup Credentials ##

You must create a file .reolink_personal with your credential:

```bash
USER="USER"
PASS="PASS" 
declare -A CAMERA
CAMERA["room"]="192.168.1.250" 
```

## Sintax ##

```bash
reolink_zone.sh room_name [get|set] zone_name
```

## Get Zone ##

you can *get* the current zone status with get command, for example, if your camera at the moment is set with active zones, you can save this status with:

```bash
reolink_zone.sh room get enabled
```

the script will save the actual zone from (room) camera in room_enabled.json.

## Set Zone ##

Converserly you can *set* the zone with:

```bash
reolink_zone.sh room set enabled
```

the script will load the file room_enabled.json and set it to (room) camera.


## To Recap ##

Once you have saved your "enable", "disable" or "personalized" zone with get, you can switch from one to another with set.

