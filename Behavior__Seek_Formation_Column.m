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
global MousePosition1
global Reds RedsNum MaxRedNum ;
% Number of boids on the top of U-formation
global NumberBoidsOnTop;
% Number of boids on the the branch of U-formation
global NumberBoidsOnBranch;
global SodilerWidth;
Wingspan = ImageWidth;
% Number of boids on the top of U-formation
NumberBoidsOnTop = 3;
% Number of boids on the the branch of U-formation
NumberBoidsOnBranch = 1;
% Angle at top of U-formation
Alpha_U_Formation = 9*pi/9;
AccuracyR = 0.95;
AccuracyB = 0.95;
%%
DieRNum=0;
% Distance behind leader in the Column-formation
D_Behind = 20;
Wingspan = ImageWidth;
Alpha_V_Formation = 4*pi/9;
D_Beside = Wingspan*(4 + pi)/8 + 30;
%%
%wander
global ArmyBlues;
global ArmyBluesNum;
global MetBlue MetRed;
global SaveBehindLeader;
global SaveLeaderLeft;
global SaveLeaderRight;

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
[bomb,gun,fight,bombFs,gunFs,fightFs,fail,failFS,win,winFS]=loadSound();
%%
[RedsHP]=InitializeHP(BoidsNum,100,Boids);
[BluesHP]=InitializeHP(ArmyBluesNum,100,ArmyBlues);
[BoomsPlot]=InitializeBoom(v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,Booms,BoomsNum);
%%
% MousePosition1 = [400 450 0 0 0];
% SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',5,'MarkerFaceColor','blue','Color','blue');
% saveText = text(MousePosition(1) + 30, MousePosition(2)+ 10, 'Goal');
titleStr = 'Kich ban van chuyen vu khi trang bi';
% titleStr = [titleStr newline '(Use mouse click to create a new goal)'];
title(titleStr);
set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);

% Remove the red dot
function deleteRedCircle(obj,event,SaveMousePosition)    
        delete(SaveMousePosition);

end
%% 
%Event Mouse click
    function cursorPosition = cursorClickCallback(o,e)
        if MetBlue==0
            MetBlue=1;
        else            
            MetBlue=0;
        end
    end


%% calculate agents' positions to move to each iteration
% setappdata(0, 'OldTarget', Targets(1, 1:3));
% timeTick = 1;
DameOfBlue = 20;
DameOfRed= 20;

%% INITIALIZE COLUMN-FORMATION FOR FLOCK
Boids(1,1:3) = [180 90 0];
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
stop_flag = false;
count=0;

while (timeTick < TimeSteps)
    %%
     %% set Target
    tempBlues = ArmyBlues;
    tempReds = Boids;
    tempCars = Cars;
   
    % T�nh to�n th?i gian ?� tr�i qua
    if stop_flag 
        elapsed_time = toc;

        % N?u th?i gian ?� tr�i qua ??t ??n 10 gi�y th� ??t stop_flag = true
        if elapsed_time > 10
            stop_flag = false;
            Cars(:,10) = 3;
            %Boids(:,10) = 0;
        else 
            Cars(:,10) = 0 ;
            %Boids(:,10) =3 ;
        end
    else
        Cars(:,10) = 3;
    end
        
    
    % T?m d?ng v�ng l?p trong m?t kho?ng th?i gian ng?n
    
    
    
    
      if MetRed==1
          ShootDistanceB=ShootDistanceR
        for BluesIndex = 1:ArmyBluesNum
            % steering
            ArmyBlues = updateAtBoundary(ArmyBlues,BluesIndex);

            CurrentBoid = ArmyBlues(BluesIndex, :);
            %         force1 = steer_wander(CurrentBoid) + steer_separation(CurrentBoid) + steer_collision_avoidance1(CurrentBoid);
            %force1 = steer_wander(CurrentBoid) + steer_separation(CurrentBoid) + steer_collision_avoidance1(CurrentBoid); 
            force1 = steer_arrival(CurrentBoid, Cars(1,1:5)) + steer_separation(CurrentBoid) + steer_collision_avoidance1(CurrentBoid);
            steer_collision_avoidance1(CurrentBoid);
            ArmyBlues(BluesIndex,:) = applyForce(CurrentBoid, force1);
        end
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
    MousePosition = [horzcat(Cars(1,1))+100 horzcat(Cars(1,2))+100 0 0 0];
    force = steer_arrival(Boids(1,:), MousePosition); %Move toward the mouse
    Boids(1,:) = applyForce(Boids(1,:), force);
    
    %% Moving Boids
    Leader = Boids(1, :);
    %[Boids, BoidIndex] = steer_Seek_Formation_Column(MousePosition, Boids, Leader, D_Behind);
    %MetBlue=1;
    if MetBlue==0
        [Boids, BoidIndex] = steer_Seek_Formation_Column(MousePosition, Boids, Leader, D_Behind);
    else       
        % Calculate the horizontal angle of the Leader
        Alpha_Horizontal = CalculationHorizontalAngle(Leader);
        RedrawBoid(Boids,BoidsNum,v_Image,v_Alpha,v_ImageRip,v_AlphaRip,BoidsPlot)
        %Find the RightBeside and LeftBeside positions of Leader
        [RightBesidePosition, LeftBesidePosition] = FindBesideLeader(Leader, ...
                                            Alpha_Horizontal, D_Behind, D_Beside);
        RedrawBoid(Boids,BoidsNum,v_Image,v_Alpha,v_ImageRip,v_AlphaRip,BoidsPlot);
        % Assign 2-nd Boid to the right of 1-st Boid
        pos1=(RightBesidePosition(1:3)-Boids(2, 1:3))/10+Boids(2, 1:3);
        Boids(2, 1:6) = RightBesidePosition;
        Boids(2,1:3)=pos1;
        Boids(2,:) = applyForce(Boids(2,:), 0);
        RightBesidePosition = Boids(2, :);
        RedrawBoid(Boids,BoidsNum,v_Image,v_Alpha,v_ImageRip,v_AlphaRip,BoidsPlot)
        % Assign 3-rd boid to the left of of 1-st Boid
        pos2=(LeftBesidePosition(1:3)-Boids(3, 1:3))/10+Boids(3, 1:3);
        Boids(3, 1:6) = LeftBesidePosition;
        Boids(3,1:3)=pos2;
        Boids(3,:) = applyForce(Boids(3,:), 0);
        
        LeftBesidePosition = Boids(3, :);
        RedrawBoid(Boids,BoidsNum,v_Image,v_Alpha,v_ImageRip,v_AlphaRip,BoidsPlot)
        BoidIndex = 4;
        %RedrawBoid(Boids,BoidsNum,v_Image,v_Alpha,v_ImageRip,v_AlphaRip,BoidsPlot);
        while BoidIndex <= BoidsNum
            D_Beside_tmp = D_Beside;
            D_Behind_tmp = D_Behind;
            if ((BoidIndex > NumberBoidsOnTop) && (BoidIndex <= NumberBoidsOnTop + 2*NumberBoidsOnBranch))
                D_Behind_tmp = D_Behind + 50;
                D_Beside_tmp = D_Beside_tmp -90;
            else
                if (BoidIndex >= NumberBoidsOnTop + 2*NumberBoidsOnBranch)
                    D_Beside_tmp = 0;
                    D_Behind_tmp = D_Behind + 50;
                end
            end

            %Find the RightBeside position of RightBesidePosition (2-nd Boid)
            [RightBesidePosition, ~] = FindBesideLeader(RightBesidePosition, ...
                                            Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
            Boids(BoidIndex, 1:6) = RightBesidePosition;
            RightBesidePosition = Boids(BoidIndex,:);
            Boids(BoidIndex,:) = applyForce(Boids(BoidIndex,:), 0);

            BoidIndex = BoidIndex + 1;
            [~, LeftBesidePosition] = FindBesideLeader(LeftBesidePosition, ...
                                            Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
            Boids(BoidIndex, 1:6) = LeftBesidePosition;
            LeftBesidePosition = Boids(BoidIndex,:);
            Boids(BoidIndex,:) = applyForce(Boids(BoidIndex,:), 0);

            BoidIndex = BoidIndex + 1;
        end
         
    end
    
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
                if (J>0 && dist(Boids(i,:),ArmyBlues(J,:))<ShootDistanceR)
                    %%

                    Boids(i, :) = tempReds(i, :);
                    Cars = tempCars;
                    %%
                    c1=line([Boids(i,1), ArmyBlues(J,1)],[Boids(i,2), ArmyBlues(J,2)],'Color','red','LineStyle','-.');
                    sound(gun,gunFs);
                    pause(0.02);
                    delete(c1);
                   
                       % AttackBlue(1,J)=AttackBlue(1,J)+ DameOfRed*rand(1,1);
                    if ( sqrt(deviationXR*deviationXR+deviationYR*deviationYR) < SodilerWidth) 
                         AttackBlue(1,J)=AttackBlue(1,J)+DameOfRed; 
                    end
                    MetBlue=1;
                  
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
                    
                       % AttackRed(1,J)=AttackRed(1,J)+DameOfBlue*rand(1,1);
                        if ( sqrt(deviationXB*deviationXB + deviationYB*deviationYB) < SodilerWidth)
                             AttackRed(1,J)=AttackRed(1,J)+DameOfBlue;
                        end
                        MetRed=1;
                   

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
              sound(bomb,bombFs);
              pause(0.3);              
              delete(BombsPlot);
              tic;
              stop_flag = true;
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
         pause(1);
        sound(fail,failFS);
        pause(5);
        break;
    else
        DieRNum =0;
    end
    
    
    %% Red Win
    if Cars(1,1) > (TargetCar(1,1)-50)
        InitializeFlag (v_ImageFR,v_AlphaFR);
         pause(1);
        sound(win,winFS);
        pause(5);
        break;
    end
    
end
end