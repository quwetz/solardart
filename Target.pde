class Target implements Collidable, GameObject{
  float bodyWidth = width / 128;
  float bodyHeight = height / 8;
  
  PVector pos = new PVector(0.0, 0.0);
  PVector size = new PVector(bodyWidth, bodyHeight); 
    
  color center = color(0,255,0);
  color mid = color(255, 255, 0);
  color edge = color(255, 0, 0);
  
  Score score;
  
  void draw(){
    translate(pos.x, pos.y);
    stroke(edge);
    fill(edge);
    rect(size.x * -0.5, size.y * -0.5, size.x, size.y);
    stroke(mid);
    fill(mid);
    rect(size.x * -0.5, size.y * -0.33, size.x, size.y * 0.66);
    stroke(center);
    fill(center);
    rect(size.x * -0.5, size.y * -0.167, size.x, size.y * 0.324);
    translate(-pos.x, -pos.y);
  }
  
  Projectile collides(){
    for(Projectile p: gameObjects.projs) {
      if (p.pos.x <= pos.x + bodyWidth / 2 && p.pos.x >= pos.x - bodyWidth / 2) {
        if(p.pos.y <= pos.y + bodyHeight / 2 && p.pos.y >= pos.y - bodyHeight / 2) {
          float yDist = abs(p.pos.y - pos.y);
          int s = 1;
          if(yDist <= bodyHeight * 0.18){
            s = 10;
          } else if (yDist <= bodyHeight * 0.35) {
            s = 5;
          }
          score.inc(s);
          return p;
        }
      }
    }
    return null;
  }
  
  void update() {
    draw();
  }
}
