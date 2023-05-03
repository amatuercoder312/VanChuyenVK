function [v_ImageC,v_AlphaC,CarsPlot]=InitializeCar()
global CarsNum;
global Cars;
global ImageWidth;

[v_ImageC, ~, v_AlphaC]	= imread('Car1.png');
v_ImageC = imresize(v_ImageC, [ImageWidth*2 ImageWidth*2], 'lanczos3' );
v_AlphaC = imresize(v_AlphaC, [ImageWidth*2 ImageWidth*2], 'lanczos3' );

v_ImageC = flipdim(v_ImageC, 2);
v_AlphaC = flipdim(v_AlphaC, 2);
for CarsIndex = 1 : CarsNum
    angle = 180;	% imrotate rotates ccw     
    img_i = imrotate(v_ImageC, angle);
    alpha_i = imrotate(v_AlphaC, angle );
    CarsPlot(CarsIndex) = image(Cars(CarsIndex,1)- ImageWidth/2, Cars(CarsIndex,2)-ImageWidth/2, img_i);
    CarsPlot(CarsIndex).AlphaData = alpha_i;   
end


end

    