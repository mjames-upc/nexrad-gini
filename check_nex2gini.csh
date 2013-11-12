#!/bin/csh -f

##
## check_nex2gini.csh - checks status of three scripts: rungini.csh, runn1p.csh, runntp.csh
##
## update 09/2009 - M. James - changed mailx addy to mjames from yoksas
## update 11/2013 - M. James
##	Products:
##		N0Q (High-Res Base Reflectivity, 0.5)
##		DHR (Digital Hybrid Scan Reflectivity)
##		DPA (High-Res Hourly Digital Precipitation Array)
##		DSP (High-Res Digital Storm Total Precipitation)
##		DVL (High-Res Digital Vertically Integrated Liquid)
##		HHC (Hybrid Scan Hydrometeor Classification)
##		EET (High-Res Enhanced Echo Tops)
##
setenv PATH .:${PATH}
setenv RADAR_GINI ~gempak/scripts/gini
set ISRUNNING=0
foreach radar_id ( `ps -u $USER -o pid,args | grep rungini.csh | grep -v grep | awk '{ print $1 }'` )
	set ISRUNNING=1
end

if($ISRUNNING == 1) then
   if(-e /tmp/.gininex) rm -f /tmp/.gininex
else
   echo "gini NEXRAD composite generation has stopped" | /usr/bin/mailx -s "help nex2gini" mjames@unidata.ucar.edu
   if(! -e /tmp/.gininex) then
      set COUNT=0
   else
      set COUNT=`tail -1 /tmp/.gininex`
   endif
   rm -f /tmp/.gininex

   @ COUNT = $COUNT + 1

   if($COUNT < 3) then
      echo $COUNT >! /tmp/.gininex
   else
      set DATE=`date -u`
      $RADAR_GINI/rungini.csh >& /dev/null &
   endif
endif

