function RedrawRedsHP()
global Boids;
global BoidsNum;
global MaxRedNum;
global RedsHP;
global BloodPos;
global SizeHPBar;

delete(RedsHP);
for i = 1 : BoidsNum           
    if (Boids(i,15)>0)       
        x1=Boids(i,1)-25;
        x2=Boids(i,1)-25 + Boids(i,15)/2;
        y1=Boids(i,2)+BloodPos;
        y2=Boids(i,2)+BloodPos;                  
        RedsHP(i)=plot([x1 x2],[y1 y2],'-','Color','r','LineWidth',SizeHPBar);%line([x1 x2],[y1 y2],'Color','red','LineStyle','-');       
    end
end
drawnow;