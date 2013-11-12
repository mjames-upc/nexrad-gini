#!/bin/csh -f
##		N0Q (High-Res Base Reflectivity, 0.5)
##		DHR (Digital Hybrid Scan Reflectivity)
##		DPA (High-Res Hourly Digital Precipitation Array)
##		DSP (High-Res Digital Storm Total Precipitation)
##		DVL (High-Res Digital Vertically Integrated Liquid)
##		HHC (Hybrid Scan Hydrometeor Classification)
##		EET (High-Res Enhanced Echo Tops)
source ~gempak/Gemenviron

set file = `find ./ -name "${1}_*"`

gpmap << EOF
PROJ    = sat
GAREA   = dset
SATFIL  = ${file}
IMCBAR  = 1
LUTFIL  = default
DEV     = gif|${1}.gif|900;900
r

e
EOF

gpend
