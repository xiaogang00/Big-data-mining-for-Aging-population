function arc1=healthv5(a,b,N,H,LxH,LxN,n,P,L) %a,b�ֱ���������healthv3�������õĦ��ͦ� ��N,H��Ȼ�ǽ����Ͳ���������������
                                         %LxH�ǽ���������������LxN�ǲ���������������
                                         %P��������Ҫ��֮ǰ�������������Ϣ,��ϣ������2015��ģ���ô��Ӧ��Ҫ����60��֮ǰ��
                                         %5������Σ�Ҳ����55~59�����˿���Ϣ��L�����Ӧ��������
                                         %Length������ϣ������ĳ��ȣ����ڦ��ͦ�ֻ������㵽98�꣬����Ԥ��Ҳ��ൽ99��
                                         %�ɴ�����֪�����ܹ�������������65�굽99��֮�䣬һ��35�������飬��Length(max)=35
      %����Ѿ�ִ�й�healthv8�����ڹ������Ѿ��м��������arc����ô����������������ô˺����õ����
      %arc1=healthv5(arc(:,1),arc(:,2),N,H,LxH,LxN,35);
      
format long; %���Ӿ���

arc1=zeros(40,2);  %����������Ԥ��Ľ������һ���ǽ���������Ԥ�⣬�ڶ����ǲ�����������Ԥ��
for i=1:1:40-n+2010
     if 40-n+2010 == 0
         break
     end
     people=[H(i);N(i)];  %��ĳһ���������������ʼ
    for j=1:1:(n-2010)  %ÿ��ѭ������n-2010��
        coff=[a(i+j-1)  , 1-b(i+j-1);
              1-a(i+j-1), b(i+j-1)];  %�Ǧ��ͦ���ɵ�ϵ������
        result=coff*people;     
        Lx=[LxH(i+j)/LxH(i+j-1);LxN(i+j)/LxN(i+j-1)];
        people=Lx.*result;  %����һ��֮����������
    end
    arc1(i+n-2010,1)=people(1);  %���������
    arc1(i+n-2010,2)=people(2);
end

Length = length(L);
for i=1:1:n-2010
    
    The_rest_people=P(i)*(L(Length)/L(i));
    New_people =[The_rest_people*(H(1)/(N(1)+H(1)));The_rest_people*(N(1)/(N(1)+H(1)))];
    
    for k=1:1:i-1  %ÿ��ѭ������n-2010��
        if i==1
            break
        end
        coff=[a(k)  , 1-b(k);
              1-a(k), b(k)];  %�Ǧ��ͦ���ɵ�ϵ������
        result=coff*New_people;     
        Lm=[LxH(k+1)/LxH(k);LxN(k+1)/LxN(k)];
        New_people=Lm.*result;  %����һ��֮����������
    end
    arc1(i,1)=New_people(1);  %���������
    arc1(i,2)=New_people(2);
end
end