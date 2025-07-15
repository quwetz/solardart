class Score {
 
  int score = 0;
  
  
  void inc(int value) {
   score += value;
  }
  void draw(){
    textSize(32);
    text("Score: " + score, 10, 40); 
  }
}
