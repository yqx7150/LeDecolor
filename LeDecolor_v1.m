%% The Code is created based on the method described in the following paper: 
% [1] Q. Liu, G. Shao, Y. Wang, J. Gao, H. Leung, ¡°Log-Euclidean Metrics for Contrast Preserving Decolorization¡± 
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

function  [img,Es,bw]  = LeDecolor_v1(im,gamma)
 
%%  Proprocessing 
[n,m,ch] = size(im); 
if ~exist('gamma','var')
    gamma = 0.2;
end
W = wei();
 
 
%%  Global and Local Contrast Computing
ims = imresize(im, round(64/sqrt(n*m)*[n,m]),'nearest');
R = ims(:,:,1);G = ims(:,:,2);B = ims(:,:,3);
imV = [R(:),G(:),B(:)];
% defaultStream = RandStream.getDefaultStream; savedState = defaultStream.State;
t1 = randperm(size(imV,1));
Pg = [imV - imV(t1,:)];

ims = imresize(ims, 0.5 ,'nearest');
Rx = ims(:,1:end-1,1) - ims(:,2:end,1);
Gx = ims(:,1:end-1,2) - ims(:,2:end,2);
Bx = ims(:,1:end-1,3) - ims(:,2:end,3);

Ry = ims(1:end-1,:,1) - ims(2:end,:,1);
Gy = ims(1:end-1,:,2) - ims(2:end,:,2);
By = ims(1:end-1,:,3) - ims(2:end,:,3);
Pl = [[Rx(:),Gx(:),Bx(:)];[Ry(:),Gy(:),By(:)]];

P = [Pg;Pl ]; 
 
det = sqrt(sum(P.^2,2))/1.41  ;
 
P( (det < 0.05),:) = []; det( (det < 0.05)) = [];
detM =  repmat(det,[1,size(W,1)]); L = P*W'; 
 
%% Energy optimization
Lpp = 0.013;
U = exp(-gamma*(abs(log(abs(L)./(abs(detM)+Lpp)))));
Es = mean(U); 

%% Output
[NULLval,bw] = max(Es);%[bw, W(bw,:)]
img = imlincomb(W(bw,1),im(:,:,1) , W(bw,2),im(:,:,2) ,  W(bw,3),im(:,:,3));
 
end

function W = wei()
W = [    0         0    1.0000
         0    0.1000    0.9000
         0    0.2000    0.8000
         0    0.3000    0.7000
         0    0.4000    0.6000
         0    0.5000    0.5000
         0    0.6000    0.4000
         0    0.7000    0.3000
         0    0.8000    0.2000
         0    0.9000    0.1000
         0    1.0000         0
    0.1000         0    0.9000
    0.1000    0.1000    0.8000
    0.1000    0.2000    0.7000
    0.1000    0.3000    0.6000
    0.1000    0.4000    0.5000
    0.1000    0.5000    0.4000
    0.1000    0.6000    0.3000
    0.1000    0.7000    0.2000
    0.1000    0.8000    0.1000
    0.1000    0.9000         0
    0.2000         0    0.8000
    0.2000    0.1000    0.7000
    0.2000    0.2000    0.6000
    0.2000    0.3000    0.5000
    0.2000    0.4000    0.4000
    0.2000    0.5000    0.3000
    0.2000    0.6000    0.2000
    0.2000    0.7000    0.1000
    0.2000    0.8000         0
    0.3000         0    0.7000
    0.3000    0.1000    0.6000
    0.3000    0.2000    0.5000
    0.3000    0.3000    0.4000
    0.3000    0.4000    0.3000
    0.3000    0.5000    0.2000
    0.3000    0.6000    0.1000
    0.3000    0.7000    0.0000
    0.4000         0    0.6000
    0.4000    0.1000    0.5000
    0.4000    0.2000    0.4000
    0.4000    0.3000    0.3000
    0.4000    0.4000    0.2000
    0.4000    0.5000    0.1000
    0.4000    0.6000    0.0000
    0.5000         0    0.5000
    0.5000    0.1000    0.4000
    0.5000    0.2000    0.3000
    0.5000    0.3000    0.2000
    0.5000    0.4000    0.1000
    0.5000    0.5000         0
    0.6000         0    0.4000
    0.6000    0.1000    0.3000
    0.6000    0.2000    0.2000
    0.6000    0.3000    0.1000
    0.6000    0.4000    0.0000
    0.7000         0    0.3000
    0.7000    0.1000    0.2000
    0.7000    0.2000    0.1000
    0.7000    0.3000    0.0000
    0.8000         0    0.2000
    0.8000    0.1000    0.1000
    0.8000    0.2000    0.0000
    0.9000         0    0.1000
    0.9000    0.1000    0.0000
    1.0000         0         0];
end 