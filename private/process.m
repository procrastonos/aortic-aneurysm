function h = process(handles)

% get image
im = handles.chain(:, :, end);

% perform threshowd
handles = threshold(handles, 0.5);

thresholded = handles.chain(:, :, end);

% pause for effect
pause(1.0);

for n = 1:5
    % perform erosion
    handles = erosion(handles);
    % pause for effect
    pause(1.0);
end

eroded = handles.chain(:, :, end);

% show image again on result axes
axes(handles.ResImg);
imshow(im, []);

% get ROI from user
rect = getrect;

% move current image to original image view
axes(handles.OrigImg);
%imshow(im, []);
imshow(thresholded, []);
% show the rectangle
rectangle('Position', rect, 'EdgeColor', 'r');

% crop image to ROI
im = imcrop(im, rect);
mask = imcrop(eroded, rect);
% show ROI
axes(handles.ResImg);
imshow(im, []);

contour(mask, [0,0], 'r');
% initialize LSF as binary step function
c0 = 2;
seed = c0 * ones(size(im));

% generate the initial region R0 as two rectangles
%seed(round(rect(2)):round(rect(2)+rect(4)), ...
%     round(rect(1)):round(rect(1)+rect(3))) = -c0;
seed(mask > 0) = -c0;

% get iteration values
iter_inner = handles.levelset_iterInner;
iter_outer = handles.levelset_iter;

% call level set private function
handles = levelset(handles, im, iter_inner, iter_outer, seed);

% define structure element for erosion
se = strel('disk', 5);
% erode contour
erodeLSF = imerode(handles.contour, se);
% show image
imshow(im, []);
hold on;
% and draw contour in blue
contour(erodeLSF, [0,0], 'b');
% wait for a moment
pause(1.0);

% call level set function a second time
handles = levelset(handles, im, iter_inner, iter_outer, erodeLSF);
% update guidata
h = handles;

end

