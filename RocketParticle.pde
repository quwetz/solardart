class RocketParticle extends Particle{ 
  RocketParticle(PVector _pos, PVector _vel, color _c){
    pos = _pos;
    vel = _vel;
    c = _c;
    lifetime = 0.2;
    rotation = random(-PI, PI);
    shape = createShape(TRIANGLE, 0, 0, 1, 0, 0.5, 0.866);
    alpha = 255;
  }
  void update(){
    scale += 10 / frameRate;
    super.update();
  }
}
