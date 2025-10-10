% Load the Pmat matrix from the .mat file
load('cameraPmatrix.mat'); % loads variable Pmat (4x4)

% Extract rotation R and translation T
R = Pmat(1:3, 1:3);
T = Pmat(1:3, 4);

% Question 6.1: Find camera position in world coordinates
C = -R' * T;
disp(['Camera location (U, V, W): ', num2str(round(C'))]);



% Question 6.2: Camera X axis unit vector in world coordinates
camera_x_axis = R(:, 1);
unit_camera_x_axis = camera_x_axis / norm(camera_x_axis);
disp(['Camera X axis unit vector: ', num2str(round(unit_camera_x_axis', 2))]);

% Question 6.3: New camera location after moving 100 mm along positive X axis
new_camera_location = C + 100 * unit_camera_x_axis;
disp(['New camera location (U, V, W): ', num2str(round(new_camera_location'))]);
