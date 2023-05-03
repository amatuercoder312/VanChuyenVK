function [mostThreatenObstacle, mostCloset, mostDistV] = findMostThreateningObstacle()
    mostThreatenObstacle = [0 0 0];
    mostCloset = [0 0 0];
    mostDistV = [0 0 0];
 
    for i = 1:ObstaclesNum
        obstacle = Obstacles(i,:); % obstacles row ith
        [fake_closest, closest] = closest_point_on_seg(v_pos, ahead_v, obstacle(1:3)); 
        dist_v = fake_closest - obstacle(1:3);
        collision = LineIntersectsCircle(dist_v, obstacle);
           
        if (collision == 1 && (~any(mostThreatenObstacle) || dist(v_pos, obstacle(1:3)) < dist(v_pos, mostThreatenObstacle(1:3))) )
            mostThreatenObstacle = obstacle;
            mostCloset = closest;
            mostDistV = dist_v;
        end
    end
  end