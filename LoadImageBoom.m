function [v_ImageBoom,v_AlphaBoom,v_ImageN,v_AlphaN,v_ImageEmpty,v_AlphaEmpty]=LoadImageBoom()

[v_ImageBoom, ~, v_AlphaBoom]	= imread('boom.png');
v_ImageBoom = imresize(v_ImageBoom, [40 30], 'lanczos3' );
v_AlphaBoom = imresize(v_AlphaBoom, [40 30], 'lanczos3' );

[v_ImageN, ~, v_AlphaN]	= imread('bomb.png');
v_ImageN = imresize(v_ImageN, [120 100], 'lanczos3' );
v_AlphaN = imresize(v_AlphaN, [120 100], 'lanczos3' );

[v_ImageEmpty, ~, v_AlphaEmpty]	= imread('Empty.png');
v_ImageEmpty = imresize(v_ImageEmpty, [50 40], 'lanczos3' );
v_AlphaEmpty = imresize(v_AlphaEmpty, [50 40], 'lanczos3' );
