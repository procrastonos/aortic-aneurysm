%% --- erode image
function h = erosion(handles)

% create an erosion mask
se3(:,:,1)=[0 0 0;0 1 0;0 0 0];
se3(:,:,2)=[0 1 0;1 1 1;0 1 0];
se3(:,:,3)=[0 0 0;0 1 0;0 0 0];

% get image
im = handles.chain(:, :, end);

% show image on original image axes
axes(handles.OrigImg);
imshow(im, []);

% erode image
im = imerode(im, se3);

% show eroded image on result axes
axes(handles.ResImg);
imshow(im, []);

% add eroded image to processing chain
handles.chain = cat(3, handles.chain, im);

% return handle struct
h = handles;

end