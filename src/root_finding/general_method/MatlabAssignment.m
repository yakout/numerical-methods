function varargout = MatlabAssignment(varargin)
addpath('./logic')
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
    set(handles.low,'String','low');
    set(handles.up,'String','up');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','on');
    set(handles.up,'Visible','on');
    set(handles.next,'Visible','on');
elseif (strcmp(popChoice, 'False-position'))
    set(handles.low,'String','low');
    set(handles.up,'String','up');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','on');
    set(handles.up,'Visible','on');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Fixed point'))
    set(handles.low,'String','point');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','off');
    set(handles.up,'Visible','off');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Newton-Raphson'))
    set(handles.low,'String','point');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','off');
    set(handles.up,'Visible','off');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Secant'))
    set(handles.low,'String','point 1');
    set(handles.up,'String','point 2');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','on');
    set(handles.up,'Visible','on');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Bierge-Vieta'))
    set(handles.low,'String','point');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','off');
    set(handles.up,'Visible','off');
    set(handles.next,'Visible','off');
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


function solve_Callback(hObject, eventdata, handles)
popChoice =get(hObject, 'Value');
equation = get(handles.edit1, 'string');
%f = str2func(['@(x)' equation]);
sym x;
f = eval(equation);
f = matlabFunction(f);

disp(f);
n = get(handles.numOfIter,'string')
n = str2double(n);
if isnan(n)
    n = 50;
end
ep = get(handles.RError,'string')
ep = str2double(ep);
if isnan(ep)
    ep = 0.00001
end
disp(n);
disp(ep);

if popChoice == 1
    l = get(handles.l, 'string');
    u = get(handles.u, 'string');
    [root, iterations, data]=bisection(l,u,ep,n,f);
elseif popChoice == 2
    l = get(handles.l, 'string');
    u = get(handles.u, 'string');
    [root, iterations, data]=false_point(l,u,ep,n,f);
elseif popChoice == 3
    i = get(handles.l, 'string');
    [root, iterations, data]=fixed_point(i,ep,n,f);
elseif popChoice == 4
    i = get(handles.l, 'string');
    [root, iterations, data]=newton_raphson(i,ep,n,f);
elseif popChoice == 5
    i1 = get(handles.l, 'string');
    i2 = get(handles.u, 'string');
    [root, iterations, data]=Vsecant(i1,i2,ep,n,f);
elseif popChoice == 6
    i = get(handles.l, 'string');
    birge_vieta(f,i,ep,n);
end
set(handles.tableContent,'Data',data);




function edit5_Callback(hObject, eventdata, handles)


function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plot_Callback(hObject, eventdata, handles)
axes(handles.axes1);
pan on
equation = get(handles.edit1, 'string');
f = str2func(['@(x)' equation]);
disp(f);
syms x
hold off
ezplot(f);
hold on
l = get(handles.l, 'string');
l = str2double(l);
u = get(handles.u, 'string');
u = str2double(u);
y=get(gca,'ylim')
x1=[l,l];
plot(x1,y,'g')
x2=[u,u];
plot(x2,y,'r')

%f=figure;
%fplot(@(x) cos(x),[0 3],'b')
%hold off
%grid on
%x=[0:0.1:10];
%x1=5;
%x=[5,5];
%y=[0,5];
%plot(x,y)
%plot([x1,x1]);
%hold on



function load_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.txt');
fullPath = strcat(pathname,filename);
fileID = fopen(fullPath);
data = textscan(fileID,'%s %s %s %s %s');
eqs = char(data{1}{1});
i1 = char(data{2}{1});
i2 = char(data{3}{1});
n = char(data{4}{1});
ep = char(data{5}{1});
set(handles.edit1,'String',eqs);
set(handles.l,'String',i1);
set(handles.u,'String',i2);
set(handles.numOfIter,'String',n);
set(handles.RError,'String',ep);




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


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function l_CreateFcn(hObject, eventdata, handles)

function u_CreateFcn(hObject, eventdata, handles)

function l_Callback(hObject, eventdata, handles)

function u_Callback(hObject, eventdata, handles)


% --- Executes on button press in compare.
function compare_Callback(hObject, eventdata, handles)
% hObject    handle to compare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%fplot(@(x) cos(x),[0 3],'b')
%hold off
%f=figure;
hold off
set(handles.next,'Visible','off');
x1=[1,2,4,5,6,3,8,9];
y1=[10,2,3,4,5,9,8,9];
plot(x1,y1,'g')
hold on
scatter(x1,y1,'k','x')
x2=[18,16,15,14,10,8,9,5];
y2=[12,11,11,11,10,9,8,5];
plot(x2,y2,'b')
scatter(x2,y2,'k','x');
%grid on
%x=[0:0.1:10];
%x1=5;
%x=[5,5];
%y=[0,5];
%plot(x,y)
%plot([x1,x1]);
%hold on

