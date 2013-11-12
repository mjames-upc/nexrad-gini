#!/bin/csh -f
setenv PATH ~ldm/bin:${PATH}
source /home/gempak/NAWIPS/Gemenviron
#
# Note, RAWDIR is not the actual location we file to, so that pqact doesn't
# write into this directory (chiz)
# ##      Products:
# ##              DHR (High-Res Base Reflectivity, 0.5) (leave out for now because DHR)
#
# ##              DHR (Digital Hybrid Scan Reflectivity)
# ##              DPA (High-Res Hourly Digital Precipitation Array)
# ##              DSP (High-Res Digital Storm Total Precipitation)
# ##              DVL (High-Res Digital Vertically Integrated Liquid)
# ##              HHC (Hybrid Scan Hydrometeor Classification)
# ##              EET (High-Res Enhanced Echo Tops)
# ##
#
#
set RAWDIR=$GEMDATA/images/radar/NEXCOMP/1km/rad
cd $RAWDIR

if(! -e .pqinsert_stamp) then
   touch .pqinsert_stamp
   exit
else
   set DHR=`find dhr_????????_???? ! -newer .pqinsert_stamp -print`
   set DPA=`find dpa_????????_???? ! -newer .pqinsert_stamp -print`
   set DSP=`find dsp_????????_???? ! -newer .pqinsert_stamp -print`
   set DVL=`find dvl_????????_???? ! -newer .pqinsert_stamp -print`
   set HHC=`find hhc_????????_???? ! -newer .pqinsert_stamp -print`
   set EET=`find eet_????????_???? ! -newer .pqinsert_stamp -print`
endif

touch .pqinsert_stamp

if(($#DHR < 1)&&($#DPA < 1)&&($#DSP < 1)&&($#DVL < 1)&&($#HHC < 1)&&($#EET < 1)) then
   echo nothing to insert
   exit
endif

cd $GEMDATA/images

if($#DHR > 0) then
   foreach FILE ($DHR)
      pqinsert -f FNEXRAD -v -l - -p rad/NEXRCOMP/1km/$FILE $RAWDIR/$FILE
      if($status == 0) then
         rm $RAWDIR/$FILE
      else
         echo failed to insert $FILE
      endif
   end
endif

if($#DPA > 0) then
   foreach FILE ($DPA)
      pqinsert -f FNEXRAD -v -l - -p rad/NEXRCOMP/2km/$FILE $RAWDIR/$FILE
      if($status == 0) then
         rm $RAWDIR/$FILE
      else
         echo failed to insert $FILE
      endif
   end
endif

if($#DSP > 0) then
   foreach FILE ($DSP)
      pqinsert -f FNEXRAD -v -l - -p rad/NEXRCOMP/4km/$FILE $RAWDIR/$FILE
      if($status == 0) then
         rm $RAWDIR/$FILE
      else
         echo failed to insert $FILE
      endif
   end
endif

if($#DVL > 0) then
   foreach FILE ($DVL)
      pqinsert -f FNEXRAD -v -l - -p rad/NEXRCOMP/4km/$FILE $RAWDIR/$FILE
      if($status == 0) then
         rm $RAWDIR/$FILE
      else
         echo failed to insert $FILE
      endif
   end
endif


if($#HHC > 0) then
   foreach FILE ($HHC)
      pqinsert -f FNEXRAD -v -l - -p rad/NEXRCOMP/4km/$FILE $RAWDIR/$FILE
      if($status == 0) then
         rm $RAWDIR/$FILE
      else
         echo failed to insert $FILE
      endif
   end
endif

if($#EET > 0) then
   foreach FILE ($EET)
      pqinsert -f FNEXRAD -v -l - -p rad/NEXRCOMP/4km/$FILE $RAWDIR/$FILE
      if($status == 0) then
         rm $RAWDIR/$FILE
      else
         echo failed to insert $FILE
      endif
   end
endif
