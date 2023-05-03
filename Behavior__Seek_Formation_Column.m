function Behavior__Seek_Formation_Column()
%% global variables
global TimeSteps;
global BoidsNum;
global Boids;
global Targets;
global SaveMousePosition;
global saveText;
global ImageWidth;
global ObstaclesB ObstaclesNumB Fights FightsNum MaxFightNum ObstaclesF ;
global ObstaclesR ObstaclesNumR;
global Obstacles ObstaclesNum;
global RedsHP BluesHP;
global DameOfBlue;
global DameOfRed;
global kB kR Target1 Target2;
global Booms BoomsNum BoomsPlot ;
%%
global DameOfBlue DameOfRed...
    AccuracyB AccuracyR DieRNum DieBNum...
    ShootDistanceB ShootDistanceR ;
global goToAttack;
goToAttack = 0;
global makeInformation;
makeInformation = zeros(1,BoidsNum);
global CarsNum Cars;

%%
DieRNum=0;
% Distance behind leader in the Column-formation
D_Behind = 20;
%%
%wander
global ArmyBlues;
global ArmyBluesNum;

%%

%% first draw
% [v_Image,v_Alpha,BoidsPlot,fHandler] = InitializeGraphics();

[fHandler]=InitializeGraphics();
InitializeBase();
[v_Image,v_Alpha,BoidsPlot] = InitializeArmyRed();
%%
[v_ImageB,v_AlphaB,BluesPlot]=InitializeArmyBlue();
[v_ImageC,v_AlphaC,CarsPlot]=InitializeCar();
[v_ImageRip,v_AlphaRip]=InitializeRip();
[v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6]=LoadImageOther1();
InitializeObstacles(v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6);
[v_ImageFR,v_AlphaFR,v_ImageFB,v_AlphaFB]=LoadImageFlag();
[v_ImageBoom,v_AlphaBoom,v_ImageN,v_AlphaN,v_ImageEmpty,v_AlphaEmpty]=LoadImageBoom();




%%load sound
[bomb,gun,fight,bombFs,gunFs,fightFs]=loadSound();
%%
[RedsHP]=InitializeHP(BoidsNum,100,Boids);
[BluesHP]=InitializeHP(ArmyBluesNum,100,ArmyBlues);
[BoomsPlot]=InitializeBoom(v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,Booms,BoomsNum);
%%
%Initialize the first positon of Goal
MousePosition = [730 650 0 0 0];
% MousePosition1 = [400 450 0 0 0];
% SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',5,'MarkerFaceColor','blue','Color','blue');
% saveText = text(MousePosition(1) + 30, MousePosition(2)+ 10, 'Goal');
titleStr = 'Kich ban van chuyen vu khi trang bi';
% titleStr = [titleStr newline '(Use mouse click to create a new goal)'];
title(titleStr);
set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);

%% calculate agents' positions to move to each iteration
% setappdata(0, 'OldTarget', Targets(1, 1:3));
% timeTick = 1;

%% INITIALIZE COLUMN-FORMATION FOR FLOCK
Boids(1,1:3) = [100 40 0];
Boids(1,:) = applyForce(Boids(1,:), 0);
Leader = Boids(1, :);
BehindPosition  = Leader;
BoidIndex = 2;
TargetCar = [700 700 0];
while BoidIndex <= BoidsNum
    %Find the RightBeside position of RightBesidePosition (2-nd Boid)
    BehindPosition = FindBehindLeader(BehindPosition,D_Behind);
    Boids(BoidIndex, 1:6) = BehindPosition;
    BehindPosition = Boids(BoidIndex,:);
    Boids(BoidIndex,:) = applyForce(Boids(BoidIndex,:), 0);
    
    BoidIndex = BoidIndex + 1;
end
RedrawGraphics(Boids,BoidsNum,v_Image,v_Alpha,BoidsPlot);
% sound(fight,fightFs);
%% FLOCK MOVE TO THE GOAL
% Generate random colors for drawing the footprints of boids
% for BoidIndex = 1:BoidsNum
%     randomColors(BoidIndex,1:3) = rand(1,3);
% end

timeTick = 1;

count=0;
while (timeTick < TimeSteps)
    %%
    %% set Target
    tempBlues = ArmyBlues;
    tempReds = Boids;
    tempCars = Cars;
    
    for BluesIndex = 1:ArmyBluesNum
        % steering
        ArmyBlues = updateAtBoundary(ArmyBlues,BluesIndex);
        
        CurrentBoid = ArmyBlues(BluesIndex, :);
        %         force1 = steer_wander(CurrentBoid) + steer_separation(CurrentBoid) + steer_collision_avoidance1(CurrentBoid);
        force1 = steer_wander(CurrentBoid) + steer_separation(CurrentBoid) + steer_collision_avoidance1(CurrentBoid);
        
        steer_collision_avoidance1(CurrentBoid)
        ArmyBlues(BluesIndex,:) = applyForce(CurrentBoid, force1);
    end
    %%
    %car run
    for CarIndex = 1: CarsNum
        Cars = updateAtBoundary(Cars,CarIndex);
        % steering
        CurrentBoidC = Cars(CarIndex, :);
        forcecar = steer_seek(CurrentBoidC, TargetCar);
        Cars(CarIndex,:) = applyForce(CurrentBoidC, forcecar);
        %         sound(tank,tankFs);
    end
    
    %%
    %% Moving the 1-st Boid (as a leader)
    %force = steer_arrival(Boids(1,:), MousePosition); %Move toward the mouse
    force = steer_arrival(Boids(1,:), MousePosition); %Move toward the mouse
    Boids(1,:) = applyForce(Boids(1,:), force);
    
    %% Moving Boids
    Leader = Boids(1, :);
    
    [Boids, BoidIndex] = steer_Seek_Formation_Column(MousePosition, Boids, Leader, D_Behind);
    %     Draw the footprint and lines of Column-formation every 20 steps
    %     if (mod(timeTick,40) == 0)
    %         for BoidIndex = 1:BoidsNum
    %             %Draw footprints of Boids
    %             plot(Boids(BoidIndex, 1), Boids(BoidIndex, 2), 'o', 'MarkerSize', ...
    %                 5,'MarkerFaceColor',randomColors(BoidIndex, 1:3),'Color',...
    %                 randomColors(BoidIndex, 1:3));
    %         end
    %         %Draw lines of Column-formation
    %         for BoidIndex = 1:BoidsNum-1
    %             line([Boids(BoidsIndex(BoidIndex),1), Boids(BoidsIndex(BoidIndex + 1),1)],...
    %                  [Boids(BoidsIndex(BoidIndex),2), Boids(BoidsIndex(BoidIndex + 1),2)],'Color','red','LineStyle','-')
    %         end
    %     end
    %%
        %% daviation Bule

        deviationXB = ShootDistanceB*(1-AccuracyB*(2*rand - 1));
        deviationYB = ShootDistanceB*(1-AccuracyB*(2*rand - 1));

        %% daviation Red
        deviationXR = ShootDistanceR*(1-AccuracyR*(2*rand - 1));
        deviationYR = ShootDistanceR*(1-AccuracyR*(2*rand - 1));
        %% Reds
        %     global ArmyBlues;
        % global ArmyArmyBluesNum;Boids, BoidsNum
        AttackBlue = zeros(1,ArmyBluesNum);

        for i=1:BoidsNum
            %         if (goToAttack == 0)


            if(Boids(i,15)>0)
                Boids = updateAtBoundary(Boids,i);
                CurrentBoid = Boids(i, :);

                %             Boids(i,:) = applyForce(CurrentBoid, force);
                [J,~]=findTarget(Boids(i,:),ArmyBluesNum,ArmyBlues);
                if (J>0 && dist(Boids(i,:),ArmyBlues(J,:))<ShootDistanceB)
                    %%

                    Boids(i, :) = tempReds(i, :);
                    Cars = tempCars;
                    %%
                    c1=line([Boids(i,1), ArmyBlues(J,1)],[Boids(i,2), ArmyBlues(J,2)],'Color','red','LineStyle','-.');
                    sound(gun,gunFs);
                    pause(0.02);
                    delete(c1);
                   
                        AttackBlue(1,J)=AttackBlue(1,J)+ DameOfRed;
                  
    %                 if ( 1==1)
    %                     AttackBlue(1,J)=AttackBlue(1,J)+ DameOfRed;
    %                 end
                end
            end
        end




        %% Blues
        AttackRed=zeros(1,BoidsNum);
        for i=1:ArmyBluesNum
            if(ArmyBlues(i,15)>0)
                ArmyBlues = updateAtBoundary(ArmyBlues,i);
                CurrentBoid = ArmyBlues(i,:);
                [J,tmpDist]=findTarget(ArmyBlues(i,:),BoidsNum,Boids);
                if (J>0 && dist(ArmyBlues(i,:),Boids(J,:))<ShootDistanceB)

                    ArmyBlues(i, :) = tempBlues(i, :);
                    %%
                    c2=line([Boids(J,1), ArmyBlues(i,1)-2],[Boids(J,2), ArmyBlues(i,2)],'Color','blue','LineStyle','-.');
                    pause(0.02);
                    sound(gun,gunFs);
                    delete(c2);
                    
                        AttackRed(1,J)=AttackRed(1,J)+DameOfBlue;
                   

                end
            end
        end
    %
     
    %% Boom

    for i=1:BoomsNum
        if(Booms(i,4)>0)
            [n]=findTargetBoom(Booms(i,:));
            if (n>0)
              for index = 1:n
                AttackRed(1,Targets(1,index))= AttackRed(1,Targets(1,index))+200;
              end
              Booms(i,4)=0;
              RedrawBoom(Booms,BoomsNum,v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,BoomsPlot);
              [BombsPlot]=InitializeBomb(v_ImageN,v_AlphaN,i);
              pause(10);
              delete(BombsPlot);
            end
            
        end
    end
    %% Update Blues
    disp(AttackRed);
    [ArmyBluesNum,ArmyBlues] = UpdateBoid(AttackBlue,ArmyBluesNum,ArmyBlues);
    %% Update Reds
    [BoidsNum,Boids] = UpdateBoid(AttackRed,BoidsNum,Boids);
    timeTick = timeTick+1;
    RedrawBoid(Boids,BoidsNum,v_Image,v_Alpha,v_ImageRip,v_AlphaRip,BoidsPlot)
    RedrawBoid(ArmyBlues,ArmyBluesNum,v_ImageB,v_AlphaB,v_ImageRip,v_AlphaRip,BluesPlot)
    RedrawGraphics(Cars,CarsNum,v_ImageC,v_AlphaC,CarsPlot);
    %% Boom
    RedrawBoom(Booms,BoomsNum,v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,BoomsPlot)
    % End of Moving Boids
    
    RedrawRedsHP();
    RedrawBlueHP();
    M(timeTick)=getframe; %For recording Video
    
   
    %% Blue Win
    for i = 1: BoidsNum
        if ( Boids(i,15)<= 0 )
            DieRNum = DieRNum +1;
        end
    end
    if ( DieRNum == BoidsNum)
        InitializeFlag (v_ImageFB,v_AlphaFB);
        break;
    else
        DieRNum =0;
    end
    
    
    %% Red Win
    if Cars(1,1) > (TargetCar(1,1)-50)
        InitializeFlag (v_ImageFR,v_AlphaFR);
        break;
    end
    
end
end