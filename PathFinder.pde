import java.util.ArrayList;


public class PathFinder{

    public DNA dna;
    public Maze maze;
    public Step[] steps;
    public ArrayList<Coordinate> path;
    public boolean hitWall;
    public boolean atFinish;
    public double finalDistance;
    public double recordDistance;
    public int numOfCrossings;
    public int numOfSteps;
    public double fitness;
    public int distBefHitWall;
    public int niceSteps;



    public PathFinder(Maze maze, DNA dna){
        this.dna = dna;
        this.maze = maze;
        hitWall = false;
        atFinish = false;
        fitness = 0.0;
        steps = new Step[dna.genes.length() / 2];
        finalDistance = steps.length;
        recordDistance = steps.length;
        numOfCrossings = 0;
        distBefHitWall = 0;
        niceSteps = 0;
        String temp;
        path = new ArrayList<Coordinate>();
        for(int i = 0; i < dna.genes.length() ; i += 2){
            temp = dna.genes.substring(i,i+2);
            steps[i/2] = Step.fromString(temp);
        }
    }

    void calcFitness() {
        double dist = maze.getFinish().getDistance(maze.getStart());
        if (finalDistance == 0 || recordDistance == 0){
            finalDistance = 1;
            recordDistance = 1;
        }
        if (numOfCrossings == 0){
            numOfCrossings = 1;
        }
        if (distBefHitWall == 0){
            distBefHitWall = 1;
        }
        fitness = (((double) niceSteps + (double) distBefHitWall)/((double)recordDistance + (double)numOfCrossings + (double)finalDistance ));
        fitness = Math.exp(fitness);
        //fitness = Math.pow(fitness, 4);
        if (hitWall) fitness *= 0.1;
        if (atFinish) fitness *= 2;
    }

    public void run(){
        Coordinate curentPosition = maze.getStart();
        Coordinate newPosition = curentPosition;
        path.add(curentPosition);
        finalDistance = curentPosition.getDistance(maze.finishCoord);
        recordDistance = curentPosition.getDistance(maze.finishCoord);
        for(int i = 0; i < steps.length; i++){

            switch (steps[i]){
                case UP: newPosition = new Coordinate(curentPosition.x, curentPosition.y - 1);
                    break;
                case DOWN: newPosition = new Coordinate(curentPosition.x, curentPosition.y + 1);
                    break;
                case RIGHT: newPosition = new Coordinate(curentPosition.x + 1, curentPosition.y);
                    break;
                case LEFT: newPosition = new Coordinate(curentPosition.x - 1, curentPosition.y);
                    break;
            }

            if(maze.isWall(newPosition)){
                this.hitWall = true;
                break;
            } else if(maze.isFinish(newPosition)){
                curentPosition = newPosition;
                path.add(curentPosition);
                this.atFinish = true;
                distBefHitWall++;
                finalDistance = 0;
                recordDistance = 0;
                numOfSteps = path.size();
                break;
            } else {
                for (Coordinate coord : path) {
                    if(newPosition.x == coord.x && newPosition.y == coord.y) numOfCrossings++;
                    else niceSteps++; 
                }

                finalDistance = newPosition.getDistance(maze.finishCoord);
                if(finalDistance < recordDistance) recordDistance = finalDistance;
                curentPosition = newPosition;
                path.add(curentPosition);
                numOfSteps = path.size() - 1;
                distBefHitWall++;
            }
        }

    }
}