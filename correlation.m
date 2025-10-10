function [max_x, max_y, correlation_matrix] = image_correlation(image1, image2)
    % Read images
    I1 = imread(image1);
    I2 = imread(image2);
    
    % Convert to grayscale if RGB
    if size(I1,3) == 3
        I1 = rgb2gray(I1);
    end
    if size(I2,3) == 3
        I2 = rgb2gray(I2);
    end
    
    % Convert to double
    I1 = im2double(I1);
    I2 = im2double(I2);
    
    % Identify template and larger image correctly based on size
    if prod(size(I1)) <= prod(size(I2))
        template = I1;
        image = I2;
        template_name = image1;
        image_name = image2;
        template_first = true;
    else
        template = I2;
        image = I1;
        template_name = image2;
        image_name = image1;
        template_first = false;
    end
    
    % Compute normalized cross correlation
    correlation_matrix = normxcorr2(template, image);
    
    % Find peak correlation and its coordinates
    [max_val, max_idx] = max(correlation_matrix(:));
    [max_y, max_x] = ind2sub(size(correlation_matrix), max_idx);
    
    % Adjust coordinates to correspond to top-left corner of template in image
    max_x = max_x - size(template, 2) + 1;
    max_y = max_y - size(template, 1) + 1;
    
    fprintf('Using template image: %s\n', template_name);
    fprintf('Searching in image: %s\n', image_name);
    fprintf('Maximum correlation at (x, y) = (%d, %d)\n', max_x, max_y);
    
    % Plot correlation matrix surface
    figure;
    surf(correlation_matrix);
    shading interp;
    title('Cross-Correlation between Images');
    xlabel('X'); ylabel('Y'); zlabel('Correlation');
end

[max_x, max_y, corr_matrix] = image_correlation('cameraman.tif', 'woman_blonde.tif');

