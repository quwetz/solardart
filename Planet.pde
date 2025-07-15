class Planet implements Collidable, GameObject{
  PVector pos; //Relative to center
  PVector screenPosition;
  int diameter;
  float mass;
  float velocity; //umrundungen pro Sekunde
  
  Planet(PVector pos, int diameter, float vel){
     this.pos = pos;
     this.screenPosition = PVector.add(pos, center);
     this.diameter = diameter;
     this.mass = pow(diameter/2, 3) * 1.33 * PI;
     this.velocity = vel;
  }
  
  void update(){
    pos.rotate(velocity / frameRate);
    PVector tempPos = pos.copy();
    tempPos.y *= aspectRatio;
    screenPosition = tempPos.add(center);
    draw();
  }

  void draw(){
     color c = color(65, 255);
     fill(c);
     stroke(c);
     circle(screenPosition.x, screenPosition.y, diameter);
  }
  
  Projectile collides(){
    for(Projectile p: gameObjects.projs) {
      if (screenPosition.dist(p.pos) <= diameter / 2) {
        return p;
      }
    }
    return null;
  }
}
