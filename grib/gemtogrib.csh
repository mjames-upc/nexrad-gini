#!/bin/csh -f

source /home/gempak/NAWIPS/Gemenviron

cd $GEMDATA/radar
echo In directory `pwd`

if ( -e region.nts ) then
   set SITE1=`nawk 'index($0,"GRDAREA") { n = split($0,a," ") ; printf "%s\n",a[n] } ' region.nts `

   set SITE=`echo $SITE1 | tr "[:upper:]" "[:lower:]"`
   if($?SITE) then
      echo look regional site $SITE
   endif

   set FILE=`ls -t 2[0-9][0-9][0-9][01][0-9][0-3][0-9]_reg_${SITE}.gem | head -1`

   echo FILE $FILE
   if($#FILE == 1) then
      set DATE=`echo $FILE | cut -f1 -d_`
      set REGION=${DATE}_local.gem
      if(-e $REGION) rm $REGION
      ln -s $FILE $REGION
      set RUNREGION="run"
   else
      set RUNREGION=" "
   endif
else
   set RUNREGION=" "
endif


if($?DATE) then
   echo look regional site $SITE $DATE
else
   echo no floater site
   set SITE="NONE"
endif

if ( ! -d $GEMDATA/radar/grib ) mkdir -p $GEMDATA/radar/grib
cd $GEMDATA/radar/grib
echo Now in directory `pwd`
echo `ls -alt`

set GBFILE = radar_mosaic_national
set GBFLOAT = radar_mosaic_regional
set GBFILE2 = radar_mosaic_nathr

if(-e $GBFILE) rm -f $GBFILE
if(-e $GBFLOAT) rm -f $GBFLOAT
if(-e $GBFILE2) rm -f $GBFILE2

gdgrib << EOF
 \$respond = yes
 GDFILE   = nexr
 GFUNC    = n0q
 GDATTIM  = last
 GLEVEL   = 0
 GVCORD   = none
 GBTBLS   = ;ncargrib2.tbl
 GBFILE   = $GBFILE
 VERCEN   = 2/60/1/1
 PDSVAL   = n0q%1
 PRECSN   = b/0
 WMOHDR   =  
 CPYFIL   =  
 GRDAREA  = 23.5;-120;47.305655;-63.611056
 PROJ     = lcc/40;-100;40
 KXKY     = 800;500
 r

 gfunc    = net
 pdsval   = net%1
 r

 GDFILE   = nexreg:${SITE}.gem
 GFUNC    = n0q
 PDSVAL   = n0q%1
 VERCEN   = 2/60/2/1
 GBFILE   = $GBFLOAT
 GRDAREA  =
 PROJ     =
 KXKY     =
 l

 $RUNREGION

 e
EOF

# temporary hack
set INGDFIL=`ls $GEMDATA/radar/??????????_radr.gem | tail -1`
echo GDGRIB2 file $INGDFIL
gdgrib2 << EOF2
  \$respond = yes
  GDFILE   = $INGDFIL
  GBFILE = $GBFILE2
  GFUNC    = n0q
  GDATTIM  = last
  GLEVEL   = 0
  GVCORD   = none
  PROJ     =  
  GRDAREA  =  
  KXKY     =  
  CPYFIL   =  
  G2TBLS   =  
  G2IS     = 0;2
  G2IDS    = 60;1;2;1;0;0;0
  G2PDT    = 0|15;1;;;255
  G2DRT    = 3|0|0|1|0 
  WMOHDR   =
  r
 
  e
EOF2

gpend

# <<<<<< UPC mod 20101105 - ~chiz -> /home/chiz (TCY) >>>>>
/home/chiz/gribinsert/gribinsert -v -l - -S -f NMC3 $GBFILE

if ( -e $GBFILE2 ) /home/chiz/gribinsert/gribinsert -v -l - -S -f NMC3 $GBFILE2

if ( ( -e $GBFLOAT ) && ( ! -z $GBFLOAT ) ) then
   mv $GBFLOAT ${GBFLOAT}_${SITE}
   /home/chiz/gribinsert/gribinsert -v -l - -S -f NMC3 ${GBFLOAT}_${SITE}
else
   if ( $RUNREGION == "run" ) echo "failed to generate regional grid"
endif


if ( -e $GBFILE ) rm -f $GBFILE
if ( -e ${GBFLOAT}_${SITE} ) rm -f ${GBFLOAT}_${SITE}
if ( -e $GBFILE2 ) rm -f $GBFILE2
