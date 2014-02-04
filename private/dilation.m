%% --- dilate image
function h = dilation(handles)

% get image
im = handles.chain(:, :, end);

% show image on original image axes
axes(handles.OrigImg);
imshow(im, []);

%3D dilation
se3(:,:,1) = [0 0 0;0 1 0; 0 0 0];
se3(:,:,2) = [0 1 0;1 1 1; 0 1 0];
se3(:,:,3) = [0 0 0;0 1 0; 0 0 0];

% dilate image
im = imdilate(im, se3);

% show thresholded image on result axes
axes(handles.ResImg);
imshow(im, []);

% add thresholded image to processing chain
handles.chain = cat(3, handles.chain, im);

% return handle struct
h = handles;

end