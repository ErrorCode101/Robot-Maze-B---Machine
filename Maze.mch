/* Maze
 * Author: Aadhil Musthaq
 * Creation date: 12/17/2019
 */
MACHINE
    Maze
    
CONSTANTS
    xAxis,
    yAxis,
    internal_walls,
    exit
    
PROPERTIES
    xAxis <: NATURAL1 &
    yAxis <: NATURAL1 &
    xAxis = 1..7 &
    yAxis = 1..5 &
    internal_walls : xAxis <-> yAxis &
    internal_walls = {(1 |-> 3), (2 |-> 1), (2 |-> 3), (2 |-> 5), (3 |-> 3), (4 |-> 2), (4 |-> 3), (4 |-> 4), (6 |-> 1), (6 |-> 2), (6 |-> 4), (7 |-> 4)} &
    exit : xAxis <-> yAxis &
    exit = {(1 |-> 5)}  
    
    

END
