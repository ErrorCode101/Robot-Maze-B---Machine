/* Robot
 * Author: Musthaq Aadhil
 * Creation date: 12/17/2019
 */
MACHINE
    Robot
    
SEES
    Maze
    
SETS

    MESSAGES = {
        Yes,
        No,
        MoveSuccess, 
        CannotMoveDueToAnInternalWall, 
        CannotMoveDueToAExternalWall, 
        TeleportSuccess,
        CannotTeleportDueToAnInternalWall,
        CannotTeleportToOutsideOfTheMaze,
        CannotTeleportToTheExitOnStart
    }
    
VARIABLES
    currentXPosition,
    currentYPosition,
    robotPath

INVARIANT
    currentXPosition : xAxis &
    currentYPosition : yAxis &
    robotPath : seq(NATURAL1 * NATURAL1)
    
INITIALISATION
    currentXPosition := 1 || currentYPosition  := 1  ||
    robotPath := []
    
OPERATIONS
    
    //Get the current position on the maze
   currentPosition  <-- getPosition  =
   BEGIN 
       currentPosition := (currentXPosition|-> currentYPosition)
   END;
   
   //Check if the robot has reached the exit
   exitMessage  <-- foundExit  =
   IF
       ((currentXPosition |-> currentYPosition) : exit) 
   THEN
       exitMessage := Yes
   ELSE
       exitMessage := No
   END;
   
   //Get the visited square position on the maze

   visited  <-- visitedSquare(xPoint, yPoint)  =
   PRE    
       xPoint : xAxis &
       yPoint : yAxis & 
       (xPoint  |-> yPoint) /: internal_walls
   THEN
       IF
           (xPoint |-> yPoint) : ran(robotPath)
       THEN
           visited := Yes
       ELSE
           visited := No
       END
   END;
   
   //Get the robot's route through the maze
   route  <-- robotsRoute  =
   BEGIN 
       route := robotPath
   END;
    
    //Move North 
   message  <-- moveNorth  =
    IF
        ((currentXPosition|-> currentYPosition  + 1 ) /: internal_walls & 
        (currentYPosition + 1 : yAxis))
    THEN
        currentYPosition := currentYPosition + 1 ||
        robotPath := robotPath <- (currentXPosition |-> currentYPosition) ||
        message := MoveSuccess
    ELSIF (currentYPosition +1 /:  yAxis)
	      THEN 
	          message := CannotMoveDueToAExternalWall
	 ELSE 
	     message := CannotMoveDueToAnInternalWall
    END ;
    
    //Move East 

   message  <-- moveEast  =
    IF
        ((currentXPosition +1  |-> currentYPosition) /: internal_walls & 
        (currentXPosition + 1 : xAxis))
    THEN
        currentXPosition := currentXPosition + 1 ||
        robotPath := robotPath <- (currentXPosition  |-> currentYPosition) ||
        message := MoveSuccess
    ELSIF
        (currentXPosition + 1 /:  xAxis)
	      THEN 
	          message := CannotMoveDueToAExternalWall
	 ELSE 
	     message := CannotMoveDueToAnInternalWall
    END;
    
    //Move South 

   message  <-- moveSouth  =
    IF
        ((currentXPosition |-> currentYPosition -1) /: internal_walls & 
        (currentYPosition - 1 :  yAxis))
    THEN
        currentYPosition := currentYPosition - 1 ||
        robotPath := robotPath <- (currentXPosition |-> currentYPosition) ||
        message := MoveSuccess
    ELSIF
        (currentYPosition - 1 /:  yAxis)
	      THEN 
	          message := CannotMoveDueToAExternalWall
	 ELSE 
	     message := CannotMoveDueToAnInternalWall
    END;
    
    //Move West 

   message  <-- moveWest  =
    IF
        ((currentXPosition  - 1 |-> currentYPosition) /: internal_walls & 
        (currentXPosition - 1 : xAxis))
    THEN
        currentXPosition := currentXPosition - 1 ||
        robotPath := robotPath <- (currentXPosition |-> currentYPosition) ||
        message := MoveSuccess
    ELSIF
        (currentXPosition- 1 /: xAxis)
	      THEN 
	          message := CannotMoveDueToAExternalWall
	 ELSE 
	     message := CannotMoveDueToAnInternalWall
    END;
    
    //Teleport
   message  <-- teleport(xPoint, yPoint)  =
   PRE
       xPoint : INTEGER &
       yPoint : INTEGER
   THEN
       IF
           (xPoint |-> yPoint) /: internal_walls & card(robotPath) /= 0 &(xPoint |-> yPoint) /: exit  & xPoint : xAxis & yPoint: yAxis
       THEN
           currentXPosition := xPoint ||
           currentYPosition := yPoint ||
           message := TeleportSuccess ||
		     robotPath := robotPath <- (currentXPosition |-> currentYPosition)
       ELSE IF ((xPoint |-> yPoint) : internal_walls)
           THEN
               message := CannotTeleportDueToAnInternalWall
       ELSE IF (card(robotPath) = 0 &(xPoint |-> yPoint) : exit )
           THEN
               message := CannotTeleportToTheExitOnStart
       ELSE
               message := CannotTeleportToOutsideOfTheMaze
    
          END
          END
       END
   END
    
END
