function RedrawBoom(Boids,BoidsNum,v_Image,v_Alpha,v_ImageE,v_AlphaE,BoidsPlot)
global EnvironmentWidth;
global ImageWidth;


for BoidIndex = 1 : BoidsNum
    if (Boids(BoidIndex, 4) > 0)            
                
        v_angle = 180;
        img_i = imrotate(v_Image, v_angle );
        alpha_i = imrotate(v_Alpha, v_angle );

        BoidsPlot(BoidIndex).CData = img_i;
        BoidsPlot(BoidIndex).AlphaData = alpha_i;

    else
        BoidsPlot(BoidIndex).CData = v_ImageE;
        BoidsPlot(BoidIndex).AlphaData = v_AlphaE;
    end
end

drawnow;