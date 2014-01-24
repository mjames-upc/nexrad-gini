#!/bin/csh -f
##	94	N0Q (High-Res Base Reflectivity, 0.5)
##	32	DHR (Digital Hybrid Scan Reflectivity)
##	81	DPA (High-Res Hourly Digital Precipitation Array)
##	138	DSP (High-Res Digital Storm Total Precipitation)
##	134	DVL (High-Res Digital Vertically Integrated Liquid)
##	177	HHC (Hybrid Scan Hydrometeor Classification)
##	135	EET (High-Res Enhanced Echo Tops)
#source ~/gempak/Gemenviron
source /home/gempak/GEMPAK6.10/Gemenviron
if ( ! -e $GEMDATA/nexrad/NEXCOMP/1km/rad ) then
   mkdir -p $GEMDATA/nexrad/NEXCOMP/1km/rad
endif
if ( ! -e $GEMDATA/nexrad/NEXCOMP/1km/rad ) then
   echo $GEMDATA/nexrad/NEXCOMP/1km/rad does not exist
   exit
endif
#cd $GEMDATA/nexrad/NEXCOMP/1km/rad

nex2gini << EOF
GRDAREA = 23;-120;47.2634;-63.5664
PROJ    = lcc/40;-100;40
KXKY    = 4736;3000 
KXKY    = 2368;1500
CPYFIL  = 
GFUNC   = ${1} 
RADTIM  = current
RADDUR  = 30
RADFRQ  = 0 
STNFIL  = 
RADMODE = 
SATFIL  = $GEMDATA/nexrad/NEXCOMP/1km/rad/${1}_YYYYMMDD_HHNN
SATFIL  = ${1}_YYYYMMDD_HHNN
COMPRESS= yes
r

e
EOF
