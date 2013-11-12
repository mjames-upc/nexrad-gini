#!/bin/csh -f
##		N0Q (High-Res Base Reflectivity, 0.5)
##		DHR (Digital Hybrid Scan Reflectivity)
##		DPA (High-Res Hourly Digital Precipitation Array)
##		DSP (High-Res Digital Storm Total Precipitation)
##		DVL (High-Res Digital Vertically Integrated Liquid)
##		HHC (Hybrid Scan Hydrometeor Classification)
##		EET (High-Res Enhanced Echo Tops)
source ~gempak/Gemenviron
setenv RADNTS ~gempak/scripts/radar_gini
if ( ! -e $GEMDATA/images/radar/NEXCOMP/1km/rad ) then
   mkdir -p $GEMDATA/images/radar/NEXCOMP/1km/rad
endif
if ( ! -e $GEMDATA/images/radar/NEXCOMP/1km/rad ) then
   echo $GEMDATA/images/radar/NEXCOMP/1km/rad does not exist
   exit
endif
cd $GEMDATA/images/radar/NEXCOMP/1km/rad

nex2gini << EOF
GRDAREA = 23;-120;47.2634;-63.5664
PROJ    = lcc/40;-100;40
KXKY    = 4736;3000
CPYFIL  = 
GFUNC   = dhr 
RADTIM  = current
RADDUR  = 30
RADFRQ  = 3
STNFIL  = 
RADMODE = pc
SATFIL  = dhr_YYYYMMDD_HHNN
COMPRESS= yes
r

GFUNC   = dpa                                                                                                                             
SATFIL  = dpa_YYYYMMDD_HHNN
r

GFUNC   = dsp 
SATFIL  = dsp_YYYYMMDD_HHNN
r

GFUNC	= dvl
SATFIL  = dvl_YYYYMMDD_HHNN
r

GFUNC	= hhc 
SATFIL  = hhc_YYYYMMDD_HHNN
r

e
EOF
