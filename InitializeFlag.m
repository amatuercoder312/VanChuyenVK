function InitializeFlag (v_Image,v_Alpha)
       
    angle = -180;	% imrotate rotates ccw     
    img_i = imrotate(v_Image, angle);
    alpha_i = imrotate(v_Alpha, angle );
 
    BasesPlot= image(0, 400, img_i);
    BasesPlot.AlphaData = alpha_i; 