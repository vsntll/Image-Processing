% affine_transform.m
% Affine transform with bilinear interpolation on 'cameraman.tif'

img = imread('cameraman.tif');

% Define affine matrix T (example: rotation + scale + shear, replace with your T)
T = [1.2, 0.3, 0; 0.2, 1.1, 0]; % Example, fill in with actual values if specified

tform = affine2d([T; 0 0 1]); % Construct affine2d object

% Apply affine transformation using bilinear interpolation
affine_img = imwarp(img, tform, 'InterpolationMethod', 'bilinear', 'FillValues', 0);

figure(5);
imshow(affine_img, []);
title('Figure 4: Affine Transform (Matrix T, Bilinear)');

% Inverse transform
inv_tform = invert(tform);
restored_img = imwarp(affine_img, inv_tform, 'OutputView', imref2d(size(img)), 'InterpolationMethod', 'bilinear', 'FillValues', 0);

figure(6);
imshow(restored_img, []);
title('Inverse Affine Transform of Figure 4');

% Difference image (zero pad sizes if needed)
restored_img_padded = padarray(restored_img, size(img)-size(restored_img), 0, 'post');
diff_img_affine = imabsdiff(img, restored_img_padded);

figure(7);
imshow(diff_img_affine, []);
title('Figure 5: Difference: Original vs. Inverse Affine');

% Interpretation:
% Bright pixels → high geometric/information loss due to affine distortion/resampling.
% Dark pixels → accurate recovery.


