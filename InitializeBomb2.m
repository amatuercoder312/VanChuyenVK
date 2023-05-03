function [BombsPlot]=InitializeBomb2(v_ImageN,v_AlphaN,index)
global EnvironmentWidth;
global ImageWidth;
global Fights;

axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);
            angle = 180;	% imrotate rotates ccw  
             img_i = imrotate(v_ImageN, angle);
            alpha_i = imrotate(v_AlphaN, angle); 
            BombsPlot = image(Fights(index,1)+60, Fights(index,2)-60, img_i);
            BombsPlot.AlphaData = alpha_i;   
end