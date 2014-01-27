%% --- finds circle-like structures
function h = circle(handles)
% select image
im = handles.img(:, :, handles.imCount);

% get sensitivity value
sensitivity = handles.sensitivity;

% get radius
radius = handles.radius;

% perform circle matching
[centers,radii] = imfindcircles(im, [radius - 8 radius + 8], 'Sensitivity', sensitivity);

% select axes
axes(handles.ResImg);

% show image
imshow(im, []);

% draw circles
viscircles(centers, radii);

h = handles;

end