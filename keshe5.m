function varargout = keshe5(varargin)
% KESHE5 M-file for keshe5.fig
%      KESHE5, by itself, creates a new KESHE5 or raises the existing
%      singleton*.
%
%      H = KESHE5 returns the handle to a new KESHE5 or the handle to
%      the existing singleton*.
%
%      KESHE5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KESHE5.M with the given input arguments.
%
%      KESHE5('Property','Value',...) creates a new KESHE5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before keshe5_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to keshe5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help keshe5

% Last Modified by GUIDE v2.5 08-Jan-2016 10:50:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @keshe5_OpeningFcn, ...
                   'gui_OutputFcn',  @keshe5_OutputFcn, ...
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


% --- Executes just before keshe5 is made visible.
function keshe5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to keshe5 (see VARARGIN)

% Choose default command line output for keshe5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes keshe5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = keshe5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
edit1=str2num(get(hObject,'String'));
if(isempty(edit1))
    set(hObject,'String','')
end
guidata(hObject,handles); 

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ma
a1=get(handles.radiobutton1,'value');
a2=get(handles.radiobutton2,'value');
a3=get(handles.radiobutton3,'value');
a4=get(handles.radiobutton4,'value');
x=str2num(get(handles.edit1,'String'));
t0=300;
t=1/t0:1/t0:length(x);  % t�ķ�ΧΪ��1/t0��x�ĳ��ȣ�����Ϊ1/t0
if a1==1   %AMI��
    b=-1;
    for i=1:length(x)     %forѭ��iΪ��1��x�ĳ���
        if(x(i)==1)       %���x�ĵ�i��Ԫ����1
            b=-b;          %ÿ��⵽һ��1��һ�η���
            for j=1:t0/2    %��һ��forѭ��j�ķ�ΧΪ��1��t0/2  
                y(t0/2*(2*i-2)+j)=b; %���䣨i-1,i-0.5����Ӧ��yֵΪb
                y(t0/2*(2*i-1)+j)=0;   %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        else        %����,���x�ĵ�i��Ԫ��Ϊ0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=0; %���䣨i-1,i-0.5����Ӧ��yֵΪ0
                y(t0/2*(2*i-1)+j)=0; %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        end
    end
    ma=y(t0/2:t0:length(x)*t0); %AMI��
elseif a2==1   %HDB3��
    a=length(x);b=-1; 
    for n=1:a 
        if x(n)==1   
            b=-b; %ÿ��⵽һ��1��һ�η���
            x(n)=b; 
        end 
    end  
    %AMI=x; %��ΪAMI�룺ÿ��һ��1��ʹԭ����1��һ�κ�
    if x(1)==0 
        if x(2)==0 
            if x(3)==0  
                if x(4)==0 %����Ƿ�����4����Ԫ����0
                    x(1)=3;
                    x(4)=2; %��2��ʾ���ϵ�V����V�ļ�����ǰһλ��������ͬ
                    for i=5:length(x)
                        if abs(x(i))==1
                            x(i)=-x(i);
                        end
                    end 
                end 
            end 
        end 
    end
    m=1;%��ԪV���ų�ʼ����m�ļ��Ա�ʾV�ļ���
    for k=1:a-3  
        if abs(x(k))==1 
            m=x(k); %m��¼���ܴ��ڵ�����4��0ǰ�������Ԫ�ķ���
        end 
        if x(k)==0 
            if x(k+1)==0 
                if x(k+2)==0  
                    if x(k+3)==0 %����Ƿ�����4����Ԫ����0 
                        x(k+3)=2*m; %��2��ʾ���ϵ�V����V�ļ�����ǰһλ��������ͬ 
                    end 
                end 
            end 
        end 
    end 
    c=1; %c=1��ʾ����V֮����ż����������
    for i=1:a  
        if abs(x(i))==2 
            for j=i+1:a  
                if abs(x(j))==1 %����һ���������ʹc��һ�κţ���ʾ����V֮��ķ�����ĸ���Ϊż��������
                    c=-c; 
                end  
                if abs(x(j))==2 
                    if c~=1  %�������V֮����������������
                        c=1; %����Ҫ����Bʱ����⵽VҲӦ�Ѽ��������� 
                    else %��⵽��һ��Vʱ��������V֮����ż���������룬�����B 
                        x(j-3)=3*(-(x(j-4))/(abs(x(j-4)))); %��3��ʾ���ϵ�B,��B�ļ�����ǰһλ�������෴ 
                        x(j:a)=-x(j:a); %V�Լ�֮�����Ԫ��� 
                    end      
                end 
            end 
        end 
    end
    ma=x;
    for i=1:length(x)  %forѭ��iΪ��1��x�ĳ���
        if(abs(x(i))>=1)   %���x�ĵ�i��Ԫ�صľ���ֵ���ڵ���1
            for j=1:t0/2  %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=x(i)/abs(x(i));  %���䣨i-1,i-0.5����Ӧ��yֵΪ����1,������x(i)�ļ�����ͬ
                y(t0/2*(2*i-1)+j)=0;  %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        else        %����,���x�ĵ�i��Ԫ��Ϊ0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=0;  %���䣨i-1,i-0.5����Ӧ��yֵΪ0
                y(t0/2*(2*i-1)+j)=0;  %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        end
    end
elseif a3==1   %CMI��
    b=-1;
    for i=1:length(x)   %forѭ��iΪ��1��x�ĳ���
        if(x(i)==1)      %���x�ĵ�i��Ԫ����1
            b=-b;         %���
            if b==1       %���b��1
                for j=1:t0/2    %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                    y(t0/2*(2*i-2)+j)=1; %���䣨i-1,i-0.5����Ӧ��yֵΪ1
                    y(t0/2*(2*i-1)+j)=1;   %���䣨i-0.5,i����Ӧ��yֵΪ1
                end
            else          %�������b��-1
                for j=1:t0/2    %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                    y(t0/2*(2*i-2)+j)=0; %���䣨i-1,i-0.5����Ӧ��yֵΪ0
                    y(t0/2*(2*i-1)+j)=0;   %���䣨i-0.5,i����Ӧ��yֵΪ0
                end
            end
        else              %�������x�ĵ�i��Ԫ����0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=0; %���䣨i-1,i-0.5����Ӧ��yֵΪ0
                y(t0/2*(2*i-1)+j)=1; %���䣨i-0.5,i����Ӧ��yֵΪ1
            end
        end
    end
    ma=y(t0/4:t0/2:(length(x)-1/4)*t0); %CMI��
elseif a4==1   %˫����
    for i=1:length(x)     %forѭ��iΪ��1��x�ĳ���
        if(x(i)==1)       %���x�ĵ�i��Ԫ����1
            for j=1:t0/2    %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=1; %���䣨i-1,i-0.5����Ӧ��yֵΪ1
                y(t0/2*(2*i-1)+j)=0;   %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        else        %����,���x�ĵ�i��Ԫ��Ϊ0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=0; %���䣨i-1,i-0.5����Ӧ��yֵΪ0
                y(t0/2*(2*i-1)+j)=1; %���䣨i-0.5,i����Ӧ��yֵΪ1
            end
        end
    end
    ma=y(t0/4:t0/2:(length(x)-1/4)*t0); %˫����
end
M=max(y);m=min(y);  % y�����ֵΪM����СֵΪm
plot(handles.axes1,t,y);grid(handles.axes1,'on');  %��ͼ��������
axis(handles.axes1,[0,i,m-0.1,M+0.1]);  %������ķ�Χ��0��i����������ķ�Χ(m-0.1,M+0.1)
title(handles.axes1,num2str(ma));
if a1==1|a2==1
    set(handles.radiobutton5,'Enable','off');
    set(handles.radiobutton6,'Enable','off');
    set(handles.radiobutton7,'Enable','off');
    set(handles.radiobutton8,'Enable','off');
    set(handles.pushbutton2,'Enable','off');
else
    set(handles.radiobutton5,'Enable','on');
    set(handles.radiobutton6,'Enable','on');
    set(handles.radiobutton7,'Enable','on');
    set(handles.radiobutton8,'Enable','on');
    set(handles.pushbutton2,'Enable','on');
end
cla(handles.axes2,'reset')  %���ָ��������ͼ��
cla(handles.axes3,'reset')  %���ָ��������ͼ��
set(handles.radiobutton5,'value',0);
set(handles.radiobutton6,'value',0);
set(handles.radiobutton7,'value',0);
set(handles.radiobutton8,'value',0);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ma
global maa
xx=ma;
a5=get(handles.radiobutton5,'value');
a6=get(handles.radiobutton6,'value');
a7=get(handles.radiobutton7,'value');
a8=get(handles.radiobutton8,'value');
t0=300;
t=1/t0:1/t0:length(xx);  % t�ķ�ΧΪ��1/t0��x�ĳ��ȣ�����Ϊ1/t0
if a5==1   %�����Բ�������
    for i=1:length(xx);  %forѭ��iΪ��1��x�ĳ���
        if(xx(i)==1)   %���x�ĵ�i��Ԫ����1
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=1;  %���䣨i-1,i-0.5����Ӧ��yֵΪ1
                y(t0/2*(2*i-1)+j)=1;  %���䣨i-0.5,i����Ӧ��yֵΪ1
            end
        else        %����,���x�ĵ�i��Ԫ��Ϊ0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=0;  %���䣨i-1,i-0.5����Ӧ��yֵΪ0
                y(t0/2*(2*i-1)+j)=0;  %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        end
    end
    maa=y(t0/2:t0:length(xx)*t0); %�����Բ�������
elseif a6==1   %�����Թ�����
    for i=1:length(xx)  %forѭ��iΪ��1��x�ĳ���
        if(xx(i)==1)   %���x�ĵ�i��Ԫ����1
            for j=1:t0/2  %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=1;  %���䣨i-1,i-0.5����Ӧ��yֵΪ1
                y(t0/2*(2*i-1)+j)=0;  %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        else        %����,���x�ĵ�i��Ԫ��Ϊ0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=0;  %���䣨i-1,i-0.5����Ӧ��yֵΪ0
                y(t0/2*(2*i-1)+j)=0;  %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        end
    end
    maa=y(t0/4:t0/2:(length(xx)-1/4)*t0); %�����Թ�����
elseif a7==1   %˫���Բ�������
    for i=1:length(xx)  %forѭ��iΪ��1��x�ĳ���
        if(xx(i)==1)   %���x�ĵ�i��Ԫ����1
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=1;  %���䣨i-1,i-0.5����Ӧ��yֵΪ1
                y(t0/2*(2*i-1)+j)=1;  %���䣨i-0.5,i����Ӧ��yֵΪ1
            end
        else        %����,���x�ĵ�i��Ԫ��Ϊ0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=-1;  %���䣨i-1,i-0.5����Ӧ��yֵΪ-1
                y(t0/2*(2*i-1)+j)=-1;  %���䣨i-0.5,i����Ӧ��yֵΪ-1
            end
        end
    end
    maa=y(t0/2:t0:length(xx)*t0); %˫���Բ�������
elseif a8==1    %˫���Թ�����
    for i=1:length(xx)     %forѭ��iΪ��1��x�ĳ���
        if(xx(i)==1)       %���x�ĵ�i��Ԫ����1
            for j=1:t0/2    %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=1; %���䣨i-1,i-0.5����Ӧ��yֵΪ1
                y(t0/2*(2*i-1)+j)=0;   %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        else        %����,���x�ĵ�i��Ԫ��Ϊ0
            for j=1:t0/2   %��һ��forѭ��j�ķ�ΧΪ��1��t0/2
                y(t0/2*(2*i-2)+j)=-1; %���䣨i-1,i-0.5����Ӧ��yֵΪ-1
                y(t0/2*(2*i-1)+j)=0; %���䣨i-0.5,i����Ӧ��yֵΪ0
            end
        end
    end
    maa=y(t0/4:t0/2:(length(xx)-1/4)*t0); %˫���Թ�����
end

M=max(y);m=min(y);  % y�����ֵΪM����СֵΪm
plot(handles.axes2,t,y);grid(handles.axes2,'on');  %��ͼ��������
axis(handles.axes2,[0,i,m-0.1,M+0.1]);  %������ķ�Χ��0��i����������ķ�Χ(m-0.1,M+0.1)
title(handles.axes2,num2str(maa));
cla(handles.axes3,'reset')  %���ָ��������ͼ��


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ma
global maa
maaa=ma;
a1=get(handles.radiobutton1,'value');
a2=get(handles.radiobutton2,'value');
if a1==1|a2==1
    for i=1:length(ma)
        if abs(ma(i))>1
            ma(i)=ma(i)/abs(ma(i));
        end
    end
    maa=ma;
end
alpha=0.75;   %���ù���ϵ����ȡֵ��Χ[0,1]
ts=1e-2;     %�����ҹ����˲����Ĳο���Ԫ���ڣ�ts=10ms,��ISI���ٽ�㣩
fs=1e3;   %����Ƶ�ʣ���λ��Hz������ֵ�����������������ʱ��
rs=50;    %��Ԫ���ʣ���λ��Baud
num=length(maa);     %maa����Ԫ����
samp_rate=fs/rs;   %�����ʣ�ӦΪ����1������������Ҫ��fs,rs֮�����������ϵ
%����Ԫ����maa���г���
k=1;
for ii=1:num
    for jj=1:samp_rate
        samp_data(k)=maa(ii);
        k=k+1;
    end
end
%���������ҹ���ϵͳ�弤��Ӧ
[ht,a]=rcosine(1/ts,fs,'fir',alpha);
%���ź�������������ҹ���ϵͳ�������������
st=conv(samp_data,ht)/(fs*ts);
M=max(st);m=min(st);  % st�����ֵΪM����СֵΪm
plot(handles.axes3,st);grid(handles.axes3,'on');   %��ͼ��������
if a1==1|a2==1
    title(handles.axes3,num2str(maaa));
else
    title(handles.axes3,num2str(maa));
end

