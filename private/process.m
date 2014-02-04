function h = process(handles)

% select image
im = handles.img(:, :, handles.imCount);

% perform threshowd
handles = threshold(handles, handles.tr);

pause(1.0);

% perform erosion
handles = erosion(handles);

% update guidata
guidata(hObject, handles);

end

