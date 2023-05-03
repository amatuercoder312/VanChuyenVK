function [v_Image,v_Alpha,BoidsPlot]=InitializeArmyRed()
global BoidsNum;
global Boids;
global ImageWidth;

[v_Image, ~, v_Alpha]	= imread('SoldierF.png');
v_Image = imresize(v_Image, [ImageWidth ImageWidth], 'lanczos3' );
v_Alpha = imresize(v_Alpha, [ImageWidth ImageWidth], 'lanczos3' );


for BoidsIndex = 1 : BoidsNum
    angle = -180;	% imrotate rotates ccw     
    img_i = imrotate(v_Image, angle);
    alpha_i = imrotate(v_Alpha, angle );
    BoidsPlot(BoidsIndex) = image(Boids(BoidsIndex,1)- ImageWidth/2, Boids(BoidsIndex,2)-ImageWidth/2, img_i);
    BoidsPlot(BoidsIndex).AlphaData = alpha_i;   
end


end

    