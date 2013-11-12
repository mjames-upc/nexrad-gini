## nexrad-gini

### crontab

	0,5,10,15,17,20,25,30,35,40,45,50,55 * * * * scripts/check_mosaic.csh 1>>/dev/null 2>&1
	2,7,12,17,22,27,32,37,42,47,52,57 * * * * scripts/check_nex2gini.csh 1>>/dev/null 2>&1
	* * * * *       scripts/pqinsert_gini.csh 1>>/dev/null 2>&1

### NIDS products

- DHR (Digital Hybrid Scan Reflectivity)
- DPA (High-Res Hourly Digital Precipitation Array)
- DSP (High-Res Digital Storm Total Precipitation)
- DVL (High-Res Digital Vertically Integrated Liquid)
- HHC (Hybrid Scan Hydrometeor Classification)
- EET (High-Res Enhanced Echo Tops)

### $GEMTBL/unidata/nex2gini.tbl entries

nex2gini will only run for these parameters if nex2gini.tbl is updated to the latest version:

The relevant parts of impdnidh.f:

	        DATA            dhc  / 'ND', 'BI', 'GC', 'IC',
     +                         'DS', 'WS', 'RA', 'HR',
     +                         'BD', 'GR', 'HA', '',
     +                         '', '', 'UK', 'RF' /

	C* 177 - Hybrid Hydrometeor Classification
           CASE (177)
              dhci = 1
              DO idl = 1, imndlv, 17
                 cmblev ( idl ) = dhc ( dhci )
                 dhci = dhci + 1
              END DO
              cmblev ( imndlv ) = 'RF'

After initialization, the 15 classification levels are split in the 0:255 range for HHC for every increase of 17 (15 times 17 = 255).

Therefore, the nex2gini.tbl entry is 16 levels (including ND):

	!Prod	band ncal units,Calval_1;....;calval_n	Prod_header
	! Since these are essentially spoofed satellite images,
	! we have to give them unique ids to be matched in imgtyp.tbl
	!
	!  Prod = Product identified 3-alpha-numeric
	!  band = unique "satellite id"
	!  ncal = number of calibration units
	!  units = calibration value, such as "1 dBZ" for reflectivity
	!	* then followed by calibration ranges.	for DPA:
	!	- 3 calibration ranges:
	!		* 0-4 inches = 10-110
	!		* 4-12 inches = 110-220
	!		* 12-24 inches = 210-255
	!
	! national composites
	HHC       25    16 na,
	EET	  26	1 KFt,0,255,0,85	     TICZ99 CHIZ
	N0Q	  27	1 dBZ,0,255,-32,95	     TICZ99 CHIZ
	DHR	  28	1 dBZ,0,255,-32,95	     TICZ99 CHIZ
	DVL	  29	1 Kg/m**2,0,255,0,85	     TICZ99 CHIZ
	DPA	  30	3 inches,10,110,0,2;110,210,2,6;210,255,6,12	  TICZ99 CHIZ
	DSP	  31	3 inches,10,110,0,4;110,220,4,12;210,255,12,24	   TICZ99 CHIZ
	! other stuff

