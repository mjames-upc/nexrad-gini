#!/bin/csh -f
##		N0Q (High-Res Base Reflectivity, 0.5)
##		DHR (Digital Hybrid Scan Reflectivity)
##		DPA (High-Res Hourly Digital Precipitation Array)
##		DSP (High-Res Digital Storm Total Precipitation)
##		DVL (High-Res Digital Vertically Integrated Liquid)
##		HHC (Hybrid Scan Hydrometeor Classification)
##		EET (High-Res Enhanced Echo Tops)
source /machine/gempak/GEMPAK6.10/Gemenviron

set file = `find ./ -name "${1}_*"`

gpmap << EOF
GAREA   = dset
PROJ    = sat
SATFIL  = ${file}
IMCBAR  = 1/////10
LUTFIL  = default
DEV     = gif|${1}-2.gif|1200;750
\$mapfil = hicnus.nws
r

e
EOF

gpend
scp ${1}-2.gif mjames@conan:/content/staff/mjames/
