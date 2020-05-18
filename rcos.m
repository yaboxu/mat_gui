function rcos(x)
alpha=0.75;   %设置滚降系数，取值范围[0,1]
ts=1e-2;     %升余弦滚降滤波器的参考码元周期，ts=10ms,无ISI（临界点）
fs=1e3;   %采样频率，单位：Hz，该数值过大会严重增加运行时间
rs=50;    %码元速率，单位：Baud
num=length(x);     %x是码元序列
samp_rate=fs/rs;   %采样率，应为大于1的正整数，即要求fs,rs之间呈整数倍关系
%对码元序列x进行抽样
k=1;
for ii=1:num
    for jj=1:samp_rate
        samp_data(k)=x(ii);
        k=k+1;
    end
end
%基带升余弦滚降系统冲激响应
[ht,a]=rcosine(1/ts,fs,'fir',alpha);
%将信号送入基带升余弦滚降系统，即做卷积操作
st=conv(samp_data,ht)/(fs*ts);
plot(st);
xlabel('时间');ylabel('信号幅度');
hold on;grid on;
title('经过升余弦滚降系统之后的码元');