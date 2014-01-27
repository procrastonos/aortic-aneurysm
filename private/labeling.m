%% --- performs labeling of object regions
function h = labeling(handles)
% select image
im = handles.img(:, :, handles.imCount);

% get user input
[y,x] = ginput(1);

% calculate pixel position of user input
gr = im(round(x), round(y));

% global criteria
tr1 = gr-0.2*gr;
tr2 = gr+0.2*gr;

% perform the thresholding operation
data = zeros(size(im));
data(im >= tr1 & im <= tr2) = 1;

% perform labeling
bl = bwlabeln(data, 4);
lab = bl(round(x), round(y));
bll = bl;
bll(bll ~= lab) =0;
bll(bll ~= 0) =1;

% select axes
axes(handles.ResImg);

% show image
imshow(bll, []);

% return handle struct
h = handles;

end