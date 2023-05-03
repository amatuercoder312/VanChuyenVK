function [BoomsPlot]=InitializeBoom(v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,Booms,BoomsNum)
global EnvironmentWidth;
global ImageWidth;

%axis([EnvironmentWidth EnvironmentWidth EnvironmentWidth EnvironmentWidth]);

for i=1:BoomsNum
    angle = -180;	% imrotate rotates ccw  
        if (Booms(i,4)> 0 )
            img_i = imrotate(v_ImageBoom, angle);
            alpha_i = imrotate(v_AlphaBoom, angle); 
        else
        img_i = imrotate(v_ImageEmpty, angle);
        alpha_i = imrotate(v_AlphaEmpty, angle);                
        end  
    BoomsPlot(i) = image(Booms(i,1), Booms(i,2), img_i);
    BoomsPlot(i).AlphaData = alpha_i;      
end
