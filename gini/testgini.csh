#!/bin/csh -f
##		N0Q (High-Res Base Reflectivity, 0.5)
##		DHR (Digital Hybrid Scan Reflectivity)
##		DPA (High-Res Hourly Digital Precipitation Array)
##		DSP (High-Res Digital Storm Total Precipitation)
##		DVL (High-Res Digital Vertically Integrated Liquid)
##		HHC (Hybrid Scan Hydrometeor Classification)
##		EET (High-Res Enhanced Echo Tops)
source /home/gempak/NAWIPS/Gemenviron

set file = `ls ${1}_* | tail -1`

gpcolor << EOF0
COLORS  = 7=38:38:38;8=112:112:112
DEV     = gif|${1}-2.gif|1200;750
r

EOF0
gpmap << EOF
TITLE   = 1//
GAREA   = dset
PROJ    = sat
SATFIL  = ${file}
IMCBAR  = 1
LUTFIL  = default
\$mapfil = hicnus.nws + histus.nws
map = 7/1/1 + 8/1/1
r

e
EOF

gpend
rm ${file}
scp ${1}-2.gif mjames@conan:/content/staff/mjames/
