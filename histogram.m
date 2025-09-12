img = imread('cameraman.tif');
img_eq1 = histeq(img);
img_eq2 = histeq(img_eq1);
diff_eq = imabsdiff(img_eq1, img_eq2);
figure; imshow(diff_eq, []);
title('Difference between 1st and 2nd Histogram Equalization');
