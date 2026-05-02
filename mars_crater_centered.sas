data work.mars2;
    set sasuser.mars_crater;

    diam_centered = DIAM_CIRCLE_IMAGE - 3.5566864;
run;