%% --- find edges in image
function h = edge(handles)

% select image
im = handles.img(:, :, handles.imCount);

% select edge detection filter
h = fspecial('Prewitt');

% apply edge detection filter
imfil = filter2(h, im, 'same');

% select output axes
axes(handles.ResImg);

% show image
imshow(imfil, []);

% return handle struct
h = handles;

end