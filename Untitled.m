t(1)=1.25;
for i=1:0.01:1000
t(i+1)=ceil(t(i)/2)+ceil(t(i)/3)*1.25+ceil(t(i)/5)*0.25;
b=t(i+1)-t(i);
if b==0;
c=t(i);
else
t(i+1)=t(i);
end
end
