public enum Direction{
 NORTH,SOUTH,WEST,EAST; 
}

class RightHandSolver{
  
  public Maze maze;
  public ArrayList<Coordinate> path;
  public boolean finished;
  public Direction direct;
  
  
 public RightHandSolver(Maze maze){
   this.direct = Direction.WEST;
   this.maze = maze;
   this.path = new ArrayList<Coordinate>();
   path.add(maze.getStart());
   finished = false;
 }
 
 public int getNumSteps(){
  return path.size(); 
 }
 
 public void makeStep(){
   Coordinate currentPoint = path.get(path.size() - 1);
   if(!maze.isFinish(currentPoint)){
     if(direct == Direction.WEST){
       if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y + 1))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y + 1);
         direct = Direction.SOUTH;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x + 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x + 1, currentPoint.y);
         direct = Direction.WEST;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y - 1))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y - 1);
         direct = Direction.NORTH;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x - 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x - 1, currentPoint.y);
         direct = Direction.EAST;
         path.add(currentPoint);
       }
       
     } else if(direct == Direction.NORTH){
       if(!maze.isWall(new Coordinate(currentPoint.x + 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x + 1, currentPoint.y);
         direct = Direction.WEST;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y - 1))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y - 1);
         direct = Direction.NORTH;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x - 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x - 1, currentPoint.y);
         direct = Direction.EAST;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y + 1))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y + 1);
         direct = Direction.SOUTH;
         path.add(currentPoint);
       }
       
     } else if(direct == Direction.EAST){
       if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y - 1))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y - 1);
         direct = Direction.NORTH;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x - 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x - 1, currentPoint.y);
         direct = Direction.EAST;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y + 1))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y + 1);
         direct = Direction.SOUTH;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x + 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x + 1, currentPoint.y);
         direct = Direction.WEST;
         path.add(currentPoint);
       }
       
     }else if(direct == Direction.SOUTH){
       if(!maze.isWall(new Coordinate(currentPoint.x - 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x - 1, currentPoint.y);
         direct = Direction.EAST;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y + 1 ))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y + 1 );
         direct = Direction.SOUTH;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x + 1, currentPoint.y))){
         currentPoint = new Coordinate(currentPoint.x + 1, currentPoint.y);
         direct = Direction.WEST;
         path.add(currentPoint);
       }else if(!maze.isWall(new Coordinate(currentPoint.x, currentPoint.y - 1))){
         currentPoint = new Coordinate(currentPoint.x, currentPoint.y - 1);
         direct = Direction.NORTH;
         path.add(currentPoint);
       }
       
     }
     
   }else{
     finished = true;
   }
   
}
}