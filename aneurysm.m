function varargout = aneurysm_Jan(varargin)
% ANEURYSM_JAN MATLAB code for aneurysm_Jan.fig
%      ANEURYSM_JAN, by itself, creates a new ANEURYSM_JAN or raises the existing
%      singleton*.
%
%      H = ANEURYSM_JAN returns the handle to a new ANEURYSM_JAN or the handle to
%      the existing singleton*.
%
%      ANEURYSM_JAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANEURYSM_JAN.M with the given input arguments.
%
%      ANEURYSM_JAN('Property','Value',...) creates a new ANEURYSM_JAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aneurysm_Jan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aneurysm_Jan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aneurysm_Jan

% Last Modified by GUIDE v2.5 16-Jan-2014 09:20:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aneurysm_Jan_OpeningFcn, ...
                   'gui_OutputFcn',  @aneurysm_Jan_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before aneurysm_Jan is made visible.
function aneurysm_Jan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aneurysm_Jan (see VARARGIN)

% Choose default command line output for aneurysm_Jan
handles.output = hObject;
handles.imCount = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aneurysm_Jan wait for user response (see UIRESUME)
% uiwait(handles.window);

% --- Outputs from this function are returned to the command line.
function varargout = aneurysm_Jan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in next_Button.
function next_Button_Callback(hObject, eventdata, handles)
% hObject    handle to next_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get current image id
imCount = handles.imCount;

% get image
im = handles.img(:, :, imCount + 1);

% select axes
axes(handles.OrigImg);

% show image
imshow(im, []);

% increase image count
imCount = imCount + 1;

% update handles
handles.imCount = imCount;
guidata(hObject, handles);


% --- Executes on button press in read_Button.
function read_Button_Callback(hObject, eventdata, handles)
% hObject    handle to read_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% av_files = dir(fullfile(path,'*.dcm'));
% read DICOM image

% get folder containing dicom series from user
folder = uigetdir('C:\Users\JanHenric\SkyDrive\Uni\Uebungen\S5\MedBV\Aortic_aneurysm\4\','Select folder');
%folder = uigetdir('./data/','Select folder');
files = dir(fullfile(folder,'*.dcm'));

% create handle for files (probably no longer needed though)
handles.files = files;

img = [];
pinfo = [];

% read images
for k = 198:202 % TODO size(files, 1)
    filename = files(k, 1).name;
    im = dicomread(fullfile(folder, filename));
    pi = dicominfo(fullfile(folder, filename));
    
    img = cat(3, img, im);
    pinfo = cat(1, pinfo, pi);
end

% create handle for images and patient info
handles.img = img;
handles.pinfo = pinfo;

% select axes
axes(handles.OrigImg);

% select image
im = img(:, :, 1);

% show image
imshow(im, []);

% activate GUI elements
set(handles.threshold_Button, 'Enable', 'on');
set(handles.circle_Button, 'Enable', 'on');
set(handles.labeling_Button, 'Enable', 'on');
set(handles.dilation_Button, 'Enable', 'on');
set(handles.goto_Button, 'Enable', 'on');
set(handles.edge_Button, 'Enable', 'on');
set(handles.distance_Button, 'Enable', 'on');
set(handles.erosion_Button, 'Enable', 'on');
set(handles.next_Button, 'Enable', 'on');
set(handles.levelset_Button, 'Enable', 'on');

% update hObject with new handles
guidata(hObject, handles);
%%

% --- Executes on button press in threshold_Button.
function threshold_Button_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
threshold_Op(hObject, handles);

% --- Executes on button press in labeling_Button.
function labeling_Button_Callback(hObject, eventdata, handles)
% hObject    handle to labeling_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
labeling_Op(hObject, handles);



% --- Executes on button press in circle_Button.
function circle_Button_Callback(hObject, eventdata, handles)
% hObject    handle to circle_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
circle_Op(hObject, handles);


function tr_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to tr_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tr_Edit as text
%        str2double(get(hObject,'String')) returns contents of tr_Edit as a double

% get value of input field
tr = str2double(get(hObject, 'String'));

% update handles
im = handles.img(:,:, handles.imCount);
handles.tr = tr * max(im(:));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function tr_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tr_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% set initial value
handles.tr = 0;
guidata(hObject, handles);

% --- Executes on button press in dilation_Button.
function dilation_Button_Callback(hObject, eventdata, handles)
% hObject    handle to dilation_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dilation_Op(hObject, handles);

% --- Executes on button press in goto_Button.
function goto_Button_Callback(hObject, eventdata, handles)
% hObject    handle to goto_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% select axes
axes(handles.OrigImg);

% set image to 200
handles.imCount = 200;
im = handles.img(:, :, handles.imCount);

% show image
imshow(im, []);

% update handles
guidata(hObject, handles);

% --- Executes on button press in edge_Button.
function edge_Button_Callback(hObject, eventdata, handles)
% hObject    handle to edge_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

edge_Op(hObject, handles);

% --- Executes on button press in distance_Button.
function distance_Button_Callback(hObject, eventdata, handles)
% hObject    handle to distance_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get two user input positions
[x,y] = ginput(2);

% calculate distance between points
distanceX = max(x) - min(x);
distanceY = max(y) - min(y);
distance = sqrt(distanceX^2 + distanceY^2);

% output distance
set(handles.distance_EditText, 'String', distance);

% --- Executes on button press in erosion_Button.
function erosion_Button_Callback(hObject, eventdata, handles)
% hObject    handle to erosion_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 3D erosion

erosion_Op(hObject, handles);

function sensitivity_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to sensitivity_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sensitivity_Edit as text
%        str2double(get(hObject,'String')) returns contents of sensitivity_Edit as a double

% read sensitivity from input field
sensitivity = str2double(get(hObject, 'String'));

% update handles
handles.sensitivity = sensitivity;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sensitivity_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensitivity_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% set initial sensitivity value
handles.sensitivity = 0;
guidata(hObject, handles);

function radius_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to radius_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_Edit as text
%        str2double(get(hObject,'String')) returns contents of radius_Edit as a double

% get radius from input field
radius = round(str2double(get(hObject, 'String')));

% update handles
handles.radius = radius;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function radius_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% set initial radius
handles.radius = 0;
guidata(hObject, handles);

% --- Executes on button press in levelset_Button.
function levelset_Button_Callback(hObject, eventdata, handles)
% hObject    handle to levelset_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% select image
im = handles.img(:, :, handles.imCount);

% select output axes
axes(handles.ResImg);

%% parameter setting
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

% --- sets threshold of image
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
