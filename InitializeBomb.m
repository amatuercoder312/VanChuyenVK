function [BombsPlot]=InitializeBomb(v_ImageN,v_AlphaN,index)
global EnvironmentWidth;
global ImageWidth;
global Booms;

%axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);
            angle = -180;	% imrotate rotates ccw  
             img_i = imrotate(v_ImageN, angle);
            alpha_i = imrotate(v_AlphaN, angle); 
            BombsPlot = image(Booms(index,1)-25, Booms(index,2)-25, img_i);
            BombsPlot.AlphaData = alpha_i;   

end