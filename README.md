nexrad-gini
===========
crontab

	0,5,10,15,17,20,25,30,35,40,45,50,55 * * * * scripts/check_mosaic.csh 1>>/dev/null 2>&1
	2,7,12,17,22,27,32,37,42,47,52,57 * * * * scripts/check_nex2gini.csh 1>>/dev/null 2>&1
	* * * * *       scripts/pqinsert_gini.csh 1>>/dev/null 2>&1
