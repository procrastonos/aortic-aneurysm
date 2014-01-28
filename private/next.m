function h = next(handles)

% get current image id
imCount = handles.imCount;

% get images
img = handles.img;

% get number of images
z = size(img, 3);

if imCount == z
    % wrap images at end
    imCount = 1;
else
    % increase image count
    imCount = imCount + 1;
end

% select image
im = img(:,:,imCount);

% select axes
axes(handles.OrigImg);

% show image
imshow(im, []);

% update handles
handles.imCount = imCount;

% return handles structure
h = handles;

end

