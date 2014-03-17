function h = next(handles)

% get current image id
imCount = handles.imCount;

% get images
img = handles.img;

% initialize new processing chain
chain = [];

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

% add current image to processing chain
chain = cat(3, chain, zeros(512));
chain = cat(3, chain, im);

% show original image
axes(handles.OrigImg);
imshow(chain(:, :, end - 1), []);

% show processed image
axes(handles.ResImg);
axis auto;
imshow(chain(:, :, end), []);

% update handles
handles.imCount = imCount;
handles.chain = chain;

% return handles structure
h = handles;

end

