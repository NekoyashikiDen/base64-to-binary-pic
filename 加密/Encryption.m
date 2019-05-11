function varargout = Encryption(varargin)
% ENCRYPTIONLIST MATLAB code for EncryptionList.fig
%      ENCRYPTIONLIST, by itself, creates a new ENCRYPTIONLIST or raises the existing
%      singleton*.
%
%      H = ENCRYPTIONLIST returns the handle to a new ENCRYPTIONLIST or the handle to
%      the existing singleton*.
%
%      ENCRYPTIONLIST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENCRYPTIONLIST.M with the given input arguments.
%
%      ENCRYPTIONLIST('Property','Value',...) creates a new ENCRYPTIONLIST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Encryption_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Encryption_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EncryptionList

% Last Modified by GUIDE v2.5 21-Dec-2017 17:03:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Encryption_OpeningFcn, ...
                   'gui_OutputFcn',  @Encryption_OutputFcn, ...
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
% End initialization code - DO NOT EDIT



% --- Executes just before EncryptionList is made visible.
function Encryption_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EncryptionList (see VARARGIN)

% Choose default command line output for EncryptionList
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EncryptionList wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.Square,'Value',1);
set(handles.Custom,'Value',0);
x=(0:0.1:20)';
y_0=bessely(0,x);
y_1=bessely(1,x);
y_2=bessely(2,x);
axes(handles.Image);
plot(x,y_0,'',x,y_1,'',x,y_2,'');
axis([0,20,-1,1]);



% --- Outputs from this function are returned to the command line.
function varargout = Encryption_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in LoadText.
function LoadText_Callback(hObject, eventdata, handles)
% hObject    handle to LoadText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tx;
global pathfile;
[fname,pname]=uigetfile('*.txt','打开文本');
if isequal(fname,0)
    warndlg('未选择文本','警告');
    return;
else
    pathfile=fullfile(pname,fname);
    tx=fileread(pathfile);
end
set(handles.Text,'String',tx);
set(handles.PathFile,'String',pathfile);



function PathFile_Callback(hObject, eventdata, handles)
% hObject    handle to PathFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathFile as text
%        str2double(get(hObject,'String')) returns contents of PathFile as a double
global pathfile;
global tx;
pathfile=get(handles.PathFile,'String');
try
    tx=fileread(pathfile);
    set(handles.Text,'String',tx);
catch
    errordlg('路径或文件名错误','错误');
end



% --- Executes during object creation, after setting all properties.
function PathFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Text_Callback(hObject, eventdata, handles)
% hObject    handle to Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Text as text
%        str2double(get(hObject,'String')) returns contents of Text as a double



% --- Executes during object creation, after setting all properties.
function Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in EncryptionList.
function EncryptionList_Callback(hObject, eventdata, handles)
% hObject    handle to EncryptionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns EncryptionList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from EncryptionList



% --- Executes during object creation, after setting all properties.
function EncryptionList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EncryptionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tx;
global f4;
hwait=waitbar(0,'转换文本为二进制');
f=reshape(num2str(dec2bin(tx,8)'),1,[]);
[~,n]=size(f);
switch get(handles.EncryptionList,'Value')
    case 1
        waitbar(0.1,hwait,'进行Base64加密');
        if mod(n,24)==0
            f0=f;
        elseif mod(n,24)==16
            fill=[61];
            f0=[f,'0','0'];
        else
            fill=[61,61];
            f0=[f,'0','0','0','0'];
        end
        f0=bin2dec(reshape(f0,6,[])');
        chart=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'];
        [m,~]=size(f0);
        f1=zeros();
        t=0;
        for i=1:m
            try
                t=t+1;
                f1(i)=chart(f0(i)+1);
                waitbar(0.1+t*0.3/m,hwait);
            catch
                errordlg('遇到不可预料的运算错误','错误');
                close(hwait);
                return;
            end
        end
        waitbar(0.4,hwait,'生成Base64码');
        f1=reshape(dec2bin([f1,fill],8)',1,[]);
        [m,n]=size(f1);
        if get(handles.Square,'Value')==1
            waitbar(0.5,hwait,'计算新的矩阵');
            length=ceil(sqrt(m*n));
            temp=[num2str(length),' x ',num2str(length)];
            set(handles.Size,'String',temp);
        elseif get(handles.Custom,'Value')==1
            waitbar(0.5,hwait,'计算新的矩阵');
            length=str2num(get(handles.Length,'String'));
            width=str2num(get(handles.Width,'String'));
            if length*width<m*n
                errordlg('设定图像过小','错误');
                close(hwait);
            end
        else
            errordlg('尚未设置图像大小','错误');
            close(hwait);
            return;
        end
        waitbar(0.6,hwait,'生成图像');
        zero=zeros(1,length^2-m*n);
            f2=(uint8(reshape([f1,zero],length,[])')-48)*255;
            t=0;
            for i=1:3
                t=t+1;
                waitbar(0.6+t*0.1,hwait);
                f3(:,:,i)=f2;
            end
            axes(handles.Image);
            imshow(f3);
            waitbar(1,hwait,'加密完成');
            close(hwait);
        f4=f3;
    case 2
        errordlg('说了没有了还选','错误');
end



% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f4;
[fname,pname]=uiputfile('CipherImage.bmp','选择保存位置');
if isequal(fname,0)
    warndlg('未选择保存位置','警告');
    return;
end
pathfile=fullfile(pname,fname);
try
    imwrite(f4,pathfile);
    helpdlg('保存成功','完成');
catch
    errordlg('保存失败','错误');
end



% --- Executes on button press in Square.
function Square_Callback(hObject, eventdata, handles)
% hObject    handle to Square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Square
set(handles.Custom,'Value',0);



% --- Executes on button press in Custom.
function Custom_Callback(hObject, eventdata, handles)
% hObject    handle to Custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Custom
set(handles.Square,'Value',0);



function Width_Callback(hObject, eventdata, handles)
% hObject    handle to Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Width as text
%        str2double(get(hObject,'String')) returns contents of Width as a double



% --- Executes during object creation, after setting all properties.
function Width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Length_Callback(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Length as text
%        str2double(get(hObject,'String')) returns contents of Length as a double



% --- Executes during object creation, after setting all properties.
function Length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Size_Callback(hObject, eventdata, handles)
% hObject    handle to Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Size as text
%        str2double(get(hObject,'String')) returns contents of Size as a double



% --- Executes during object creation, after setting all properties.
function Size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end