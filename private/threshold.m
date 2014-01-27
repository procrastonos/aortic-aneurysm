%% --- sets threshold of image
function h = threshold(handles)
% get threshold value
tr = handles.tr;

% select image
trmask = handles.img(:, :, handles.imCount);

% apply threshold
trmask(trmask <= tr) = 0;

% select axes
axes(handles.ResImg);

% show image
imshow(trmask, []);

% update handles
handles.thresh = trmask;

% return handle struct
h = handles;

end