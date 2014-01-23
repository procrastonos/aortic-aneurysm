%% --- sets threshold of image
function threshold_Op (hObject, handles)
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
guidata(hObject, handles);

%% --- performs labeling of object regions
function labeling_Op (hObject, handles)
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

%% --- finds circle-like structures
function circle_Op (hObject, handles)
% select image
im = handles.img(:, :, handles.imCount);

% get sensitivity value
sensitivity = handles.sensitivity;

% get radius
radius = handles.radius;

% perform circle matching
[centers,radii] = imfindcircles(im, [radius - 8 radius + 8], 'Sensitivity', sensitivity);

% select axes
axes(handles.ResImg);

% show image
imshow(im, []);

% draw circles
viscircles(centers, radii);

%% --- erode image
function erosion_Op (hObject, handles)
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

%% --- dilate image
function dilation_Op (hObject, handles)
% 2D dilation

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
guidata(hObject, handles);

%% --- find edges in image
function edge_Op (hObject, handles)
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

% select image
im = handles.img(:, :, handles.imCount);

% select output axes
axes(handles.ResImg);

%% --- level-set active contour algorithm
function edge_Op (hObject, handles)
% parameter setting
timestep = 5;  % time step
mu = 0.2 / timestep;  % coefficient of the distance regularization term R(phi)
iter_inner = 5;
iter_outer = 40;
lambda = 5; % coefficient of the weighted length term L(phi)
alfa = 1.5;  % coefficient of the weighted area term A(phi)
epsilon = 1.5; % papramater that specifies the width of the DiracDelta function
sigma = 1.5;     % scale parameter in Gaussian kernel

G = fspecial('gaussian', 15, sigma);

axes(handles.ResImg);

Img_smooth = conv2(im, G, 'same');  % smooth image by Gaussiin convolution

imshow(Img_smooth, []);

[Ix,Iy] = gradient(Img_smooth);
f = Ix .^ 2 + Iy .^ 2;
g = 1 ./ (1 + f);  % edge indicator function.

% initialize LSF as binary step function
c0 = 2;
initialLSF = c0 * ones(size(im));

% get user input
[x,y] = ginput(2);

axes(handles.OrigImg);

rectangle('Position',[min(x), min(y), max(x) - min(x), max(y) - min(y)])

axes(handles.ResImg);

% generate the initial region R0 as a rectangle
initialLSF(min(x):min(y), max(x):max(y)) = -c0;  
phi = initialLSF;

mesh(-phi);   % for a better view, the LSF is displayed upside down
hold on;  contour(phi, [0,0], 'r','LineWidth',2);
title('Initial level set function');
view([-80 35]);

pause(2);

imagesc(im,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
title('Initial zero level contour');
pause(0.5);

potential=2;  
if potential ==1
    potentialFunction = 'single-well';  % use single well potential p1(s)=0.5*(s-1)^2, which is good for region-based model 
elseif potential == 2
    potentialFunction = 'double-well';  % use double-well potential in Eq. (16), which is good for both edge and region based models
else
    potentialFunction = 'double-well';  % default choice of potential function
end


% start level set evolution
for n=1:iter_outer
    phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
    if mod(n,2)==0
        imagesc(im,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
    end
end

% refine the zero level contour by further level set evolution with alfa=0
alfa=0;
iter_refine = 10;
phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);

finalLSF=phi;

imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
hold on;  contour(phi, [0,0], 'r');
str=['Final zero level contour, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);

pause(1);

mesh(-finalLSF); % for a better view, the LSF is displayed upside down
hold on;  contour(phi, [0,0], 'r','LineWidth',2);
str=['Final level set function, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);
axis on;

