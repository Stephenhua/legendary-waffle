function [Q R]=qrgivens(A)
[m,n]=size(A);
if(m>n)
fprintf('����һ�������Ⱦ���\n')
elseif(m==n)
fprintf('����һ���������\n')
else
fprintf('����һ�������Ⱦ��󣬲�����QR �ֽ�\n')
Q='null';R='null';
return
end
A_tempt=A;%�����󸳸�һ�������м��������ľ���
T_all=eye(m);%��ʼ��Givens ����
for index_j=1:n %��ÿһ�е��������б任
b=A_tempt(:,1);%ȡ��һ�е�������������
sub_T=eye(m-index_j+1,m-index_j+1);%��ʼ��ÿ�ν���ֵʱ��ÿ��Givens �仯
T=eye(m-index_j+1,m-index_j+1);%��ʼ����ǰ�н������ʱ���ܵ�Givens ����
for sub_i=2:m-index_j+1%��ÿһ�е����ݴӵڶ������ݿ�ʼ�������һ�����ݽ��б仯

xi=b(1);%��ȡ��һ������
xj=b(sub_i);%���λ�ȡ��ǰ��֮�������
r=sqrt(xi^2+xj^2);
cost=xi/r;%��þ�����c
sint=xj/r;%��þ�����s
%%%%%%%%%%%%�������ǰ�������������ǵ�Givens ����%%%%%%%%%%%
sub_T(1,1)=cost;
sub_T(1,sub_i)=sint;
sub_T(sub_i,1)=-sint;
sub_T(sub_i,sub_i)=cost;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=sub_T*T;%��ÿ���������ݽ������Gives �仯����������ֱ����ǰ����������
%�������
b(1)=sqrt(b(1)^2+b(sub_i)^2);%1 ��ý�������֮��ĵ�һ�����ݵ�ֵ
b(sub_i)=0;%������������λ��0
sub_T=eye(m-index_j+1,m-index_j+1);%������һ���������һ�����ݵĽ�
%��ʱ���³�ʼ��ÿ�ν���ʱ��Givens ����
end
T_all=blkdiag(eye(index_j-1),T)*T_all;%��ÿһ�е����ݱ�Ϊ�뵥λ����ƽ��
%���ÿ�е�Givens ���������
A_after_givens=T_all*A;%��þ���Givens �仯��ľ���
A_tempt=A_after_givens(index_j+1:m,index_j+1:n);%ȡ�����µ�����ʽ
end
Q=T_all';
R=T_all*A;