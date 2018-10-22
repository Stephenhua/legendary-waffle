clear ;clc;
n=6;
m=[0 50 inf 40 25 10;
    0 0 15 20 inf 25;
    0 0 0 10 20 inf;
    0 0 0 10 20 inf;
    0 0 0 0 10 25;
    0 0 0 0 0 0 ];
m=m+m';
pb(1:length(m))=0;
pb(1)=1;
d(1:length(m))=0;
path(1:length(m))=0;
while sum(pb)<6
        tb=find(pb==0);
        fb=find(pb==1);
        min=1000000;
        lastpoint=1;
        newpoint=1;
        for i=1:length(fb)
            for j=1:length(tb)
                plus = d(fb(i))+m(fb(i),tb(j));
                if min>plus
                    min=plus;
                    lastpoint = fb(i);
                    newpoint=tb(j);
                end
            end
        end
        d(newpoint)= min;
        pb(newpoint)=1;
        path(newpoint)=lastpoint;
end
d,path

