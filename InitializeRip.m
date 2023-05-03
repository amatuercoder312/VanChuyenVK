function [v_ImageRip,v_AlphaRip]=InitializeRip()
global ImageWidth;
[v_ImageRip, ~, v_AlphaRip]	= imread('rip.png');
v_ImageRip = imresize(v_ImageRip, [ImageWidth ImageWidth], 'lanczos3' );
v_AlphaRip = imresize(v_AlphaRip, [ImageWidth ImageWidth], 'lanczos3' );