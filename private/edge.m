%% --- find edges in image
function h = edge(handles)

% get image
im = handles.chain(:, :, end);

% show image on original image axes
axes(handles.OrigImg);
imshow(im, []);

% select edge detection filter
h = fspecial('Prewitt');
% apply edge detection filter
im = filter2(h, im, 'same');

% show thresholded image on result axes
axes(handles.ResImg);
imshow(im, []);

% add thresholded image to processing chain
handles.chain = cat(3, handles.chain, im);

% return handle struct
h = handles;

end