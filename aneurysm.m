function varargout = aneurysm(varargin)
% ANEURYSM MATLAB code for aneurysm.fig
%      ANEURYSM, by itself, creates a new ANEURYSM or raises the existing
%      singleton*.
%
%      H = ANEURYSM returns the handle to a new ANEURYSM or the handle to
%      the existing singleton*.
%
%      ANEURYSM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANEURYSM.M with the given input arguments.
%
%      ANEURYSM('Property','Value',...) creates a new ANEURYSM or raises the
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

% Last Modified by GUIDE v2.5 08-Jan-2014 14:45:20

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


% --- Executes on button press in SegmentBtn.
function SegmentBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SegmentBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(findobj('Tag','window'));

val = get(handles.ImgSlider,'Value');

im = handles.img(:,:,1);

tr = val * max(im(:));

img_tr = im;
img_tr(im <= tr) = 0;

axes(handles.ResImg);
imshow(img_tr, []);

guidata(hObject, handles);


% --- Executes on slider movement.
function ImgSlider_Callback(hObject, eventdata, handles)
% hObject    handle to ImgSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function ImgSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImgSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in ImportBtn.
function ImportBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ImportBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(findobj('Tag', 'window'));

% get the folder where the image series is located
folder = uigetdir('./data/', 'Select folder');
files = dir(fullfile(folder, '*.dcm'));

img = [];
pinfo = [];

% read images
for k=180:210 % TODO size(files, 1)
    filename = files(k,1).name;
    tmp = dicomread(fullfile(folder, filename));
    tmpinfo = dicominfo(fullfile(folder, filename));
    img = cat(3, img, tmp);
    pinfo = cat(1, pinfo, tmpinfo);
end

% create handle for images and info
handles.img = img;
handles.pinfo = pinfo;

% select axes to use
axes(handles.OrigImg);

% select an image to choose
im = img(:,:,1);
% show image
imshow(im, []);

% activate GUI elements
set(handles.SegmentBtn, 'Enable', 'on');
set(handles.ImgSlider, 'Enable', 'on');

% set GUI parameters
%set(handles.ImgSlider, 'SliderStep', [01 1] / 20 - 1) % max - min

% update handle structure
guidata(hObject, handles);


% --- Executes on scroll wheel click while the figure is in focus.
function window_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to window (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)

% scroll through images here
