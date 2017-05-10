function arc1=healthv5(a,b,N,H,LxH,LxN,n,P,L) %a,b分别是我们用healthv3计算所得的α和β ，N,H依然是健康和不健康的人数数据
                                         %LxH是健康生存人年数，LxN是不健康生存人年数
                                         %P是我们需要的之前的年龄段人数信息,如希望计算2015年的，那么就应该要增加60岁之前的
                                         %5个年龄段，也就是55~59的总人口信息，L是其对应的人年数
                                         %Length是我们希望计算的长度，由于α和β只能最多算到98岁，所以预测也最多到99岁
                                         %由此我们知道，能够计算的最长序列在65岁到99岁之间，一共35个年龄组，即Length(max)=35
      %如果已经执行过healthv8，即在工作区已经有计算出来的arc，那么可以用以下命令调用此函数得到结果
      %arc1=healthv5(arc(:,1),arc(:,2),N,H,LxH,LxN,35);
      
format long; %增加精度

arc1=zeros(40,2);  %用来存放最后预测的结果，第一列是健康的人数预测，第二行是不健康的人数预测
for i=1:1:40-n+2010
     if 40-n+2010 == 0
         break
     end
     people=[H(i);N(i)];  %以某一年龄组的人数做起始
    for j=1:1:(n-2010)  %每次循环迭代n-2010次
        coff=[a(i+j-1)  , 1-b(i+j-1);
              1-a(i+j-1), b(i+j-1)];  %是α和β组成的系数矩阵
        result=coff*people;     
        Lx=[LxH(i+j)/LxH(i+j-1);LxN(i+j)/LxN(i+j-1)];
        people=Lx.*result;  %迭代一次之后的人数情况
    end
    arc1(i+n-2010,1)=people(1);  %将结果存入
    arc1(i+n-2010,2)=people(2);
end

Length = length(L);
for i=1:1:n-2010
    
    The_rest_people=P(i)*(L(Length)/L(i));
    New_people =[The_rest_people*(H(1)/(N(1)+H(1)));The_rest_people*(N(1)/(N(1)+H(1)))];
    
    for k=1:1:i-1  %每次循环迭代n-2010次
        if i==1
            break
        end
        coff=[a(k)  , 1-b(k);
              1-a(k), b(k)];  %是α和β组成的系数矩阵
        result=coff*New_people;     
        Lm=[LxH(k+1)/LxH(k);LxN(k+1)/LxN(k)];
        New_people=Lm.*result;  %迭代一次之后的人数情况
    end
    arc1(i,1)=New_people(1);  %将结果存入
    arc1(i,2)=New_people(2);
end
end