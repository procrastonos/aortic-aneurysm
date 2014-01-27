%% --- level-set active contour algorithm
function h = levelset(handles)
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

% return handle struct
h = handles;

end