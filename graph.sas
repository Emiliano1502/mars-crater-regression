proc sgplot data=work.mars2;
    scatter x=DIAM_CIRCLE_IMAGE y=DEPTH_RIMFLOOR_TOPOG;
    reg x=DIAM_CIRCLE_IMAGE y=DEPTH_RIMFLOOR_TOPOG;
run;