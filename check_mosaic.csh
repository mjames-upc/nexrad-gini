#!/bin/csh -f

## check_mosaic.csh
## if runmosaic.csh is not running, this script will reactivate it
## located at ~/scripts/grib/runmosaic.csh

setenv PATH .:${PATH}
set ISRUNNING=0

## check process list
foreach radar_id ( `ps -u $USER -o pid,args | grep runmosaic.csh | grep -v grep | awk '{ print $1 }'` )
	set ISRUNNING=1
        #echo look radar_id $radar_id
end

## if running, everything is cool, so remove .mosaiccheck and exit this script
if($ISRUNNING == 1) then
   if(-e /tmp/.mosaiccheck) rm -f /tmp/.mosaiccheck
   exit 0
endif

echo "radar mosaic generation has stopped" | /usr/bin/mailx -s "help gdradr" mjames@unidata.ucar.edu

if(! -e /tmp/.mosaiccheck) then
   set COUNT=0
else
   set COUNT=`tail -1 /tmp/.mosaiccheck`
endif
rm -f /tmp/.mosaiccheck

## if not running, make sure to check three times before continuing
@ COUNT = $COUNT + 1

if($COUNT < 3) then
   echo $COUNT >! /tmp/.mosaiccheck
   exit 0
endif

set DATE=`date -u`
echo "restart radar mosaic" | /usr/bin/mailx -s "restart radar mosaic" mjames@unidata.ucar.edu

## So now it needs to be started again... run ~/scripts/grib/runmosaic.csh
cd ~/scripts/grib
runmosaic.csh >& /dev/null &
