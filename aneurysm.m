function varargout = aneurysm(varargin)
% aneurysm MATLAB code for aneurysm.fig
%      aneurysm, by itself, creates a new aneurysm or raises the existing
%      singleton*.
%
%      H = aneurysm returns the handle to a new aneurysm or the handle to
%      the existing singleton*.
%
%      aneurysm('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in aneurysm.M with the given input arguments.
%
%      aneurysm('Property','Value',...) creates a new aneurysm or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aneurysm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aneurysm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aneurysm

% Last Modified by GUIDE v2.5 16-Jan-2014 09:20:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aneurysm_OpeningFcn, ...
                   'gui_OutputFcn',  @aneurysm_OutputFcn, ...
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


% --- Executes just before aneurysm is made visible.
function aneurysm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aneurysm (see VARARGIN)

% Choose default command line output for aneurysm
handles.output = hObject;

% set initial image number
handles.imCount = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aneurysm wait for user response (see UIRESUME)
% uiwait(handles.window);

% --- Outputs from this function are returned to the command line.
function varargout = aneurysm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% Create callbacks

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

%% Edit callbacks

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

%% Button callbacks

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

% --- Executes on button press in levelset_Button.
function levelset_Button_Callback(hObject, eventdata, handles)
% hObject    handle to levelset_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

levelset_Op(hObject, handles);