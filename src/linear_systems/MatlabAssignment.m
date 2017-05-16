function varargout = MatlabAssignment(varargin)
addpath('./logic');
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
%NAIVE GAUSS****************************
popChoice = get(handles.popupmenu1, 'Value');
if (popChoice==4)
set(handles.text10,'Visible','on')
set(handles.text11,'Visible','on')
set(handles.text13,'Visible','on')
set(handles.edit10,'Visible','on')
set(handles.edit11,'Visible','on')
set(handles.edit12,'Visible','on')
else 
    set(handles.text10,'Visible','off')
set(handles.text11,'Visible','off')
set(handles.text13,'Visible','off')
set(handles.edit10,'Visible','off')
set(handles.edit11,'Visible','off')
set(handles.edit12,'Visible','off')
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
data=get(handles.tableContent,'Data');
finalres={};
eqn={};
labels=get(handles.edit9, 'string');
eval(['syms ' labels]);
for i=1:numel(data)
      disp(data(i));
    finalres=[finalres;char(data(i))];  
end
for  c = 1:numel(data)
eqn = [eqn,eval(strrep(char(finalres(c)),'=','=='))];
end
[A,B] = equationsToMatrix(eqn);

ss=sprintf('%s\n%s',char(B),char(A));

%if(get(handles.popupmenu1,'Value')=='Gaussian elimination')

strsplit(labels,' ')
d=strsplit(labels,' ');

d=d';

%NAIVE GAUSS****************************
popChoice = get(handles.popupmenu1, 'Value');
if (popChoice==1)
    w=naive_gauss(A,B,numel(data));
w = strread(num2str(w),'%s')
d=cat(2,d,w);
set(handles.uitable6,'Data',d);
set(handles.uitable6,'Visible','on')

%LU DECOMPOSITION***********************
elseif (popChoice==2)
    w=lu_decomposition(A,B,numel(data));
w = strread(num2str(w),'%s')
d=cat(2,d,w);
set(handles.uitable6,'Data',d);
set(handles.uitable6,'Visible','on')

%GAUSS JORDAN**************************
elseif (popChoice==3)
    w=gauss_jordan(A,B,numel(data));
w = strread(num2str(w),'%s')
d=cat(2,d,w);
set(handles.uitable6,'Data',d);
set(handles.uitable6,'Visible','on')

%GAUSS SIEDEL**************************
    elseif (popChoice==4)
        init=str2double(strsplit(get(handles.edit12,'string'),' '));
        maxIter=str2double(get(handles.edit11,'string'));
        epsilon=str2double(get(handles.edit10,'string'));
        w=gauss_siedel(A,B,init,maxIter,epsilon);
    w = strread(num2str(w),'%s');
    d=cat(2,d,w);
    set(handles.uitable6,'Data',d);
    set(handles.uitable6,'Visible','on')

    end

%set(handles.show,'String',char(m)); 
%end


function addBtn_Callback(hObject, eventdata, handles)
num = str2double(get(handles.edit1, 'string'));
labels=get(handles.edit9, 'string');
eval(['syms ' labels]);
Ncolumns=1;
Nrows=num;
set(handles.tableContent,'Data',cell(Nrows,Ncolumns))
set(handles.tableContent,'Visible','on')
set(handles.tableContent,'Visible','on')
set(handles.tableContent,'columnname','Equations')




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
tline = fgetl(fileID);
num=str2double(tline)
labels = fgetl(fileID)
tline = fgetl(fileID);
finalres={};
eqn={};
while ischar(tline)
      disp(tline);
    finalres=[finalres;tline];  
    tline = fgetl(fileID);
    
end
eval(['syms ' labels]);

  
fclose(fileID);

for  c = 1:num
eqn = [eqn,eval(strrep(char(finalres(c)),'=','=='))]
end
[A,B] = equationsToMatrix(eqn)

ss=sprintf('%s\n%s',char(B),char(A));
set(handles.show,'String',ss);



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



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
