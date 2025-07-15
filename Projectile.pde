class Projectile implements GameObject{
  PVector pos;
  PVector vel;
  float mass;
  PShape sprite;
  Player owner;
  float fuel = 100.0;
  float timer = 5.0;
  boolean controllable = true;
  float propellAcceleration = 10.0;
  
  Projectile(PVector pos, float mass, Player owner){
   this.pos = pos;
   this.mass = mass;
   this.owner = owner;
   this.vel = new PVector(0,0);
   sprite = createShape(TRIANGLE, 0, 0, -5, -20, 5, -20);
   sprite.setFill(owner.c);
  }
  
  void update(){
    PVector acc = new PVector(0,0);
    for(Planet p: gameObjects.planets){
      acc.add(PVector.mult(PVector.sub(p.screenPosition, pos), 0.000001 * mass * p.mass / pow(pos.dist(p.screenPosition), 2)));
    }
    vel.add(acc);
    pos.add(vel);
    timer -= 1.0 / frameRate;
    if (controllable && (fuel <= 0.0 || timer <= 0.0)) {
      endTurn();
      controllable = false;
    }
    draw();
  }
  void draw(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading() - PI/2);
    shape(sprite, 0, 0);
    popMatrix();
  }
  void propell(){
   fuel -= 100.0 / frameRate; 
   PVector dir = vel.copy().normalize();
   vel.add(dir.mult(propellAcceleration/frameRate));
   for(int i = 0; i < 5; i++){
     PVector pVel = vel.copy().normalize().mult(propellAcceleration + random (-2, 2)).rotate(random(-PI/32, PI/32));
     addGameObject(new RocketParticle(pos.copy(), PVector.sub(vel, pVel), owner.c));
   }
  }
  
  void explode(){
   deleteGameObject(this);
   if (controllable){
     endTurn();
   }
   controllable = false;
  }
}
