function rcos(x)
alpha=0.75;   %���ù���ϵ����ȡֵ��Χ[0,1]
ts=1e-2;     %�����ҹ����˲����Ĳο���Ԫ���ڣ�ts=10ms,��ISI���ٽ�㣩
fs=1e3;   %����Ƶ�ʣ���λ��Hz������ֵ�����������������ʱ��
rs=50;    %��Ԫ���ʣ���λ��Baud
num=length(x);     %x����Ԫ����
samp_rate=fs/rs;   %�����ʣ�ӦΪ����1������������Ҫ��fs,rs֮�����������ϵ
%����Ԫ����x���г���
k=1;
for ii=1:num
    for jj=1:samp_rate
        samp_data(k)=x(ii);
        k=k+1;
    end
end
%���������ҹ���ϵͳ�弤��Ӧ
[ht,a]=rcosine(1/ts,fs,'fir',alpha);
%���ź�������������ҹ���ϵͳ�������������
st=conv(samp_data,ht)/(fs*ts);
plot(st);
xlabel('ʱ��');ylabel('�źŷ���');
hold on;grid on;
title('���������ҹ���ϵͳ֮�����Ԫ');