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

% Last Modified by GUIDE v2.5 10-Jan-2014 12:44:13

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
av_files2 = handles.av_files;
path2 = handles.path;
imCount = handles.imCount;
name = av_files2(imCount,1).name;
img = dicomread(fullfile(path2, name));
imshow(img, []);
handles.img = img;
imCount = imCount + 1;
handles.imCount = imCount;
guidata(hObject, handles);


% --- Executes on button press in read_Button.
function read_Button_Callback(hObject, eventdata, handles)
% hObject    handle to read_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% av_files = dir(fullfile(path,'*.dcm'));
% read DICOM image
[file, path]=uigetfile('C:\Users\JanHenric\SkyDrive\Uni\�bungen\S5\MedBV\Aortic_aneurysm\4\*.dcm*','Select the file to read');
av_files = dir(fullfile(path,'*.dcm'));  
img=dicomread(fullfile(path,file));    %to reactivate
%img = imread(fullfile(path, file)); %to remove
%img = rgb2gray(img);
%pinfo=dicominfo(fullfile(path,file)); 
axes(handles.axes1);
imshow(img, []);
handles.img=img;
handles.av_files = av_files;
%handles.pinfo=pinfo;
handles.path = path;

set(handles.threshold_Button, 'Enable', 'on');
set(handles.circle_Button, 'Enable', 'on');
set(handles.labeling_Button, 'Enable', 'on');
set(handles.dilation_Button, 'Enable', 'on');
set(handles.goto_Button, 'Enable', 'on');
set(handles.edge_Button, 'Enable', 'on');
set(handles.distance_Button, 'Enable', 'on');
guidata(hObject, handles);
%%


% --- Executes on button press in threshold_Button.
function threshold_Button_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tr = handles.tr;
trmask=handles.img;
trmask(trmask<=tr)=0;
axes(handles.axes1);
imshow(trmask,[]);
handles.img=trmask;
guidata(hObject, handles);


% --- Executes on button press in labeling_Button.
function labeling_Button_Callback(hObject, eventdata, handles)
% hObject    handle to labeling_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.img;
[y,x] = ginput(1);
set(handles.x_Text,'String',x);
set(handles.y_Text,'String',y);

gr = img(round(x), round(y));
% global criteria
tr1 = gr-0.2*gr;
tr2 = gr+0.2*gr;

% perform the thresholding operation
data=zeros(size(img));
data(img>=tr1&img<=tr2)=1;

bl = bwlabeln(data, 4);
axes(handles.axes1);
imshow(bl, []);
lab = bl(round(x),round(y));
bll = bl;
bll(bll~=lab)=0;
bll(bll~=0)=1;
figure; imshow(bll,[]);



% --- Executes on button press in circle_Button.
function circle_Button_Callback(hObject, eventdata, handles)
% hObject    handle to circle_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.img;
sensitivity = handles.sensitivity
[centers,radii] = imfindcircles(img, [30 45],'Sensitivity',sensitivity);
set(handles.center_Text, 'String', centers);
axes(handles.axes1);
imshow(img, []);
viscircles(centers,radii);
handles.img = img;
guidata(hObject, handles);





function tr_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to tr_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tr_Edit as text
%        str2double(get(hObject,'String')) returns contents of tr_Edit as a double
tr = str2double(get(hObject, 'String'));
handles.tr = tr*max(handles.img(:));
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
handles.tr = 0;
guidata(hObject, handles);


% --- Executes on button press in dilation_Button.
function dilation_Button_Callback(hObject, eventdata, handles)
% hObject    handle to dilation_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.img;
tr = handles.tr;
se = strel('disk', 1);
img(img <= tr) = 0;
im_dl = imdilate(img,se);
axes(handles.axes1);
imshow(im_dl, []);
handles.img = im_dl;
guidata(hObject, handles);



% --- Executes on button press in goto_Button.
function goto_Button_Callback(hObject, eventdata, handles)
% hObject    handle to goto_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
av_files = handles.av_files;
path = handles.path;
name = av_files(200,1).name;
img = dicomread(fullfile(path, name));
axes(handles.axes1);
imshow(img, []);
handles.imCount = 200;
handles.img = img;
guidata(hObject, handles);



% --- Executes on button press in edge_Button.
function edge_Button_Callback(hObject, eventdata, handles)
% hObject    handle to edge_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.img;
h = fspecial('Prewitt');
imfil = filter2(h,img,'same');
axes(handles.axes1);
imshow(imfil, []);
handles.img = imfil;
guidata(hObject, handles);



% --- Executes on button press in distance_Button.
function distance_Button_Callback(hObject, eventdata, handles)
% hObject    handle to distance_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y] = ginput(2);
distanceX = max(x) - min(x);
distanceY = max(y) - min(y);
distance = sqrt(distanceX^2 + distanceY^2);
set(handles.distanceX_Text, 'String', distanceX);
set(handles.distanceY_Text, 'String', distanceY);
set(handles.distance_Text, 'String', distance);


% --- Executes on button press in erosion_Button.
function erosion_Button_Callback(hObject, eventdata, handles)
% hObject    handle to erosion_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function sensitivity_InputText_Callback(hObject, eventdata, handles)
% hObject    handle to sensitivity_InputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sensitivity_InputText as text
%        str2double(get(hObject,'String')) returns contents of sensitivity_InputText as a double
sensitivity = str2double(get(hObject, 'String'));
handles.sensitivity = sensitivity
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sensitivity_InputText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensitivity_InputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.sensitivity = 0;
