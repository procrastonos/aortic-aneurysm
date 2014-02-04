function h = distance(handles)

% get two user input positions
[x,y] = ginput(2);

% calculate distance between points
distanceX = max(x) - min(x);
distanceY = max(y) - min(y);
distance = sqrt(distanceX^2 + distanceY^2);

% select axis
%axes(handles.OrigImg);
axes(gca);
% draw line
line(x,y);

% output distance
set(handles.distance_EditText, 'String', distance);

% return handle struct
h = handles;

end

