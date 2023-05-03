function checkIntersect = lineIntersectsCircle(ahead, ahead2, CurrentObstacle) 
  % obstacle
  % 1-3: center
  % 4: radius
  if ( dist(CurrentObstacle(1:3), ahead)  + 180 <= CurrentObstacle(4) || dist(CurrentObstacle(1:3), ahead2) <= CurrentObstacle(4) )
    checkIntersect = 1;
  else 
    checkIntersect = 0;
  end
end