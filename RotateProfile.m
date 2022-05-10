function [rotaded,RotCenter] = RotateProfile(p,theta,opt)
% RotateProfile: Rotates a 2D profile around a given point, either defined
% automatically or manually.
% RotateProfile(p,angle) generates a matrix with the same size as p with
% coordinates for each of the elements of p defined by the rotation of angle
% theta (in degrees). Positive angles rotate the profile CCW and 
% negative angles CW. Each row of p defines a point, which means that p 
% should be a n x 2 (2D) matrix.  opt is an option defined by the user to 
% find the center of rotation either manually or automatically. Rotated is 
% the output matrix in the same format as the input n x 2 matrix. RotCenter
% is the output coordinates of the center of rotation.


% Also see ginput().

% 03 Aug 2021, Nils Tack

%% test rotation %%
% figure; hold on
% plot(p(:,1),p(:,2),'-k') % plot original profile

% choose a point which will be the center of rotation
if opt == 1 % automatic detection of center of profile based on mean x and y values
    x_center = mean(p(:,1));
    y_center = mean(p(:,2));

    elseif opt == 2 % automatic detection of center of rotation fixed to the first point defining the matrix
    x_center = mean(p(1,1));
    y_center = mean(p(1,2)); 
    
    elseif opt == 3 % manual detection of center of rotation using one query point returned by ginput
    fig = figure; hold on
    plot(p(:,1),p(:,2), 'k-');
    [x_center,y_center] = ginput(1); % select point using ginput
    plot(x_center,y_center, 'ro');
    pause(1)
    close(fig)
end
 RotCenter = [x_center,y_center]; % saves the coordinates of the center of rotation

plot(x_center,y_center,'or') % plot the center of rotation in red to verify its validity

% create a matrix of these points, which will be useful in future calculations
v = [p(:,1)';p(:,2)'];

%% Calculate coordinates of new points %%
% create a matrix which will be used later in calculations
center = repmat([x_center; y_center], 1, length(p(:,1)));

% define rotation matrix
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; % use cosd and sind to use degrees instead. Values of theta can be positive or negative.

% perform the rotation...
vo = R*(v - center) + center;

% pick out the vectors of rotated x- and y-data
rotaded(:,1) = vo(1,:)';
rotaded(:,2) = vo(2,:)';

%% make a plot %%
% figure;
% plot(p(:,1),p(:,2), 'k-', rotaded(:,1), rotaded(:,2), 'r-', x_center, y_center, 'bo');
% axis equal

end