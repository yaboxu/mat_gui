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
t=1/t0:1/t0:length(x);  % t的范围为从1/t0到x的长度，步长为1/t0
if a1==1   %AMI码
    b=-1;
    for i=1:length(x)     %for循环i为从1到x的长度
        if(x(i)==1)       %如果x的第i个元素是1
            b=-b;          %每检测到一个1变一次符号
            for j=1:t0/2    %另一个for循环j的范围为从1到t0/2  
                y(t0/2*(2*i-2)+j)=b; %区间（i-1,i-0.5）对应的y值为b
                y(t0/2*(2*i-1)+j)=0;   %区间（i-0.5,i）对应的y值为0
            end
        else        %否则,如果x的第i个元素为0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=0; %区间（i-1,i-0.5）对应的y值为0
                y(t0/2*(2*i-1)+j)=0; %区间（i-0.5,i）对应的y值为0
            end
        end
    end
    ma=y(t0/2:t0:length(x)*t0); %AMI码
elseif a2==1   %HDB3码
    a=length(x);b=-1; 
    for n=1:a 
        if x(n)==1   
            b=-b; %每检测到一个1变一次符号
            x(n)=b; 
        end 
    end  
    %AMI=x; %变为AMI码：每过一个1就使原来的1变一次号
    if x(1)==0 
        if x(2)==0 
            if x(3)==0  
                if x(4)==0 %检测是否连续4个码元都是0
                    x(1)=3;
                    x(4)=2; %用2表示书上的V，且V的极性与前一位非零码相同
                    for i=5:length(x)
                        if abs(x(i))==1
                            x(i)=-x(i);
                        end
                    end 
                end 
            end 
        end 
    end
    m=1;%码元V符号初始化，m的极性表示V的极性
    for k=1:a-3  
        if abs(x(k))==1 
            m=x(k); %m记录可能存在的连续4个0前面非零码元的符号
        end 
        if x(k)==0 
            if x(k+1)==0 
                if x(k+2)==0  
                    if x(k+3)==0 %检测是否连续4个码元都是0 
                        x(k+3)=2*m; %用2表示书上的V，且V的极性与前一位非零码相同 
                    end 
                end 
            end 
        end 
    end 
    c=1; %c=1表示两个V之间有偶数个非零码
    for i=1:a  
        if abs(x(i))==2 
            for j=i+1:a  
                if abs(x(j))==1 %遇到一个非零码就使c变一次号，表示两个V之间的非零码的个数为偶数或奇数
                    c=-c; 
                end  
                if abs(x(j))==2 
                    if c~=1  %如果两个V之间有奇数个非零码
                        c=1; %不需要插入B时若检测到V也应把计数器清零 
                    else %检测到下一个V时，若两个V之间有偶数个非零码，则插入B 
                        x(j-3)=3*(-(x(j-4))/(abs(x(j-4)))); %用3表示书上的B,且B的极性与前一位非零码相反 
                        x(j:a)=-x(j:a); %V以及之后的码元变号 
                    end      
                end 
            end 
        end 
    end
    ma=x;
    for i=1:length(x)  %for循环i为从1到x的长度
        if(abs(x(i))>=1)   %如果x的第i个元素的绝对值大于等于1
            for j=1:t0/2  %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=x(i)/abs(x(i));  %区间（i-1,i-0.5）对应的y值为正负1,极性与x(i)的极性相同
                y(t0/2*(2*i-1)+j)=0;  %区间（i-0.5,i）对应的y值为0
            end
        else        %否则,如果x的第i个元素为0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=0;  %区间（i-1,i-0.5）对应的y值为0
                y(t0/2*(2*i-1)+j)=0;  %区间（i-0.5,i）对应的y值为0
            end
        end
    end
elseif a3==1   %CMI码
    b=-1;
    for i=1:length(x)   %for循环i为从1到x的长度
        if(x(i)==1)      %如果x的第i个元素是1
            b=-b;         %变号
            if b==1       %如果b是1
                for j=1:t0/2    %另一个for循环j的范围为从1到t0/2
                    y(t0/2*(2*i-2)+j)=1; %区间（i-1,i-0.5）对应的y值为1
                    y(t0/2*(2*i-1)+j)=1;   %区间（i-0.5,i）对应的y值为1
                end
            else          %否则，如果b是-1
                for j=1:t0/2    %另一个for循环j的范围为从1到t0/2
                    y(t0/2*(2*i-2)+j)=0; %区间（i-1,i-0.5）对应的y值为0
                    y(t0/2*(2*i-1)+j)=0;   %区间（i-0.5,i）对应的y值为0
                end
            end
        else              %否则，如果x的第i个元素是0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=0; %区间（i-1,i-0.5）对应的y值为0
                y(t0/2*(2*i-1)+j)=1; %区间（i-0.5,i）对应的y值为1
            end
        end
    end
    ma=y(t0/4:t0/2:(length(x)-1/4)*t0); %CMI码
elseif a4==1   %双相码
    for i=1:length(x)     %for循环i为从1到x的长度
        if(x(i)==1)       %如果x的第i个元素是1
            for j=1:t0/2    %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=1; %区间（i-1,i-0.5）对应的y值为1
                y(t0/2*(2*i-1)+j)=0;   %区间（i-0.5,i）对应的y值为0
            end
        else        %否则,如果x的第i个元素为0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=0; %区间（i-1,i-0.5）对应的y值为0
                y(t0/2*(2*i-1)+j)=1; %区间（i-0.5,i）对应的y值为1
            end
        end
    end
    ma=y(t0/4:t0/2:(length(x)-1/4)*t0); %双相码
end
M=max(y);m=min(y);  % y的最大值为M，最小值为m
plot(handles.axes1,t,y);grid(handles.axes1,'on');  %画图，加网格
axis(handles.axes1,[0,i,m-0.1,M+0.1]);  %横坐标的范围（0，i），纵坐标的范围(m-0.1,M+0.1)
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
cla(handles.axes2,'reset')  %清空指定坐标轴图形
cla(handles.axes3,'reset')  %清空指定坐标轴图形
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
t=1/t0:1/t0:length(xx);  % t的范围为从1/t0到x的长度，步长为1/t0
if a5==1   %单极性不归零码
    for i=1:length(xx);  %for循环i为从1到x的长度
        if(xx(i)==1)   %如果x的第i个元素是1
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=1;  %区间（i-1,i-0.5）对应的y值为1
                y(t0/2*(2*i-1)+j)=1;  %区间（i-0.5,i）对应的y值为1
            end
        else        %否则,如果x的第i个元素为0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=0;  %区间（i-1,i-0.5）对应的y值为0
                y(t0/2*(2*i-1)+j)=0;  %区间（i-0.5,i）对应的y值为0
            end
        end
    end
    maa=y(t0/2:t0:length(xx)*t0); %单极性不归零码
elseif a6==1   %单极性归零码
    for i=1:length(xx)  %for循环i为从1到x的长度
        if(xx(i)==1)   %如果x的第i个元素是1
            for j=1:t0/2  %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=1;  %区间（i-1,i-0.5）对应的y值为1
                y(t0/2*(2*i-1)+j)=0;  %区间（i-0.5,i）对应的y值为0
            end
        else        %否则,如果x的第i个元素为0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=0;  %区间（i-1,i-0.5）对应的y值为0
                y(t0/2*(2*i-1)+j)=0;  %区间（i-0.5,i）对应的y值为0
            end
        end
    end
    maa=y(t0/4:t0/2:(length(xx)-1/4)*t0); %单极性归零码
elseif a7==1   %双极性不归零码
    for i=1:length(xx)  %for循环i为从1到x的长度
        if(xx(i)==1)   %如果x的第i个元素是1
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=1;  %区间（i-1,i-0.5）对应的y值为1
                y(t0/2*(2*i-1)+j)=1;  %区间（i-0.5,i）对应的y值为1
            end
        else        %否则,如果x的第i个元素为0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=-1;  %区间（i-1,i-0.5）对应的y值为-1
                y(t0/2*(2*i-1)+j)=-1;  %区间（i-0.5,i）对应的y值为-1
            end
        end
    end
    maa=y(t0/2:t0:length(xx)*t0); %双极性不归零码
elseif a8==1    %双极性归零码
    for i=1:length(xx)     %for循环i为从1到x的长度
        if(xx(i)==1)       %如果x的第i个元素是1
            for j=1:t0/2    %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=1; %区间（i-1,i-0.5）对应的y值为1
                y(t0/2*(2*i-1)+j)=0;   %区间（i-0.5,i）对应的y值为0
            end
        else        %否则,如果x的第i个元素为0
            for j=1:t0/2   %另一个for循环j的范围为从1到t0/2
                y(t0/2*(2*i-2)+j)=-1; %区间（i-1,i-0.5）对应的y值为-1
                y(t0/2*(2*i-1)+j)=0; %区间（i-0.5,i）对应的y值为0
            end
        end
    end
    maa=y(t0/4:t0/2:(length(xx)-1/4)*t0); %双极性归零码
end

M=max(y);m=min(y);  % y的最大值为M，最小值为m
plot(handles.axes2,t,y);grid(handles.axes2,'on');  %画图，加网格
axis(handles.axes2,[0,i,m-0.1,M+0.1]);  %横坐标的范围（0，i），纵坐标的范围(m-0.1,M+0.1)
title(handles.axes2,num2str(maa));
cla(handles.axes3,'reset')  %清空指定坐标轴图形


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
alpha=0.75;   %设置滚降系数，取值范围[0,1]
ts=1e-2;     %升余弦滚降滤波器的参考码元周期，ts=10ms,无ISI（临界点）
fs=1e3;   %采样频率，单位：Hz，该数值过大会严重增加运行时间
rs=50;    %码元速率，单位：Baud
num=length(maa);     %maa是码元序列
samp_rate=fs/rs;   %采样率，应为大于1的正整数，即要求fs,rs之间呈整数倍关系
%对码元序列maa进行抽样
k=1;
for ii=1:num
    for jj=1:samp_rate
        samp_data(k)=maa(ii);
        k=k+1;
    end
end
%基带升余弦滚降系统冲激响应
[ht,a]=rcosine(1/ts,fs,'fir',alpha);
%将信号送入基带升余弦滚降系统，即做卷积操作
st=conv(samp_data,ht)/(fs*ts);
M=max(st);m=min(st);  % st的最大值为M，最小值为m
plot(handles.axes3,st);grid(handles.axes3,'on');   %画图，加网格
if a1==1|a2==1
    title(handles.axes3,num2str(maaa));
else
    title(handles.axes3,num2str(maa));
end

