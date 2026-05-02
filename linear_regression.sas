proc reg data=work.mars2;
    model DEPTH_RIMFLOOR_TOPOG = diam_centered;
run;
quit;