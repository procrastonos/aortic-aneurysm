function h = process(handles)

%% Thresholding

if handles.step == 0
    % save original image
    handles.orig = handles.chain(:, :, end);

    % perform threshold
    handles = threshold(handles, handles.tr);
    % save thresholded image for later
    handles.thresholded = handles.chain(:, :, end);
    hold on;
    str = ['Threshold image at ', num2str(handles.tr)];
    title(str);
end

%% Eroding

if handles.step >= 1 && handles.step <= 5
    % perform erosion
    handles = erosion(handles);
    % save eroded image result for later
    handles.eroded = handles.chain(:, :, end);
    hold on;
    title(['Erosion pass ', num2str(handles.step)]);
    
end

if handles.step == 6
    handles.step = handles.step + 1;
end

%% ROI selection

if handles.step == 7
    % show eroded image in original image axes
    axes(handles.OrigImg);
    imshow(handles.eroded, []);
    hold on;
    title('Preprocessing result');

    % show image again on result axes
    axes(handles.ResImg);
    imshow(handles.orig, []);
    title('Please select region of interest...');

    % get ROI from user
    handles.rect = getrect;
     
    % show ROI
    rectangle('Position', handles.rect, 'EdgeColor', 'r', 'LineStyle','--');
end

%% ROI cropping

if handles.step == 8
    % move current image to original image view
    axes(handles.OrigImg);
    % show eroded image with ROI
    imshow(handles.eroded, []);
    hold on;
    title('Preprocessing result with ROI');
    % show the rectangle
    rectangle('Position', handles.rect, 'EdgeColor', 'b', 'LineStyle','--');
    
    % crop image to ROI
    handles.cropped = imcrop(handles.orig, handles.rect);
    handles.mask = imcrop(handles.eroded, handles.rect);
  
    % show ROI
    axes(handles.ResImg);
    [nrow, ncol] = size(handles.cropped);
    axis([1 ncol 1 nrow -5 5]);
    cla;
    imshow(handles.cropped, []);
    hold on;
    title('Image cropped to ROI');
end

%% DRLSE

if handles.step == 9
    % initialize LSF as binary step function
    c0 = 2;
    handles.seed = c0 * ones(size(handles.cropped));

    % 
    handles.seed(handles.mask > 0) = -c0;
    
    contour(handles.seed, [0,0], 'b');
    title('Initial zero level contour');
end

if handles.step == 10
    % get iteration values
    iter_inner = handles.levelset_iterInner;
    iter_outer = handles.levelset_iter;

    % call level set private function
    handles = levelset(handles, handles.cropped, iter_inner, iter_outer, handles.seed);
end

if handles.step == 11
    % define structure element for erosion
    se = strel('disk', 5);
    % erode contour
    handles.erodeLSF = imerode(handles.contour, se);
    % show image
    imshow(handles.cropped, []);
    hold on;
    title('Eroded contour');
    % and draw contour in blue
    contour(handles.erodeLSF, [0,0], 'b');
end

%% Second DRLSE pass

if handles.step == 12
    iter_inner = handles.levelset_iterInner;
    iter_outer = handles.levelset_iter;
    % call level set function a second time
    handles = levelset(handles, handles.cropped, iter_inner, iter_outer, handles.erodeLSF);
end
    
% increment step counter
handles.step = handles.step + 1;
% update guidata
h = handles;

end

