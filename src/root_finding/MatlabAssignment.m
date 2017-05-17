function varargout = MatlabAssignment(varargin)
%addpath('./logic');
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
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.low,'String','low');
    set(handles.up,'String','up');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','on');
    set(handles.up,'Visible','on');
    set(handles.next,'Visible','on');
elseif (strcmp(popChoice, 'False-position'))
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.low,'String','low');
    set(handles.up,'String','up');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','on');
    set(handles.up,'Visible','on');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Fixed point'))
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.low,'String','point');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','off');
    set(handles.up,'Visible','off');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Newton-Raphson'))
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.low,'String','point');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','off');
    set(handles.up,'Visible','off');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Secant'))
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.low,'String','point 1');
    set(handles.up,'String','point 2');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','on');
    set(handles.up,'Visible','on');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'Bierge-Vieta'))
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.low,'String','point');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','off');
    set(handles.up,'Visible','off');
    set(handles.next,'Visible','off');
elseif (strcmp(popChoice, 'General-Method'))
    set(handles.low,'String','point');

    set(handles.u,'Visible','off');
    set(handles.uipanel3,'Visible','off');
    set(handles.uipanel4,'Visible','off');
elseif (strcmp(popChoice, 'All methods'))
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.low,'String','low');
    set(handles.up,'String','up');
    set(handles.l,'Visible','on');
    set(handles.low,'Visible','on');
    set(handles.u,'Visible','on');
    set(handles.up,'Visible','on');
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
popChoice = get(handles.popupmenu1, 'Value');

equation = get(handles.edit1, 'string');
f = (['@(x)' equation]);
f= str2func(f);

disp(f);
%sym x;
%f = eval(equation);
%f = matlabFunction(f)


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

disp(popChoice)

if popChoice == 1
    l = get(handles.l, 'string');
    u = get(handles.u, 'string');
    l = str2double(l);
    u = str2double(u);
   [root, iterations, data]=bisection(l,u,ep,n,f);
elseif popChoice == 2
    l = get(handles.l, 'string');
    u = get(handles.u, 'string');
    l = str2double(l);
    u = str2double(u);
    [root, iterations, data]=false_position(l,u,ep,n,f);
elseif popChoice == 3
    i = get(handles.l, 'string');
    i = str2double(i);
    [root, iterations, data]=fixed_point(i,ep,n,f);
elseif popChoice == 4
    i = get(handles.l, 'string');
    i = str2double(i);
    [root, iterations, data]=newton_raphson(i,ep,n,f);
elseif popChoice == 5
    i1 = get(handles.l, 'string');
    i2 = get(handles.u, 'string');
    i1 = str2double(i1);
    i2 = str2double(i2);
    [root, iterations, data]=secant(i1,i2,ep,n,f);
elseif popChoice == 6
    i = get(handles.l, 'string');
    i = str2double(i);
    [roots, iterations, data]=birge_vieta(f,i,ep,n,1);
    data=roots;
    %birge_vieta(f,i,ep,n);
elseif popChoice == 7
    [roots, iterations, data] = general_method(f);
    data=roots;
elseif popChoice == 8
    l = get(handles.l, 'string');
    u = get(handles.u, 'string');
    l = str2double(l);
    u = str2double(u);
    [r1, iter1, d1] =bisection(l,u,ep,n,f);
    [r2, iter2, d2]=false_position(l,u,ep,n,f);
    [r3, iter3, d3]=newton_raphson(l,ep,n,f);
    [r4, iter4, d4]=secant(l,u,ep,n,f);
    %[r5, iterations, data]=fixed_point(i,ep,n,f);
    %[r6, iterations, data]=birge_vieta(f,i,ep,n,1);
    %d11=d1(: );
    disp('*******************************')
    %d11=d1(iter1,4);
    result = [r1,iter1,d1(iter1,4)];
    result = [result; r2, iter2, d2(iter2,4)];
    result = [result; r3, iter3, d3(iter3,2)];
    result = [result; r4, iter4, d4(iter4,2)];
    
    data=result;
end
set(handles.tableContent,'Data',data);




function edit5_Callback(hObject, eventdata, handles)


function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plot_Callback(hObject, eventdata, handles)
popChoice = get(handles.popupmenu1, 'Value');
axes(handles.axes1);
pan on
equation = get(handles.edit1, 'string');
f = str2func(['@(x)' equation]);
disp(f);
syms x
hold off

if popChoice==4 || popChoice==5 || popChoice==6
    syms x;
    z = diff(f(x));
    fxp = inline(char(z));
    ezplot(fxp);
else
    ezplot(f);
end
hold on
l = get(handles.l, 'string');
l = str2double(l);
u = get(handles.u, 'string');
u = str2double(u);
y=get(gca,'ylim')
x1=[l,l];
plot(x1,y,'g')
if popChoice==1 || popChoice==2 || popChoice==5 || popChoice==7
x2=[u,u];
plot(x2,y,'r')
end

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
f=figure;
hold off
%EVALUATE NUMBER OF ITERATIONS
n = get(handles.numOfIter,'string');
n = str2double(n);
if isnan(n)
    n = 50;
end

%GET EPSILON
ep = get(handles.RError,'string');
ep = str2double(ep);
if isnan(ep)
    ep = 0.00001;
end

%GET LIMITS
l = get(handles.l, 'string');
u = get(handles.u, 'string');
l = str2double(l);
u = str2double(u);

%GET FUNCTION
equation = get(handles.edit1, 'string');
f = (['@(x)' equation]);
f= str2func(f);
disp(f)

%************************************************
%PLOT FOR BISECTION
[w, iterations, data] =bisection(l,u,ep,n,f);
y2=data(:,4);
x2=1:iterations;
plot(x2,y2,'y');
hold on
scatter(x2,y2,'k','x');

%PLOT FOR FALSE_POSITION
[w, iterations, data] =false_position(l,u,ep,n,f);
y2=data(:,4);
x2=1:iterations;
plot(x2,y2,'r');
scatter(x2,y2,'k','x');

%PLOT FOR NEWTON
[w, iterations, data] =newton_raphson(l,ep, n, f);
y2=data(:,2);
x2=1:iterations;
plot(x2,y2,'b');
scatter(x2,y2,'k','x');

%PLOT FOR SECANT
[w, iterations, data] =secant(l,u,ep,n,f);
y2=data(:,2);
x2=1:iterations;
plot(x2,y2,'m');
scatter(x2,y2,'k','x');

legend('show');
legend('bisection', '', 'false-position', '', 'newton-raphson', '', 'secant');

%ITERATION-APPROX PLOT
%***********************************
f=figure;
hold off
%EVALUATE NUMBER OF ITERATIONS
n = get(handles.numOfIter,'string');
n = str2double(n);
if isnan(n)
    n = 50;
end

%GET EPSILON
ep = get(handles.RError,'string');
ep = str2double(ep);
if isnan(ep)
    ep = 0.00001;
end

%GET LIMITS
l = get(handles.l, 'string');
u = get(handles.u, 'string');
l = str2double(l);
u = str2double(u);

%GET FUNCTION
equation = get(handles.edit1, 'string');
f = (['@(x)' equation]);
f= str2func(f);
disp(f)

%************************************************
%PLOT FOR BISECTION
[w, iterations, data] =bisection(l,u,ep,n,f);
y2=data(:,3);
x2=1:iterations;
plot(x2,y2,'y');
hold on
scatter(x2,y2,'k','x');

%PLOT FOR FALSE_POSITION
[w, iterations, data] =false_position(l,u,ep,n,f);
y2=data(:,3);
x2=1:iterations;
plot(x2,y2,'r');
scatter(x2,y2,'k','x');

%PLOT FOR NEWTON
[w, iterations, data] =newton_raphson(l,ep, n, f);
y2=data(:,1);
x2=1:iterations;
plot(x2,y2,'b');
scatter(x2,y2,'k','x');

%PLOT FOR SECANT
[w, iterations, data] =secant(l,u,ep,n,f);
y2=data(:,1);
x2=1:iterations;
plot(x2,y2,'m');
scatter(x2,y2,'k','x');

legend('show');
legend('bisection', '', 'false-position', '', 'newton-raphson', '', 'secant');
