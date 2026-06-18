data work.mars_logistic;
    set sasuser.mars_crater;

    diam_centered = DIAM_CIRCLE_IMAGE - 3.5566864;

    if DEPTH_RIMFLOOR_TOPOG > 0.5 then deep_crater = 1;
    else deep_crater = 0;
run;

/* Revisar frecuencia de la variable respuesta */
proc freq data=work.mars_logistic;
    tables deep_crater;
run;

/* Modelo simple: solo la variable explicativa principal */
proc logistic data=work.mars_logistic;
    model deep_crater(event='1') = diam_centered / clodds=wald;
    title "Logistic Regression Model 1: Diameter Only";
run;

/*For latitude*/
proc logistic data=work.mars_logistic;
    model deep_crater(event='1') = 
        diam_centered 
        LATITUDE_CIRCLE_IMAGE / clodds=wald;
    title "Logistic Regression Model 2: Diameter + Latitude";
run;

/* Longitude*/
proc logistic data=work.mars_logistic;
    model deep_crater(event='1') = 
        diam_centered 
        LATITUDE_CIRCLE_IMAGE 
        LONGITUDE_CIRCLE_IMAGE / clodds=wald;
    title "Logistic Regression Model 3: Diameter + Latitude + Longitude";
run;

/* Finally combining both */
proc logistic data=work.mars_logistic;
    model deep_crater(event='1') = 
        diam_centered 
        LATITUDE_CIRCLE_IMAGE 
        LONGITUDE_CIRCLE_IMAGE 
        NUMBER_LAYERS / clodds=wald;
    title "Final Logistic Regression Model";
run;