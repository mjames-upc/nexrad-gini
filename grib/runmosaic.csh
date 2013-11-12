#!/bin/csh -f

##
## A simple script, imports mosaic.nts and runs gdradr
##

source ~gempak/NAWIPS/Gemenviron

limit coredumpsize unlimited

setenv RADNTS ~/scripts/grib
cd $GEMDATA/radar

while (1 == 1)

gdradr << EOF
 restore $RADNTS/mosaic.nts
 r

 e
EOF

sleep 30

end
