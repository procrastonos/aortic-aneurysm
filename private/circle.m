%% --- finds circle-like structures
function h = circle(handles)
% select image
Img = handles.img(:, :, handles.imCount);

% select axes
axes(handles.ResImg);

% show image
imshow(Img, []);

% get ROI from user
rect = getrect;
% crop image to ROI
im = imcrop(Img, rect);

% get sensitivity value
sensitivity = handles.sensitivity;

% get radius
radius = handles.radius;

% perform circle matching
[centers,radii] = imfindcircles(im, [radius - 8 radius + 8], 'Sensitivity', sensitivity);

imshow(im, []);

% draw circles
viscircles(centers, radii);

h = handles;

end