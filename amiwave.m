function ma=amiwave(x);
%函数文件，文件名为amiwave，输入参数为x，输出参数为ma，实现输出AMI码波形功能（第一个1为正1）
%AMI码对应的波形是占空比为0.5的双极性归零码
b=-1;t0=300;
t=1/t0:1/t0:length(x);  % t的范围为从1/t0到x的长度，步长为1/t0
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
M=max(y);m=min(y);  %y的最大值为M，最小值为m
plot(t,y);grid on;  %画图，加网格
axis([0,i,m-0.1,M+0.1]);  %横坐标的范围（0，i），纵坐标的范围(m-0.1,M+0.1)
title('AMI码');
ma=y(t0/2:t0:length(x)*t0); %AMI码