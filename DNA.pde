import java.util.Random;


class DNA {
    public String genes;
    
    public  DNA(int length){
        this.genes = new String();
        Random rand = new Random();
        for(int i = 0; i < length * 2; i++){
            genes += rand.nextBoolean() ? '1' : '0';
        }
    }

    public DNA(String genes){
        this.genes = genes;
    }
    


    DNA crossover(DNA partner){
       Random random = new Random();
       StringBuilder stringBuilder = new StringBuilder(genes);
       for (int i = 0; i < genes.length(); i+=2) {
          if (Math.random() > 0.5){
            stringBuilder.setCharAt(i, this.genes.charAt(i));
            stringBuilder.setCharAt(i + 1, this.genes.charAt(i + 1));
          }
          else{
            stringBuilder.setCharAt(i, partner.genes.charAt(i));
            stringBuilder.setCharAt(i + 1, partner.genes.charAt(i + 1));
          }
       }
       DNA newgenes = new DNA(new String(stringBuilder));
       return newgenes;
    }

    void mutate(double mutationRate){
      StringBuilder stringBuilder = new StringBuilder(genes);
      int temp;
      for (int i = 0; i < genes.length(); i++) {
          if (Math.random() < mutationRate) {
              temp = Character.getNumericValue(stringBuilder.charAt(i));
              temp ^= 1;
              stringBuilder.setCharAt(i, (char) (temp + 48));
          }
      }
      genes = new String(stringBuilder);
    }
}