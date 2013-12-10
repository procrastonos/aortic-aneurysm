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

% Last Modified by GUIDE v2.5 10-Dec-2013 14:54:36

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
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aneurysm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
