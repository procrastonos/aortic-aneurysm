%% --- dilate image
function h = dilation(handles)

% get image
im = handles.img(:, :, handles.imCount);

%tr = handles.tr;
%se = strel('disk', 1);
%img(img <= tr) = 0;
%im_dl = imdilate(img,se);
%axes(handles.OrigImg);
%imshow(im_dl, []);
%handles.img = im_dl;
%guidata(hObject, handles);

%3D dilation
se3(:,:,1) = [0 0 0;0 1 0; 0 0 0];
se3(:,:,2) = [0 1 0;1 1 1; 0 1 0];
se3(:,:,3) = [0 0 0;0 1 0; 0 0 0];

% dilate image
img_dl3 = imdilate(im, se3);

% select axes
axes(handles.ResImg);

% show image
imshow(img_dl3, []);

% update handles
handles.img = img_dl3;

h = handles;

end