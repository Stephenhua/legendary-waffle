function [Q R]=qrgivens(A)
[m,n]=size(A);
if(m>n)
fprintf('这是一个列满秩矩阵\n')
elseif(m==n)
fprintf('这是一个方阵矩阵\n')
else
fprintf('这是一个行满秩矩阵，不能用QR 分解\n')
Q='null';R='null';
return
end
A_tempt=A;%将矩阵赋给一个用于中间过程运算的矩阵
T_all=eye(m);%初始化Givens 矩阵
for index_j=1:n %对每一列的向量进行变换
b=A_tempt(:,1);%取第一列的向量进行运算
sub_T=eye(m-index_j+1,m-index_j+1);%初始化每次交换值时的每个Givens 变化
T=eye(m-index_j+1,m-index_j+1);%初始化当前列交换完成时候总的Givens 矩阵
for sub_i=2:m-index_j+1%将每一列的数据从第二个数据开始依次与第一个数据进行变化

xi=b(1);%获取第一个数据
xj=b(sub_i);%依次获取当前列之后的数据
r=sqrt(xi^2+xj^2);
cost=xi/r;%求得矩阵常数c
sint=xj/r;%求得矩阵常数s
%%%%%%%%%%%%构造出当前交换两个数据是的Givens 矩阵%%%%%%%%%%%
sub_T(1,1)=cost;
sub_T(1,sub_i)=sint;
sub_T(sub_i,1)=-sint;
sub_T(sub_i,sub_i)=cost;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=sub_T*T;%将每次两个数据交换后的Gives 变化给乘起来，直到当前列所有数据
%交换完成
b(1)=sqrt(b(1)^2+b(sub_i)^2);%1 求得交换数据之后的第一个数据的值
b(sub_i)=0;%将交换的数据位置0
sub_T=eye(m-index_j+1,m-index_j+1);%进行下一个数据与第一个数据的交
%换时重新初始化每次交换时的Givens 矩阵
end
T_all=blkdiag(eye(index_j-1),T)*T_all;%将每一列的数据变为与单位向量平行
%后的每列的Givens 矩阵乘起来
A_after_givens=T_all*A;%求得经过Givens 变化后的矩阵
A_tempt=A_after_givens(index_j+1:m,index_j+1:n);%取得余下的余子式
end
Q=T_all';
R=T_all*A;