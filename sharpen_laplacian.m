% Problem 1: Image Sharpening using Laplacian Filter

% Read input image
I = im2double(imread('cameraman.tif'));

% Define Laplacian filters
laplacian1 = [-1 -1 -1; -1 8 -1; -1 -1 -1];  % +8 center
laplacian2 = [0 1 0; 1 -4 1; 0 1 0];         % -4 center
laplacian3 = [1 1 1; 1 -8 1; 1 1 1];         % -8 center

% Gaussian filters
gaussian1 = fspecial('gaussian', [3 3], 0.5);
gaussian2 = fspecial('gaussian', [3 3], 1);

% Figure 1 - Laplacian filter with +8 center
figure;
sharp1 = imfilter(I, laplacian1, 'replicate');
imshow(sharp1, []);
title('Image sharpening using the 3x3 Laplacian filter with +8 at the center');

% Figure 2 - Smooth with Gaussian σ^2=0.5 then Laplacian with -4 center
smoothed1 = imfilter(I, gaussian1, 'replicate');
sharp2 = imfilter(smoothed1, laplacian2, 'replicate');
sharpened2 = smoothed1 - sharp2;
figure;
imshow(sharpened2, []);
title('Image processing in two steps. Smoothed with 3x3 Gaussian σ^2=0.5 then sharpened with 3x3 Laplacian with -4 center');

% Figure 3 - Smooth with Gaussian σ^2=1 then Laplacian with -8 center
smoothed2 = imfilter(I, gaussian2, 'replicate');
sharp3 = imfilter(smoothed2, laplacian3, 'replicate');
sharpened3 = smoothed2 - sharp3;
figure;
imshow(sharpened3, []);
title('Image processing in two steps. Smoothed with 3x3 Gaussian σ^2=1 then sharpened with 3x3 Laplacian with -8 center');
