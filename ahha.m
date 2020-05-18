function [AMI,HDB3]=ahha(x);
%函数文件，文件名为ahha，输入参数为x，输出参数为AMI和HDB3，实现输出AMI和HDB3码型功能（第一个1为正1）
%用2表示书上的V，用3表示书上的B
a=length(x);b=-1; %a为x的长度，b表示码元1，b的极性表示1的极性 
for n=1:a 
    if x(n)==1   
        b=-b; %每检测到一个1变一次符号
        x(n)=b; 
    end 
end  
AMI=x; %变为AMI码：每过一个1就使原来的1变一次号 
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
HDB3=x;