function steer = steer_collision_avoidance1(Boid)

global Obstacles;
global ObstaclesNum;

v_pos = Boid(1:3);
v_vel = Boid(4:6);
v_maxspeed = Boid(10);
v_maxforce = Boid(11);
v_max_see_ahead = Boid(13);
v_max_avoid_force = 200; %Boid(14);

    % find the most threaten obstacle
    function mostThreatenObstacle = findMostThreateningObstacle()
        mostThreatenObstacle = [0 0 0];        
        for i = 1:ObstaclesNum
            CurrentObstacle = Obstacles(i,:);          
            collision = lineIntersectsCircle(ahead, ahead2, CurrentObstacle);
            if (collision == 1 && (~any(mostThreatenObstacle) || dist(v_pos, CurrentObstacle(1:3)) < dist(v_pos, mostThreatenObstacle(1:3))))
                mostThreatenObstacle = CurrentObstacle;
            end
        end
    end

ahead = v_pos + normalize(v_vel) * v_max_see_ahead;
ahead2 = v_pos + normalize(v_vel) * v_max_see_ahead * 0.5;

mostThreatening = findMostThreateningObstacle();
avoidance = [0 0 0];

%if (mostThreatening != null)
if (any(mostThreatening))  % if mostThreatening not 0-matrix
    avoidance(1) = ahead(1) - mostThreatening(1);
    avoidance(2) = ahead(2) - mostThreatening(2);  
    avoidance = setMag(avoidance, v_max_avoid_force);   
else
    avoidance = setMag(avoidance, 0);
end
steer = avoidance;

end