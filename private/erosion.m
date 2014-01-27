%% --- erode image
function h = erosion(handles)
% select image
im = handles.img(:, :, handles.imCount);

% create an erosion mask
se3(:,:,1)=[0 0 0;0 1 0;0 0 0];
se3(:,:,2)=[0 1 0;1 1 1;0 1 0];
se3(:,:,3)=[0 0 0;0 1 0;0 0 0];

% erode image
img_er3 = imerode(im, se3);

% select output axes
axes(handles.ResImg);

% show image
imshow(img_er3, []);

% return handle struct
h = handles;

end