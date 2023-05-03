function [v_ImageFR,v_AlphaFR,v_ImageFB,v_AlphaFB]=LoadImageFlag()

[v_ImageFR, ~, v_AlphaFR]	= imread('FlagR.png');
v_ImageFR = imresize(v_ImageFR, [200 800], 'lanczos3' );
v_AlphaFR = imresize(v_AlphaFR, [200 800], 'lanczos3' );
v_ImageFR = flipdim(v_ImageFR, 2);
v_AlphaFR = flipdim(v_AlphaFR, 2);

[v_ImageFB, ~, v_AlphaFB]	= imread('FlagB.png');
v_ImageFB = imresize(v_ImageFB, [200 800], 'lanczos3' );
v_AlphaFB = imresize(v_AlphaFB, [200 800], 'lanczos3' );
v_ImageFB = flipdim(v_ImageFB, 2);
v_AlphaFB = flipdim(v_AlphaFB, 2);