function RedrawBlueHP()
global ArmyBlues;
global ArmyBluesNum;
% global MaxBlueNum;
global BluesHP;
global BloodPos;
global SizeHPBar;

delete(BluesHP);

for i = 1 : ArmyBluesNum
    if(ArmyBlues(i,15)>0)
        x1=ArmyBlues(i,1)-25;
        x2=ArmyBlues(i,1)-25+ArmyBlues(i,15)/2;
        y1=ArmyBlues(i,2)+BloodPos;
        y2=ArmyBlues(i,2)+BloodPos;                  
        BluesHP(i)=plot([x1 x2],[y1 y2],'-','Color','b','LineWidth',SizeHPBar);%line([x1 x2],[y1 y2],'Color','Blue','LineStyle','-');  
    end
end
drawnow;