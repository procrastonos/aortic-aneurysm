%% --- finds circle-like structures
function h = circle(handles, sensitivity, radius, variance)

% get image
im = handles.chain(:, :, end);

% show image in result axes
axes(handles.ResImg);
imshow(im, []);

% get ROI from user
rect = getrect;
% crop image to ROI
im = imcrop(im, rect);

% show cropped region
imshow(im, []);

% perform circle matching
[centers,radii] = imfindcircles(im, [radius - round(variance / 2) ...
                                     radius + round(variance / 2)], ...
                                     'Sensitivity', sensitivity);

% draw circles
viscircles(centers, radii);

% return handle struct
h = handles;

end