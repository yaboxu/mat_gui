function ma=hdb3(x);
%函数文件，文件名为hdb3，输入参数为x，输出参数为ma，实现HDB3码波形功能（第一个1为正1）
%用2表示书上的V，用3表示书上的B,HDB3码对应的波形是占空比为0.5的双极性归零码
a=length(x);b=-1; 
for n=1:a 
    if x(n)==1   
        b=-b; %每检测到一个1变一次符号
        x(n)=b; 
    end 
end  
%AMI=x; %变为AMI码：每过一个1就使原来的1变一次号 
%若前四个码元都是0，则将 0000 改为 B00V
if x(1)==0 
    if x(2)==0 
        if x(3)==0  
            if x(4)==0 %检测是否连续4个码元都是0
                x(1)=3;%用3表示书上的B
                x(4)=2; %用2表示书上的V
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
t0=300;
t=1/t0:1/t0:length(x);  % t的范围为从1/t0到x的长度，步长为1/t0
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
M=max(y);m=min(y);  %y的最大值为M，最小值为m
plot(t,y);grid on;  %画图，加网格
axis([0,i,m-0.1,M+0.1]);  %横坐标的范围（0，i），纵坐标的范围(m-0.1,M+0.1)
title('HDB3码');   %HDB3码