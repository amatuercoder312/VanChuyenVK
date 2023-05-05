function SET_GLOBAL_VARIABLES()
global EnvironmentWidth ImageWidth SafeDistance AlignmentRange CohesionRange ...
    wanderAngle FleeDistance SpeedCorrection ...
    TargetsNum Targets D_BehindLeader  ObstaclesNum Obstacles ObstaclesNumB ObstaclesB ObstaclesNumR ObstaclesR ObstaclesF...  
     blueImg redImg heliImg HeliWidth battleShipImg battleShipWidth tankImg TankWidth...
    BlueMau RedMau...
     FlightsNum Fights FightsNum BoidsNum Boids ArmyBlues ArmyBluesNum...
    DameOfBlue DameOfRed...
    AccuracyB AccuracyR DieRNum DieBNum...
    ShootDistanceB ShootDistanceR SizeHPBar BloodPos RedsHP BluesHP  kB kR Target1 Target2 Boids1...
    Cars CarsNum;

global Booms BoomsNum ;  
global MetBlue;
MetBlue=0;
global MetRed;
MetRed=0;
%%
ShootDistanceB = 220; 
ShootDistanceR = 200;
BloodPos=25;
AccuracyB =0.9; % do chinh xac
AccuracyR =0.9;

DameOfBlue = 10;
DameOfRed= 10;

ImageWidth = 60;
%%
%%

EnvironmentWidth = 800;
ImageWidth = 60;
HeliWidth = EnvironmentWidth / 15;
TankWidth = EnvironmentWidth / 5;
battleShipWidth = EnvironmentWidth/8;
SafeDistance = EnvironmentWidth /40; % set separation range
AlignmentRange = EnvironmentWidth/10; % set alignment range
CohesionRange = EnvironmentWidth/8; % set cohesion range
wanderAngle = 10;
FleeDistance = 200;
SpeedCorrection = 200;
%Number of Boids
BoidsNum = 300;
%Number of Targets
TargetsNum = 1;
D_BehindLeader = 130;
Target2 = [100 100 0];
%% Boids data
%List of Boids
Boids = zeros(BoidsNum,15); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision avoidance)
%}
Boids(:,1:2) = EnvironmentWidth*(2*rand([BoidsNum,2])-1); % set random position
% Boids(:,1:2) = 100;
Boids(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Boids(:,10) =10;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Boids(:,11) = 0.2; % set maxforce
Boids(:,13) = 100; % set max see ahead
Boids(:,14) = 2; % set max avoid force
Boids(:,15) = 100; % set max blood

% quan dich
ArmyBluesNum = 100;
ArmyBlues = zeros(ArmyBluesNum,15); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision avoidance)
%}
%ArmyBlues(:,1:2) = EnvironmentWidth*(2*rand([ArmyBluesNum,2])-1); % set random position
ArmyBlues(:,1) =100 + (700-100).*rand(100,1);
ArmyBlues(:,2) =400 + (700-400).*rand(100,1);
% ArmyBlues(:,2) = 600;
ArmyBlues(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
ArmyBlues(:,10) = 3;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
ArmyBlues(:,11) = 0.2; % set maxforce
ArmyBlues(:,13) = 100; % set max see ahead
ArmyBlues(:,14) = 2; % set max avoid force
ArmyBlues(:,15) = 100; % set blood

index=1;
%%%%%
for i=1:4
    ArmyBlues(i,1)= 200 + i*100;
    ArmyBlues(i,2)=400  +i*100;
end
for i=4:7
    ArmyBlues(i,1)= 450 + i*50;
    ArmyBlues(i,2)=300  +i*50;
end
%%
%car
CarsNum = 100;
Cars = zeros(CarsNum,14); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision avoidance)
%}
% Cars(:,1:2) = EnvironmentWidth*(2*rand([CarsNum,2])-1); % set random position
Cars(:,1) =20;
Cars(:,2) =20;
% Cars(:,2) = 600;
Cars(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Cars(:,10) = 3;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Cars(:,11) = 0.2; % set maxforce
Cars(:,13) = 100; % set max see ahead
Cars(:,14) = 2; % set max avoid force


%% Set static Obstacle data
ObstaclesNum = 30;
Obstacles=zeros(ObstaclesNum,4);
ObstaclesNumB = 1;
ObstaclesB = [0 0 0 0];
ObstaclesNumR = 1;
ObstaclesR = [0 0 0 0];

Obstacles(1,1:2)=[600,600];
Obstacles(2,1:2)=[600,800];
Obstacles(3,1:2)=[800,600];
Obstacles(4,1:2)=[350,700];
Obstacles(5,1:2)=[400,700];
Obstacles(6,1:2)=[200,700];
Obstacles(7,1:2)=[700,500];
Obstacles(8,1:2)=[700,400];
Obstacles(9,1:2)=[100,650];
Obstacles(10,1:2)=[200,650];
Obstacles(11,1:2)=[300,650];
Obstacles(12,1:2)=[0,700];
Obstacles(13,1:2)=[50,650];
Obstacles(14,1:2)=[400,750];
Obstacles(15,1:2)=[400,800];
Obstacles(16,1:2)=[400,720];
Obstacles(17,1:2)=[400,740];
Obstacles(18,1:2)=[700,300];
Obstacles(19,1:2)=[400,400];
Obstacles(20,1:2)=[400,500];
Obstacles(21,1:2)=[700,300];
Obstacles(22,1:2)=[800,300];
Obstacles(23,1:2)=[750,350];
Obstacles(24,1:2)=[750,400];


%% List of Fights
Fights = zeros(2,15);
% BlueOBJ(:,1:2) = EnvironmentWidth/4*(2*rand([BlueNum,2])-1)+300; % set random position
Fights(1,1) = 300; Fights(1,2) = 300; 
Fights(2,1) = 600; Fights(2,2) = 550; 
Fights(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Fights(:,10) = 20;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Fights(:,11) = 0.2; % set maxforce
Fights(:,13) = 200; % set max see ahead
Fights(:,14) = 10; % set max avoid force
Fights(:,15) = 100;

ObstaclesF=zeros(FightsNum,4);



%% Targets data. The targets may be leaders, persuaders... that the flock of agents want to follow.
%List of targets
Targets = zeros(TargetsNum,14);
Targets(:,1:2) = rand([TargetsNum,2])-1; % set random position
Targets(:,4:5) = 2*(2*rand([TargetsNum,2])-1); % set random velocity
Targets(:,10) = 2; % set maxspeed
Targets(:,11) = 2; % set maxforce
Targets(:,13) = 20; % set max see ahead
Targets(:,14) = 2; % set max avoid force

%% Set static Obstacle data

%% Accuracy
AccuracyB =0.1; % do chinh xac
AccuracyR =0.1;
DieRNum =0 ; 
DieBNum =0;
SizeHPBar=1;
%% Variables
DameOfBlue = 100;
DameOfRed=100;

%% Boom
 BoomsNum= 4;
 Booms = zeros(BoomsNum,4);
 Booms( :,4) = 1;
 Booms(1,1)= 300; Booms(1,2)= 300;
 %Booms(2,1)= 350; Booms(2,2)= 200;
 %Booms(3,1)= 100; Booms(3,2)= 200;
 %Booms(4,1)= 100; Booms(4,2)= 100;

end
