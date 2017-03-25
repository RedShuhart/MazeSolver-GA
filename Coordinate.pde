public class Coordinate {

    public int x;
    public int y;

    public Coordinate(int x, int y){
        this.x = x;
        this.y = y;
    }
    
    public double getDistance(Coordinate coord){
        return Math.sqrt(Math.pow(Math.abs(coord.x - this.x), 2) + Math.pow(Math.abs(coord.y - this.y), 2));
    }

    public int[] getXY(){
        int coord[] = new int[2];
        coord[0] = this.x;
        coord[1] = this.y;
        return coord;
    }
}