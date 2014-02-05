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
    str = ['Threshold image at ', ...
          num2str((handles.tr/max(handles.orig(:))) * 100.0), ...
          '% brightness']
    title(str);
end

%% Eroding

if handles.step >= 1 && handles.step <= 6
    % perform erosion
    handles = erosion(handles);
    % save eroded image result for later
    handles.eroded = handles.chain(:, :, end);
    hold on;
    title(['Erosion pass ', num2str(handles.step - 1)]);
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
    hold on;
    title('Please select region of interest...');

    % get ROI from user
    handles.rect = getrect;
    rectangle('Position', handles.rect, 'EdgeColor', 'r');
end

%% ROI cropping

if handles.step == 8
    % move current image to original image view
    axes(handles.OrigImg);
    % show eroded image with ROI
    imshow(handles.eroded, []);
    % show the rectangle
    rectangle('Position', handles.rect, 'EdgeColor', 'r');

    % crop image to ROI
    handles.cropped = imcrop(handles.orig, handles.rect);
    handles.mask = imcrop(handles.eroded, handles.rect);
    % show ROI
    axes(handles.ResImg);
    imshow(handles.cropped, [], 'XData', [0 1.0], 'YData', [0 1.0]);

    contour(handles.mask, [0,0], 'r');
end

%% DRLSE

if handles.step == 9
    % initialize LSF as binary step function
    c0 = 2;
    seed = c0 * ones(size(handles.chain(:, :, end)));

    % generate the initial region R0 as two rectangles
    %seed(round(rect(2)):round(rect(2)+rect(4)), ...
    %     round(rect(1)):round(rect(1)+rect(3))) = -c0;
    seed(handles.mask > 0) = -c0;

    % get iteration values
    iter_inner = handles.levelset_iterInner;
    iter_outer = handles.levelset_iter;

    % call level set private function
    handles = levelset(handles, im, iter_inner, iter_outer, seed);

    % define structure element for erosion
    se = strel('disk', 5);
    % erode contour
    erodeLSF = imerode(handles.contour, se);
    % show image
    imshow(im, []);
    hold on;
    % and draw contour in blue
    contour(erodeLSF, [0,0], 'b');
    % wait for a moment
end

%% Second DRLSE pass

if handles.step == 10
    % call level set function a second time
    handles = levelset(handles, im, iter_inner, iter_outer, erodeLSF);
end
    
% increment step counter
handles.step = handles.step + 1;
% update guidata
h = handles;

end

