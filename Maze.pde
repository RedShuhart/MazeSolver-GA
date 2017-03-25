import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;


class Maze {

    public char labyrinth[][];
    public int labyrinthHeight;
    public int labyrinthWidth;
    public Coordinate startCoord;
    public Coordinate finishCoord;

    public Maze(String filepath){

        try {
            File mazeFile = new File(filepath);
            String rows[] = convertToStrings(mazeFile);
            int height = rows.length;
            int width = rows[1].length();

            labyrinth = new char[height][width];
            for (int i = 0; i < rows.length; i++) {
                for (int j = 0; j < rows[i].length(); j++) {
                    labyrinth[i][j] = rows[i].charAt(j);
                }
            }
            labyrinthHeight = height;
            labyrinthWidth = width;
            startCoord = getStart();
            finishCoord = getFinish();
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }

    public String[] convertToStrings(File file) throws FileNotFoundException {
            Scanner scanner = new Scanner(file);
            ArrayList<String> input = new ArrayList<String>();
            while (scanner.hasNextLine()){
                input.add(scanner.nextLine());
            }
            scanner.close();
            String s[] = input.toArray(new String[0]);
            for(int i = 0; i < s.length; i++){
                s[i] = s[i].replace("+","W").replace("-","W").replace("|","W");
                s[i] = "W" + s[i] + "W";
            }
            return  s;
    }
    
    public boolean isWall(Coordinate coord){
        if(labyrinth[coord.y][coord.x] == 'W') return true;
        return false;
    }

    public boolean isFinish(Coordinate coord){
        if(labyrinth[coord.y][coord.x] == 'F') return true;
        return false;
    }

    public Coordinate getStart(){
        Coordinate start = new Coordinate(0,0);
        for(int i = 0; i < labyrinthHeight; i++){
            for(int j = 0; j < labyrinthWidth; j++){
                if(labyrinth[i][j] == 'S') start = new Coordinate(j,i);
            }
        }
        return start;
    }

    public Coordinate getFinish(){
        Coordinate finish = new Coordinate(0,0);
        for(int i = 0; i < labyrinthHeight; i++){
            for(int j = 0; j < labyrinthWidth; j++){
                if(labyrinth[i][j] == 'F') finish = new Coordinate(j,i);
            }
        }
        return finish;
    }

    public int getBlanks(){
        int count = 0;
        for(int i = 0; i < labyrinthHeight; i++){
            for(int j = 0; j < labyrinthWidth; j++){
                if(labyrinth[i][j] == ' ' || labyrinth[i][j] == 'F') count++;
            }
        }
        return count;
    }


}