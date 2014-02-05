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

% Last Modified by GUIDE v2.5 04-Feb-2014 20:40:31

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

radius = str2double(get(hObject, 'String'));

% set initial radius
handles.radius = radius;
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

sensitivity = str2double(get(hObject, 'String'));
% set initial sensitivity value
handles.sensitivity = sensitivity;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function goto_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to goto_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% set initial goto value
handles.goto = 1;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function iter_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iter_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% set initial goto value
handles.levelset_iter = 30;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function iterInner_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterInner_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% set initial goto value
handles.levelset_iterInner = 5;
guidata(hObject, handles);

%% Edit callbacks

function radius_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to radius_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_Edit as text
%        str2double(get(hObject,'String')) returns contents of radius_Edit as a double

% get radius from input field
radius = str2num(get(hObject, 'String'));

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

function goto_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to goto_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of goto_Edit as text
%        str2double(get(hObject,'String')) returns contents of goto_Edit as a double

% get image number from input field

goto = str2num(get(hObject, 'String'));

if goto > size(handles.files, 1)
    goto = size(handles.files, 1);
end
if goto <= 0
    goto = 1;
end

% show the value in the edit field
set(hObject,'String',num2str(goto));

% update handles
handles.goto = goto;
guidata(hObject, handles);

function iter_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to iter_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iter_Edit as text
%        str2double(get(hObject,'String')) returns contents of iter_Edit as a double

% get iteration value from edit field
iter = str2num(get(hObject, 'String'));

% update handles
handles.levelset_iter = iter;
guidata(hObject, handles);

function iterInner_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to iterInner_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterInner_Edit as text
%        str2double(get(hObject,'String')) returns contents of iterInner_Edit as a double

% get iteration value from edit field
iterInner = str2num(get(hObject, 'String'));

% update handles
handles.levelset_iterInner = iterInner;
guidata(hObject, handles);

%% Button callbacks

% --- Executes on button press in next_Button.
function next_Button_Callback(hObject, eventdata, handles)
% hObject    handle to next_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call next image private function
handles = next(handles);
% update hObject with new handles
guidata(hObject, handles);

% --- Executes on button press in read_Button.
function read_Button_Callback(hObject, eventdata, handles)
% hObject    handle to read_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call read_files private function
handles = read_files(handles);
% update hObject with new handles
guidata(hObject, handles);

% --- Executes on button press in threshold_Button.
function threshold_Button_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get threshold value
tr = handles.tr;
% call threshold private function
handles = threshold(handles, tr);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in labeling_Button.
function labeling_Button_Callback(hObject, eventdata, handles)
% hObject    handle to labeling_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call labeling private function
handles = labeling(handles);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in circle_Button.
function circle_Button_Callback(hObject, eventdata, handles)
% hObject    handle to circle_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get sensitivity value
sensitivity = handles.sensitivity;
% get radius
radius = handles.radius;
% set radius variance (range)
variance = 16;
% call circle finding private function
handles = circle(handles, sensitivity, radius, variance);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in dilation_Button.
function dilation_Button_Callback(hObject, eventdata, handles)
% hObject    handle to dilation_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call dilation private function
handles = dilation(handles);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in goto_Button.
function goto_Button_Callback(hObject, eventdata, handles)
% hObject    handle to goto_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call goto private function
handles = goto(handles);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in edge_Button.
function edge_Button_Callback(hObject, eventdata, handles)
% hObject    handle to edge_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call edge detection private function
handles = edge(handles);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in distance_Button.
function distance_Button_Callback(hObject, eventdata, handles)
% hObject    handle to distance_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call distance private function
handles = distance(handles);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in erosion_Button.
function erosion_Button_Callback(hObject, eventdata, handles)
% hObject    handle to erosion_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 3D erosion

% select image
im = handles.img(:, :, handles.imCount);
% call erosion private function
handles = erosion(handles);
% update guidata
guidata(hObject, handles);

% --- Executes on button press in levelset_Button.
function levelset_Button_Callback(hObject, eventdata, handles)
% hObject    handle to levelset_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get image
im = handles.chain(:, :, end);

% show image on result axes
axes(handles.ResImg);
imshow(im, []);

% get ROI from user
rect = getrect;

% move current image to original image view
axes(handles.OrigImg);
imshow(im, []);
% show the ROI rectangle
rectangle('Position', rect, 'EdgeColor', 'r');

% crop image to ROI
im = imcrop(im, rect);
% show ROI
axes(handles.ResImg);
imshow(im, []);

% get initial rectangle (seed)
rect = getrect;
% show the rectangle
rectangle('Position', rect, 'EdgeColor', 'r');

% initialize LSF as binary step function
c0 = 2;
seed = c0 * ones(size(im));

% generate the initial region R0 as two rectangles
seed(round(rect(2)):round(rect(2)+rect(4)), ...
     round(rect(1)):round(rect(1)+rect(3))) = -c0;

% get iteration values
iter_inner = handles.levelset_iterInner;
iter_outer = handles.levelset_iter;

% call level set function
handles = levelset(handles, im, iter_inner, iter_outer, seed);

% update guidata
guidata(hObject, handles);

% --- Executes on button press in process_Button.
function process_Button_Callback(hObject, eventdata, handles)
% hObject    handle to process_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% call level set private function
handles = process(handles);
% update guidata
guidata(hObject, handles);
