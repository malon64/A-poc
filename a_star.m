
function final = a_star(map, start, goal)
%map is a matrix describing the environment with  a free place and  an
%obstacle
%start is an array with the coordinates of the starting point ex:[21,15]
%goal is the ending point 
mapSize = size(map);

% default return - 'failure' for failure case
final = [];

% Initialize the open set, with START
 openSet = false(mapSize);
 openSet(start(1), start(2)) = true;

% Initialize closed set. Closed set consists of visited locations on 
%  the map
closedSet = false(mapSize);
cameFrom = zeros(mapSize);

% Initialize gScore, equivalent of the cost for each cell
gScore = inf(mapSize);
gScore(start(1), start(2)) = 0;

% Initialize fScore, equivalent of the heuristic for each cell
fScore = inf(mapSize);
fScore(start(1), start(2)) = compute_cost(start, goal);
 
S2 = sqrt(2);
current = nan(2, 1);

% While the open set is not empty
    while any(openSet(:) > 0)
        % Find the minimum fScore within the open set
        minValue = inf;
        for x = 1:100
            for y = 1:100
                if fScore(x,y) < minValue && openSet(x, y) == true && map(x,y) == 0
                    current(1) = x;
                    current(2) = y;
                    minValue = fScore(x,y);
                end
            end
        end
        % If we've reached the goal
        if current(1) == goal(1) && current(2) == goal(2)
            % Get the full path and return it
            final = get_path(cameFrom, current);
            return
        end
        
        %Remove the node from the openSet and add it to the closedSet
        openSet(current(1), current(2)) = false;
        closedSet(current(1), current(2)) = true;

        neighbors = [
            current(1) + 1, current(2) + 1, S2 ;
            current(1) + 1, current(2) + 0, 1 ; 
            current(1) + 1, current(2) - 1, S2 ; 
            current(1) + 0, current(2) - 1, 1 ; 
            current(1) - 1, current(2) - 1, S2 ; 
            current(1) - 1, current(2) - 0, 1 ; 
            current(1) - 1, current(2) + 1, S2 ; 
            current(1) - 0, current(2) + 1, 1 ; 
        ];
        
        %for each neighbors
        for index = 1:size(neighbors)
            neighbor = [neighbors(index,1), neighbors(index,2)];
            tentative_gScore = gScore(current(1), current(2)) + compute_cost(current, neighbor);
            %the neighbor must be a valid coordinate, not an obstacle and
            %not already visited
            if 0 < neighbor(1) && neighbor(1) <= mapSize(1) && 0 < neighbor(2) && neighbor(2) <= mapSize(2) && map(neighbor(1), neighbor(2)) == 0 && closedSet(neighbor(1), neighbor(2)) == false
                %We add it to the openSet
                openSet(neighbor(1), neighbor(2)) = true;
                %We update gScore and fScore if needed
                if tentative_gScore < gScore(neighbor(1), neighbor(2))
                    %cameFrom take an indice combining the x,y corrdinates
                    %cameFrom(neighbor) = current is equivalent to this
                    cameFrom(neighbor(1), neighbor(2)) = (current(1))*1000 + current(2);
                    gScore(neighbor(1), neighbor(2)) = tentative_gScore;
                    fScore(neighbor(1), neighbor(2)) = tentative_gScore + compute_cost(neighbor, goal);
                end
            end
        end
    end % while
    %If the goal is never reached
    final = 'failure';
end


function p = get_path(cameFrom, current)
    % Returns the path. This function is only called once and therefore
    %   does not need to be extraordinarily efficient
    inds = find(cameFrom);
    p = NaN(length(inds),2);
    p(1,1) = current(1);
    p(1,2) = current(2);
    next = 1;
    while cameFrom(current(1),current(2)) ~= 0
        ind = cameFrom(current(1),current(2));
        current(1) = floor(fix(ind/1000));
        %The fact that matlab index start with 1 force me to do that
        %correction
        if (current(1) == 0)
            current(1) = 100;
        end
        current(2) = mod(ind,1000);
        if (current(2) == 0)
            current(2) = 100;
        end
        next = next + 1;
        p(next,1) = current(1);
        p(next,2) = current(2);
    end
    endValue = length(p);
    for i=1:length(p)
        if isnan(p(i))
            endValue = i - 1;
            break
        end
    end
    p = p(1:endValue,1:2);
end

function cost = compute_cost(from, to)
    % Returns COST, an estimated cost to travel the map, starting FROM and
    %   ending at TO.
    cost = sqrt((to(1) - from(1))^2 + (to(2) - from(2))^2);
end