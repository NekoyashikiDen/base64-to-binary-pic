function varargout = Decryption(varargin)
% DECRYPTIONLIST MATLAB code for DecryptionList.fig
%      DECRYPTIONLIST, by itself, creates a new DECRYPTIONLIST or raises the existing
%      singleton*.
%
%      H = DECRYPTIONLIST returns the handle to a new DECRYPTIONLIST or the handle to
%      the existing singleton*.
%
%      DECRYPTIONLIST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECRYPTIONLIST.M with the given input arguments.
%
%      DECRYPTIONLIST('Property','Value',...) creates a new DECRYPTIONLIST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decryption_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decryption_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DecryptionList

% Last Modified by GUIDE v2.5 21-Dec-2017 12:13:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decryption_OpeningFcn, ...
                   'gui_OutputFcn',  @Decryption_OutputFcn, ...
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



% --- Executes just before DecryptionList is made visible.
function Decryption_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DecryptionList (see VARARGIN)

% Choose default command line output for DecryptionList
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

x=(0:0.1:20)';
y_0=bessely(0,x);
y_1=bessely(1,x);
y_2=bessely(2,x);
axes(handles.Image);
plot(x,y_0,'',x,y_1,'',x,y_2,'');
axis([0,20,-1,1]);



% UIWAIT makes DecryptionList wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = Decryption_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global f3;
hwait=waitbar(0,'初始化');
f=im(:,:,1);
[m,n]=size(f);
waitbar(0.05,hwait,'识别比特串');
t=0;
length=m*n;
for i=1:m
    for j=1:n
        if f(i,j)>200
            f(i,j)=1;
        elseif f(i,j)<50
            f(i,j)=0;
        else
            errordlg('图像无法识别','错误');
            return;
        end
        t=t+1;
        waitbar(0.05+t*0.25/length,hwait);
    end
end
waitbar(0.3,hwait,'处理比特串');
f0=reshape(f',1,[]);
f0=strrep(num2str(f0),'  ','');
set(handles.Byte,'String',f0);
waitbar(0.35,hwait,'计算字符串');
length=m*n-mod(m*n,8);
f1=f0(1,1:length);
f1=char(bin2dec(num2str(reshape(f1',8,[])')))';
set(handles.Cipher,'String',f1);
waitbar(0.4,hwait,'进行Base64解密计算');
t=0;
switch get(handles.DecryptionList,'Value')
    case 1
        length=length/8;
        chart=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'];
        f2=zeros();
        for i=1:length
            for j=1:64
                flag=0;
                if f1(i)==chart(j)
                    f2(i)=j-1;
                    flag=1;
                    break;
                end
            end
            if flag~=1
                break;
            end
            t=t+1;
            waitbar(0.4+t*0.5/length,hwait);
        end
        waitbar(0.9,hwait);
        length=(i-1)*6;
        f2=reshape(dec2bin(f2)',1,[]);
        f3=f2(1,1:length-mod(length,8));
        f3=char(bin2dec(num2str(reshape(f3',8,[])')))';
        set(handles.Plain,'String',f3);
        waitbar(1,hwait,'解密完成');
        close(hwait);
    case 2
        errordlg('说了没有了还选','错误');
end



% --- Executes on selection change in DecryptionList.
function DecryptionList_Callback(hObject, eventdata, handles)
% hObject    handle to DecryptionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DecryptionList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DecryptionList



% --- Executes during object creation, after setting all properties.
function DecryptionList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DecryptionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in LoadImage.
function LoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathfile;
global im;
[fname,pname]=uigetfile({'*.png';'*.jpg';'*.bmp'},'选择图片');
if isequal(fname,0)
    warndlg('未选择图片','警告');
    return;
else
    pathfile=fullfile(pname,fname);
    im=imread(pathfile);
end
axes(handles.Image);
imshow(im);
set(handles.PathFile,'String',pathfile);



function PathFile_Callback(hObject, eventdata, handles)
% hObject    handle to PathFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathFile as text
%        str2double(get(hObject,'String')) returns contents of PathFile as a double
global pathfile;
global im;
pathfile=get(handles.PathFile,'String');
try
    im=imread(pathfile);
    axes(handles.Image);
    imshow(im);
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



function Byte_Callback(hObject, eventdata, handles)
% hObject    handle to Byte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Byte as text
%        str2double(get(hObject,'String')) returns contents of Byte as a double



% --- Executes during object creation, after setting all properties.
function Byte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Byte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Cipher_Callback(hObject, eventdata, handles)
% hObject    handle to Cipher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cipher as text
%        str2double(get(hObject,'String')) returns contents of Cipher as a double



% --- Executes during object creation, after setting all properties.
function Cipher_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cipher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Plain_Callback(hObject, eventdata, handles)
% hObject    handle to Plain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Plain as text
%        str2double(get(hObject,'String')) returns contents of Plain as a double



% --- Executes during object creation, after setting all properties.
function Plain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f3;
[fname,pname]=uiputfile('PlainText.txt','选择保存位置');
if isequal(fname,0)
    warndlg('未选择保存位置','警告');
    return;
end
pathfile=fullfile(pname,fname);
try
    f=fopen(pathfile,'w');
    fprintf(f,'%s',f3');
    fclose(f);
    helpdlg('保存成功','完成');
catch
    errordlg('保存失败','错误');
end