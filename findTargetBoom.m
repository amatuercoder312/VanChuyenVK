function [n]=findTargetBoom(Booms)
tmpDist=50;
index=1;
global Targets;
global Reds;
global RedsNum  Cars CarsNum;
for i=1:CarsNum
    if (dist(Booms,Cars(i,1:4))<10 ) 
        Targets(index)=i;
        index=index+1;
    end
end
if(index >1) 
    n=index-1;
else
    n=0;
end
