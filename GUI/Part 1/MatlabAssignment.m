function varargout = MatlabAssignment(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MatlabAssignment_OpeningFcn, ...
                   'gui_OutputFcn',  @MatlabAssignment_OutputFcn, ...
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


function MatlabAssignment_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);



function varargout = MatlabAssignment_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function popupmenu1_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject, 'Value')};
if (strcmp(popChoice, 'Bisection'))
     prompt = {'Enter lower initial point','Enter upper initial point'};
     dlgTitle = 'Input parameters';
     def = {'',''};
     answer = inputdlg(prompt,dlgTitle, [1, 50],def);
     l = str2double(answer(1));
     u = str2double(answer(2));
     result = sprintf('l is : %d \n u is : %d', l,u);
     if(isnan(l) || isnan(u))
         g = msgbox(['Invalid Parameters']);
     else
        set(handles.show,'string',result);
     end
elseif (strcmp(popChoice, 'False-position'))
     prompt = {'Enter lower initial point','Enter upper initial point'};
     dlgTitle = 'Input parameters';
     def = {'',''};
     answer = inputdlg(prompt,dlgTitle, [1, 50],def);
     l = str2double(answer(1));
     u = str2double(answer(2));
     result = sprintf('l is : %d \n u is : %d', l,u);
     if(isnan(l) || isnan(u))
         g = msgbox(['Invalid Parameters']);
     else
        set(handles.show,'string',result);
     end
elseif (strcmp(popChoice, 'Fixed point'))
     prompt = {'Enter initial point'};
     dlgTitle = 'Input parameters';
     def = {''};
     answer = inputdlg(prompt,dlgTitle, [1, 50],def);
     i = str2double(answer(1));
     result = sprintf('i is : %d ', i);
     if(isnan(i))
         g = msgbox(['Invalid Parameters']);
     else
        set(handles.show,'string',result);
     end
elseif (strcmp(popChoice, 'Newton-Raphson'))
     prompt = {'Enter initial point'};
     dlgTitle = 'Input parameters';
     def = {''};
     answer = inputdlg(prompt,dlgTitle, [1, 50],def);
     i = str2double(answer(1));
     result = sprintf('i is : %d ', i);
     if(isnan(i))
         g = msgbox(['Invalid Parameters']);
     else
        set(handles.show,'string',result);
     end
elseif (strcmp(popChoice, 'Secant'))
     prompt = {'Enter first initial point','Enter second initial point'};
     dlgTitle = 'Input parameters';
     def = {'',''};
     answer = inputdlg(prompt,dlgTitle, [1, 50],def);
     i1 = str2double(answer(1));
     i2 = str2double(answer(2));
     result = sprintf('i1 is : %d \n i2 is : %d', i1,i2);
     if(isnan(i1) || isnan(i2))
         g = msgbox(['Invalid Parameters']);
     else
        set(handles.show,'string',result);
     end
elseif (strcmp(popChoice, 'Bierge-Vieta'))
     prompt = {'Enter first initial point'};
     dlgTitle = 'Input parameters';
     def = {''};
     answer = inputdlg(prompt,dlgTitle, [1, 50],def);
     i = str2double(answer(1));
     result = sprintf('i is : %d', i);
     if(isnan(i))
         g = msgbox(['Invalid Parameters']);
     else
        set(handles.show,'string',result);
     end
end
 

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function solveBtn_Callback(hObject, eventdata, handles)


function addBtn_Callback(hObject, eventdata, handles)
equation = get(handles.edit1, 'string');
set(handles.show,'String',equation);



function edit5_Callback(hObject, eventdata, handles)


function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plotBtn_Callback(hObject, eventdata, handles)
f=figure;
fplot(@(x) cos(x),[0 3],'b')
hold off
grid on



function loadBtn_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.txt');
fullPath = strcat(pathname,filename);
fileID = fopen(fullPath);
data = textscan(fileID,'%s %s %s');
eqs = char(data{1}{1});
i1 = str2double(data{2}{1});
i2 = str2double(data{3}{1});
result = sprintf('%s   %f   %f', eqs , i1, i2);
set(handles.show,'String',result);



function numOfIter_Callback(hObject, eventdata, handles)
% hObject    handle to numOfIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numOfIter as text
%        str2double(get(hObject,'String')) returns contents of numOfIter as a double


% --- Executes during object creation, after setting all properties.
function numOfIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numOfIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RError_Callback(hObject, eventdata, handles)
% hObject    handle to RError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RError as text
%        str2double(get(hObject,'String')) returns contents of RError as a double


% --- Executes during object creation, after setting all properties.
function RError_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
