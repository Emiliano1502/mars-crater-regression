proc contents data=sasuser.mars_crater;
run;
proc print data=sasuser.mars_crater (obs=10);
run;