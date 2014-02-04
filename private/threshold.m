%% --- sets threshold of image
function h = threshold(handles, tr)

% get image
im = handles.chain(:, :, end);

% show image on original image axes
axes(handles.OrigImg);
imshow(im, []);

% apply threshold
im(im <= tr) = 0;

% show thresholded image on result axes
axes(handles.ResImg);
imshow(im, []);

% add thresholded image to processing chain
handles.chain = cat(3, handles.chain, im);

% return handle struct
h = handles;

end