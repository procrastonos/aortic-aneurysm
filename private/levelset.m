%% --- level-set active contour algorithm
function h = levelset(handles, im, iter_inner, iter_outer, seed)

%% Preparation

% get min and max values of image
maxv = double(max(im(:)));
minv = double(min(im(:)));

% gray value range
range = maxv - minv;

% convert image to double
im = double(im(:,:,1));
% reduce value range to 0..256
im = round(((im - minv) / range) * 255);

%% parameter settings

% time step
timestep = 8;
% coefficient of the distance regularization term R(phi)
mu = 0.2 / timestep;
% coefficient of the weighted length term L(phi)
lambda = 5; % 5
% coefficient of the weighted area term A(phi) (growing direction)
alfa = -1.5; % 1.5
% paramater that specifies the width of the DiracDelta function
epsilon = 1.5; % 1.5
% scale parameter in Gaussian kernel
sigma = 1.5;
% matrix size for kernel
hsize = 10;  % 15
% potential well (single or double)
potential = 2;  

%% DRLSE

% Gaussian kernel
G = fspecial('gaussian', hsize, sigma); 
% smooth image by Gaussiin convolution
Img_smooth = conv2(im, G, 'same');

% some kind of gradient
[Ix, Iy] = gradient(Img_smooth);
f = Ix .^ 2 + Iy .^ 2;
% edge indicator function.
g = 1 ./ (1 + f);

% initial 
phi = seed;

% get last used axes
axes(gca);
hold on;
contour(phi, [0,0], 'r');
title('Initial zero level contour');
pause(1.0);

% select potential well
if potential ==1
    % use single well potential p1(s)=0.5*(s-1)^2, which is good for region-based model 
    potentialFunction = 'single-well';
elseif potential == 2
    % use double-well potential in Eq. (16), which is good for both edge and region based models
    potentialFunction = 'double-well';
else
    % default choice of potential function
    potentialFunction = 'double-well';
end  

% start level set evolution
for n=1:iter_outer
    phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
    imshow(im, []);
    hold on;
    contour(phi, [0,0], 'r');
    pause(0.1);
end

%% Refining

% refine the zero level contour by further level set evolution with alfa=0
alfa=0;
iter_refine = 10;
phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);

%% Show result

imshow(im, []);
hold on;
contour(phi, [0,0], 'r');
str=['Intermediate zero level contour, ', num2str(iter_outer*iter_inner+iter_refine), ' iterations'];
title(str);

% return contour
handles.contour = phi;
h = handles;

end