function sharpen_laplacian(input_image, laplacian_type)
% SHARPEN_LAPLACIAN Sharpen an image using a specified Laplacian filter
%   input_image: filename or matrix
%   laplacian_type: 'L1', 'L2', 'L3'
%   
%   L1: Laplacian with +8 center (for Figure 1)
%   L2: Laplacian with -4 center (for Figure 2)  
%   L3: Laplacian with -8 center (for Figure 3)

% Load and convert image to double precision
if ischar(input_image)
    I = im2double(imread(input_image));
else
    I = im2double(input_image);
end

% Define Laplacian filters based on type
switch laplacian_type
    case 'L1' % +8 center for direct sharpening (Figure 1)
        h = [-1 -1 -1; -1 8 -1; -1 -1 -1];
        method = 'direct';
        title_str = 'Figure 1: Image sharpening using the 3×3 Laplacian filter with +8 at the center';
        
    case 'L2' % -4 center for two-step process (Figure 2)
        h = [0 1 0; 1 -4 1; 0 1 0];
        method = 'two_step';
        sigma_squared = 0.5;
        title_str = 'Figure 2: Gaussian smoothing (σ²=0.5) then Laplacian (-4 center)';
        
    case 'L3' % -8 center with diagonal connections (Figure 3)
        h = [1 1 1; 1 -8 1; 1 1 1];
        method = 'two_step';
        sigma_squared = 1;
        title_str = 'Figure 3: Gaussian smoothing (σ²=1) then Laplacian (-8 center)';
        
    otherwise
        error('Unknown Laplacian type. Use L1, L2, or L3');
end

% Process based on method
if strcmp(method, 'direct')
    % Method 1: Direct Laplacian sharpening (L1)
    laplacian_response = imfilter(I, h, 'replicate');
    sharpened = I + laplacian_response;  % Add for positive center
    
    % Display results
    figure;
    subplot(1,2,1);
    imshow(I);
    title('Original Image');
    
    subplot(1,2,2);
    imshow(sharpened);
    title('Sharpened Image');
    
else
    % Method 2: Two-step process (L2, L3)
    % Step 1: Gaussian smoothing
    sigma = sqrt(sigma_squared);
    gaussian_filter = fspecial('gaussian', 3, sigma);
    smoothed = imfilter(I, gaussian_filter, 'replicate');
    
    % Step 2: Laplacian sharpening
    laplacian_response = imfilter(smoothed, h, 'replicate');
    sharpened = smoothed - laplacian_response;  % Subtract for negative center
    
    % Display results
    figure;
    subplot(2,2,1);
    imshow(I);
    title('Original Image');
    
    subplot(2,2,2);
    imshow(smoothed);
    title(sprintf('Gaussian Smoothed (σ²=%.1f)', sigma_squared));
    
    subplot(2,2,3);
    imshow(laplacian_response, []);
    title('Laplacian Response');
    
    subplot(2,2,4);
    imshow(sharpened);
    title('Final Sharpened Result');
end

% Clamp values to valid range [0,1]
sharpened = max(0, min(1, sharpened));

% Add overall title
sgtitle(title_str);

% Display filter information
fprintf('\nFilter used (%s):\n', laplacian_type);
disp(h);
fprintf('Processing method: %s\n', method);
if exist('sigma_squared', 'var')
    fprintf('Gaussian variance: σ² = %.1f\n', sigma_squared);
end

end