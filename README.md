# LeDecolor
Log-Euclidean Metrics for Contrast Preserving Decolorization  
% [1] Q. Liu, G. Shao, Y. Wang, J. Gao, H. Leung, “Log-Euclidean Metrics for Contrast Preserving Decolorization”   
% IEEE Trans. Image Process., pp, 2017.   
% Author: Q. Liu, G. Shao, Y. Wang, J. Gao, H. Leung  
% Date : 22/10/2016  
% Version : 1.0  
% The code and the algorithm are for non-comercial use only.  
% Copyright 2016, Department of Electronic Information Engineering, Nanchang University.  
% The current version is not optimized.  
% LeDecolor - Log-Euclidean Metrics for Contrast Preserving Decolorization  
% gIm = LeDecolor_v1(Im, gamma) performs contrast preserving decolorization  
% on color image Im, with controling parameter gamma  
%  
% Paras:  
% @Im : Input image (double), only color images are acceptable.  
% @gamma : Controlling parameter defined in [1]. 0.2 by default.  
%  
% Example  
% ==========  
% Im = im2double(imread('6.png'));  
% gIm = LeDecolor_v1(Im); % Default Parameters (gamma = 0.2)  
% figure, imshow(Im,[]), figure, imshow(gIm,[]); 
