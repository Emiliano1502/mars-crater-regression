data work.mars2;
    set sasuser.mars_crater;

    diam_centered = DIAM_CIRCLE_IMAGE - 3.5566864;
run;

/* Regresión múltiple */
proc reg data=work.mars2;
    model DEPTH_RIMFLOOR_TOPOG =
        diam_centered
        LATITUDE_CIRCLE_IMAGE
        LONGITUDE_CIRCLE_IMAGE
        NUMBER_LAYERS;
    
    output out=regdiag
        p=predicted
        r=residual
        student=std_resid
        h=leverage;
run;
quit;

/* Crear número de observación para los gráficos */
data regdiag;
    set regdiag;
    obsnum = _N_;
run;

/* Q-Q plot */
proc univariate data=regdiag normal;
    var std_resid;
    qqplot std_resid / normal(mu=est sigma=est);
run;

/* Standardized residuals for all observations */
proc sgplot data=regdiag;
    scatter x=obsnum y=std_resid;
    refline 0 / axis=y;
    refline 3 -3 / axis=y lineattrs=(pattern=shortdash);
    xaxis label="Observation Number";
    yaxis label="Standardized Residual";
    title "Standardized Residuals by Observation";
run;

/* Leverage plot */
proc sgplot data=regdiag;
    scatter x=obsnum y=leverage;
    refline 0 / axis=y;
    xaxis label="Observation Number";
    yaxis label="Leverage";
    title "Leverage by Observation";
run;

/* Revisar confounding agregando variables una por una */
proc reg data=work.mars2;
    model DEPTH_RIMFLOOR_TOPOG = diam_centered;
    model DEPTH_RIMFLOOR_TOPOG = diam_centered LATITUDE_CIRCLE_IMAGE;
    model DEPTH_RIMFLOOR_TOPOG = diam_centered LATITUDE_CIRCLE_IMAGE LONGITUDE_CIRCLE_IMAGE;
    model DEPTH_RIMFLOOR_TOPOG = diam_centered LATITUDE_CIRCLE_IMAGE LONGITUDE_CIRCLE_IMAGE NUMBER_LAYERS;
run;
quit;
