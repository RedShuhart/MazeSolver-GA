import java.util.ArrayList;
import java.util.Random;


public class Population {
    public double mutationRate;
    public PathFinder[] individuals;
    public ArrayList<PathFinder> matingPool;
    public int generation;
    public Maze maze;

    public  Population(Maze maze, double mutationRate, int size){
        this.mutationRate = mutationRate;
        this.individuals = new PathFinder[size];
        this.maze = maze;
        generation = 0;
        matingPool = new ArrayList<PathFinder>();
        for(int i = 0; i < individuals.length; i++){
            individuals[i] = new PathFinder(maze, new DNA(maze.getBlanks()));
        }
    }

    public void live(){
        for (int i = 0; i < individuals.length; i++) {
            individuals[i].run();
        }
    }

    public boolean finishReached(){
        for (int i = 0; i < individuals.length; i++) {
            if(individuals[i].atFinish) return true;
        }
        return false;
    }

    public void calcFitness(){
        for (int i = 0; i < individuals.length; i++) {
            individuals[i].calcFitness();
        }
    }

    public double getMaxFitness(){
        double maxFitness = 0;
        for (int i = 0; i < individuals.length; i++) {
            if (individuals[i].fitness > maxFitness){
                maxFitness = individuals[i].fitness;
            }
        }
        return maxFitness;
    }
    
    public double getWorstFitness(){
        double worstFitness = Double.POSITIVE_INFINITY;
        for (int i = 0; i < individuals.length; i++) {
            if (individuals[i].fitness < worstFitness){
                worstFitness = individuals[i].fitness;
            }
        }
        return worstFitness;
    }
    
    public double getAvgFitness(){
        double avgFitness = 0;
        for (int i = 0; i < individuals.length; i++) {
            avgFitness += individuals[i].fitness;
        }
        return avgFitness / (double) individuals.length;
    }
    
    public double getDeviation()
    {
        double sum = 0.0;
        for (int i = 0; i < individuals.length; i++) {
            sum += individuals[i].fitness;
        }
        double mean =  sum/individuals.length;
        double temp = 0.0;
        for(int i = 0; i < individuals.length; i++){
            temp += (individuals[i].fitness-mean)*(individuals[i].fitness-mean);
        }
        double variance = temp/individuals.length;
        return Math.sqrt(variance);
    }
    
    public PathFinder getBestPath(){
      PathFinder bestPath = individuals[0];
        for (int i = 0; i < individuals.length; i++) {
            if (individuals[i].fitness > bestPath.fitness){
                bestPath = individuals[i];
            }
        }
        return bestPath;
    }

    public double mymap(double num, double initFrom, double initTo, double resFrom, double resTo) {
        return (num - initFrom) / (initTo - initFrom) * (resTo - resFrom) + resFrom;
    }
    

   void individNormalization(){
      double maxfitness = getMaxFitness();
      for (int i = 0; i < individuals.length; i++) {
            double newFitness = mymap(individuals[i].fitness, 0.0, maxfitness, 0.0, 10.0);
            individuals[i].fitness = newFitness;
      }
    }
   
   void selection() {
        matingPool.clear();
        double maxfitness = getMaxFitness();
        for (int i = 0; i < individuals.length; i++) {
            double fitness  = individuals[i].fitness;
            int n = (int) (fitness * 100);
            if(n == 0) n = 1;
            for (int j = 0; j < n; j++) {
                matingPool.add(individuals[i]);
            }
        }
    }
   
    
    public PathFinder tournamentSelect(int n){
      Random random = new Random();
      PathFinder candidate = new PathFinder(maze, new DNA(maze.getBlanks()));
      for(int i = 0; i < n; i++){
         int picker = random.nextInt(individuals.length);
         if(individuals[picker].fitness > candidate.fitness){
           candidate = individuals[picker];
         }
      }
      return candidate;
    }

    void reproduction() {
        for (int i = 0; i < individuals.length; i++) {
            int m = (int)random(matingPool.size());
            int d = (int)random(matingPool.size());
            PathFinder mom = matingPool.get(m);
            PathFinder dad = matingPool.get(d);
            //PathFinder mom = tournamentSelect(5);
            //PathFinder dad = tournamentSelect(5);
            DNA momgenes = mom.dna;
            DNA dadgenes = dad.dna;
            DNA child = momgenes.crossover(dadgenes);
            child.mutate(mutationRate);
            individuals[i] = new PathFinder(maze, child);
        }
        generation++;
    }
}