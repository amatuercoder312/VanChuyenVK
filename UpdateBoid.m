function [BoidsNum,Boids]=UpdateBoid(Attack,BoidsNum,Boids)
Point=zeros(1,BoidsNum);
for i=1:BoidsNum
    if(Boids(i,15)>0)    
        Boids(i,15)=Boids(i,15)-Attack(1,i); 
        Attack(1,1)
    end
end
