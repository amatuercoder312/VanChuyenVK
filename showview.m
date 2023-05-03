function showview ()

%% %% Global variables
global TimeSteps;
TimeSteps = 50000;
global BoidsNum;
global FlightsNum;
global ArmyBlues;
global ArmyBluesNum;
global Boids;
global Cars;
global CarsNum FightsNum ;
FlightsNum = 2;
CarsNum = 1;
FightsNum =2;
% Set global variables
SET_GLOBAL_VARIABLES()

%% -------------------BEGIN IMPLEMENTATION--------------------------------
    
%     Behavior_Start();

% [v_ImageF,v_AlphaF,FlightsPlot]=InitializeFlight();
        BoidsNum = 5; % Choose number of Boids to demo
        Boids(1,10) = 6; % set max speed of 1-st Boid
        Boids(2:BoidsNum, 10) = 3;
        CarsNum = 1; % Choose number of Boids to demo
        Cars(1,10) = 3; % set max speed of 1-st Boid
        ArmyBluesNum = 6;
        Behavior__Seek_Formation_Column();
   
% Behaviour__Arrival ();


% [v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6, ObstaclesPlot] = InitializeStone()
% [v_Image,v_Alpha, t_Image, t_Alpha, BoidsPlot] = InitializeObject();
end



%---------------------- END IMPLEMENTATION------------------------------
