function [v_ImageB,v_AlphaB,BluesPlot]=InitializeArmyBlue()
global ImageWidth;
global ArmyBlues;
global ArmyBluesNum;

[v_ImageB, ~, v_AlphaB]	= imread('ArmyBlue.png');
v_ImageB = imresize(v_ImageB, [ImageWidth ImageWidth], 'lanczos3' );
v_AlphaB = imresize(v_AlphaB, [ImageWidth ImageWidth], 'lanczos3' );


for BluesIndex = 1 : ArmyBluesNum
    angle = -180;	% imrotate rotates ccw     
    img_i = imrotate(v_ImageB, angle);
    alpha_i = imrotate(v_AlphaB, angle );
    BluesPlot(BluesIndex) = image(ArmyBlues(BluesIndex,1)- ImageWidth/2, ArmyBlues(BluesIndex,2)-ImageWidth/2, img_i);
    BluesPlot(BluesIndex).AlphaData = alpha_i;   
end


end