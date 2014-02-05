function h = read_files(handles)

% get folder containing dicom series from user
%folder = uigetdir('C:\Users\JanHenric\SkyDrive\Uni\Uebungen\S5\MedBV\Aortic_aneurysm\4\','Select folder');
folder = uigetdir('./data/', 'Select folder');
files = dir(fullfile(folder, '*.dcm'));

% create handle for files (probably no longer needed though)
handles.files = files;

img = [];
pinfo = [];
chain = [];

% read images
%for k = 1:size(files, 1)
for k = 198:202
    filename = files(k, 1).name;
    
    % print filename
    disp(filename);
    
    % load image data
    im = dicomread(fullfile(folder, filename));
    pi = dicominfo(fullfile(folder, filename));
    
    % add image to matrix
    img = cat(3, img, im);
    pinfo = cat(1, pinfo, pi);
end

% create handle for images and patient info
handles.img = img;
handles.pinfo = pinfo;

% add current image to processing chain
chain = cat(3, chain, zeros(512));
chain = cat(3, chain, img(:, :, 1));
handles.chain = chain;

% show original image
axes(handles.OrigImg);
imshow(chain(:, :, end - 1), []);

% show processed image
axes(handles.ResImg);
imshow(chain(:, :, end), []);

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
set(handles.process_Button, 'Enable', 'on');

% initialize process step counter
handles.step = 0;

% set initial threshold value
% get value of input field
tr = handles.tr;

% update handles
im = handles.img(:,:, handles.imCount);
handles.tr = tr * max(im(:));

% return handle struct
h = handles;

end