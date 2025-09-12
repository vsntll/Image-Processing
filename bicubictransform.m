% bicubictransform.m

% Read the input image
img = imread('cameraman.tif');

% Display original image
figure(1);
imshow(img);
title('Original Cameraman Image');

% Transformation parameters
row_scale = 2.4;            % Enlarge rows
col_scale = 1/1.4;          % Shrink columns
rotation_angle = 33.5;      % degrees, clockwise

% Step 1: Resize along rows and columns
resized_img = imresize(img, [round(size(img,1)*row_scale), round(size(img,2)*col_scale)], 'bicubic');

% Step 2: Rotate clockwise (MATLAB uses counterclockwise by default)
rotated_img = imrotate(resized_img, -rotation_angle, 'bicubic', 'crop');

% Show result
figure(2);
imshow(rotated_img, []);
title('Figure 1: Enlarge rows x2.4, shrink cols by x1.4, rotate +33.5 deg (bicubic)');

% Step 3: Inverse operations
inv_rotated_img = imrotate(rotated_img, rotation_angle, 'bicubic', 'crop');
inv_img = imresize(inv_rotated_img, [size(img,1), size(img,2)], 'bicubic');

figure(3);
imshow(inv_img, []);
title('Figure 2: Inverse Transform of Figure 1');

% Step 4: Difference image
diff_img = imabsdiff(img, inv_img);

figure(4);
imshow(diff_img, []);
title('Figure 3: Difference: Original vs. Inverse Transformed');

% Interpretation:
% Bright pixels → Large difference (where geometric/information loss occurs).
% Dark pixels → Little/no difference (accurate reconstruction).
