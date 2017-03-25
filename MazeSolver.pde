import controlP5.*;

ControlP5 cp5;

  Maze maze;
  float mutationRate;
  boolean mazeLoaded = false;
  boolean solveRightHand;
  RightHandSolver righthand;
  int populationSize;
  int frameSize = 900;
  int rHeight = 0;
  int rWidth = 0;
  int blockSize;
  Population population;
  PathFinder pathToDraw;
  ArrayList<Coordinate> rightHandPath;
  boolean start = false;
  int logCount = 1;


void loadMaze(String mazeName){
    start = false;
    background(25);
    rHeight = 0;
    maze = new Maze(dataPath(mazeName)); 
    blockSize = (frameSize/2) / maze.labyrinthHeight;
    population = new Population(maze,mutationRate, populationSize);
    drawMaze(maze);
    solveRightHand = false;
    mazeLoaded = true;
}

void Stop(){
  start = false;
}

void SolveRightHand(){
  print("true");
  start = false;
  if(!mazeLoaded){
      maze = new Maze(dataPath("maze8.txt")); 
      blockSize = (frameSize/2) / maze.labyrinthHeight;
      mazeLoaded = true;
  }
  righthand = new RightHandSolver(maze);
  solveRightHand = true;
  
}

void Start(){
  background(25);
  rHeight = 0;
  if(!mazeLoaded){
      maze = new Maze(dataPath("maze8.txt")); 
      blockSize = (frameSize/2) / maze.labyrinthHeight;
      mazeLoaded = true;
  }
  logCount++;
  start = true;
  solveRightHand = false;
  population = new Population(maze,mutationRate, populationSize);
  drawMaze(maze);
  
}

void Maze1(){
  loadMaze("maze8.txt");
}

void Maze2(){
  loadMaze("maze4.txt");
}

void Maze3(){
  loadMaze("maze5.txt");
}

void Maze4(){
  loadMaze("maze2.txt");
}
  



void drawMaze(Maze maze){
  for(int i = 0; i < maze.labyrinthHeight; i++){
    for(int j = 0; j < maze.labyrinthWidth; j++){
      switch (maze.labyrinth[i][j]) {
            case 'W': fill(50, 50, 50);
                      break;
            case ' ': fill(191, 191, 191);
                      break;
            case 'S': fill(0, 0, 153);
                      break;
            case 'F': fill(0,255,0);
                      break;
      }
      rect(j*blockSize, rHeight, blockSize, blockSize);
    }
    rHeight += blockSize;
  }
}

void drawMazePath(Maze maze, ArrayList<Coordinate> path ){
  for(int i = 0; i < maze.labyrinthHeight; i++){
        for(int j = 0; j < maze.labyrinthWidth; j++){
          switch (maze.labyrinth[i][j]) {
                case 'W': fill(50, 50, 50);
                          break;
                case ' ': fill(191, 191, 191);
                          break;
                case 'S': fill(0, 0, 153);
                          break;
                case 'F': fill(0,255,0);
                          break;
                               
          }
          for (Coordinate coord: path) {
            if(j == coord.x && i == coord.y){
                fill(255,255,0);
            }
          }
        rect(j*blockSize, rHeight, blockSize, blockSize);
      }
      rHeight += blockSize;
    }
}

void setup(){
  size(900, 900);
  textSize(14);
  background(25);
   cp5 = new ControlP5(this);

    PFont font = createFont("FontName", 20f);
    
    
    cp5.addSlider("populationSize").setPosition(140,600).setSize(400,20).setRange(0,3000).setValue(200).getCaptionLabel().setFont(font);
    cp5.addSlider("mutationRate").setPosition(140,621).setSize(400,20).setRange(0,1).setScrollSensitivity(0.001).setValue(0.02).setDecimalPrecision(3).getCaptionLabel().setFont(font);
    cp5.addButton("Start").setOff().setPosition(600,140).setSize(200,30).getCaptionLabel().setFont(font);
    cp5.addButton("Stop").setOff().setPosition(600,171).setSize(200,30).getCaptionLabel().setFont(font);
    cp5.addButton("Maze1").setOff().setPosition(600,202).setSize(200,30).getCaptionLabel().setFont(font);
    cp5.addButton("Maze2").setOff().setPosition(600,233).setSize(200,30).getCaptionLabel().setFont(font);
    cp5.addButton("Maze3").setOff().setPosition(600,264).setSize(200,30).getCaptionLabel().setFont(font);
    cp5.addButton("Maze4").setOff().setPosition(600,295).setSize(200,30).getCaptionLabel().setFont(font);
    cp5.addButton("SolveRightHand").setOff().setPosition(600,395).setSize(200,40).getCaptionLabel().setFont(font);
    cp5.getController("Maze4").getCaptionLabel().setFont(font);
}

void draw(){
  textSize(14);
  if(start && !solveRightHand && !population.finishReached()){
      background(40);
      population.live();
      population.calcFitness();
      pathToDraw = population.getBestPath();
      rHeight = 0;
      
      drawMazePath(maze, pathToDraw.path);

    if(!population.finishReached()){
      population.individNormalization();
    }
    
    
    fill(255);
    text("Population Size: " + population.individuals.length, 10, 800);
    text("Max Fitness : " + population.getMaxFitness(), 10, 818);
    text("Standart Deviation : " + population.getDeviation(), 10, 838);
    text("Average Fitness: " + population.getAvgFitness(), 10, 856);
    text("Generation: " + population.generation, 10, 874);
    text("Mutation Rate: " + population.mutationRate, 10, 760);
    text("Finish reached: " + population.finishReached(), 10, 780);
    
    if(!population.finishReached()){
      population.selection();
      population.reproduction();
    }
  }
  
  if(solveRightHand && !righthand.finished){
    background(40);
    rightHandPath = righthand.path;
    rHeight = 0;
    drawMazePath(maze, rightHandPath);

    righthand.makeStep();
    fill(255);
    text("Moves made: " + righthand.getNumSteps(), 10, 780);
  }

}