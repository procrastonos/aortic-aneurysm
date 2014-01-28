function h = read_files(handles)

% get folder containing dicom series from user
%folder = uigetdir('C:\Users\JanHenric\SkyDrive\Uni\Uebungen\S5\MedBV\Aortic_aneurysm\4\','Select folder');
folder = uigetdir('./data/', 'Select folder');
files = dir(fullfile(folder, '*.dcm'));

% create handle for files (probably no longer needed though)
handles.files = files;

img = [];
pinfo = [];

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

% return handle struct
h = handles;

end