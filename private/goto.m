function h = goto(handles)
    % select axes
    axes(handles.OrigImg);

    % set current image to goto value
    handles.imCount = handles.goto;
    % select new image
    im = handles.img(:, :, handles.imCount);

    % show image
    imshow(im, []);

    % update handles
    guidata(hObject, handles);
   
    % return handle struct
    h = handles;
end