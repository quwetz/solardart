enum PlayerState {
  INACTIVE,
  AIMING,
  CHARGING,
  GUIDING,
}

class Player implements Collidable, GameObject{
  PlayerState state = PlayerState.INACTIVE;
  PVector pos = new PVector(0.0, 0.0);
  float rotation = 0.0;
  float bodyWidth = width / 64;
  float cannonLength = width / 50;
  float cannonWidth = width / 192;
  float charge = 0.0;
  float maxCharge = 15.0;
  float chargeRate = maxCharge / (1.5 * frameRate);
  Projectile activeProjectile;
  color c;
  
  void update(){
    switch(state){
     case AIMING:
      pointToMouse();
      break;
     case CHARGING:
      pointToMouse();
      if(charge < maxCharge){
       charge += chargeRate; 
      } else {
        shoot();
      }
      break;
     case GUIDING:
        if (mousePressed){
          activeProjectile.propell();
        }
        break;
     case INACTIVE:
      break;
    }
    draw();
  }
  void pointToMouse(){
    rotation = PVector.sub(new PVector(mouseX, mouseY), pos).heading() - PI/2;
  }
  void draw(){
    pushMatrix();
    translate(pos.x, pos.y);
    noFill();
    stroke(c);
    rect(-bodyWidth / 2, -bodyWidth / 2, bodyWidth, bodyWidth);
    rotate(rotation);
    rect(-cannonWidth / 2, - cannonWidth / 2, cannonWidth, cannonLength);
    fill(color(255, 204, 0));
    rect(-cannonWidth / 2, - cannonWidth / 2, cannonWidth, cannonLength * charge / maxCharge);
    fill(color(255,255,255));
    popMatrix();
  }
  
  void mouseDown(){
    switch(state){
     case AIMING:
      state = PlayerState.CHARGING;
      break;
     case CHARGING:
      break;
     case GUIDING:
      break;
     case INACTIVE:
      break;
    }
  }
  void mouseUp(){
    switch(state){
     case AIMING:
      break;
     case CHARGING:
      shoot();
      break;
     case GUIDING:
      break;
     case INACTIVE:
      break;
    }
  }
  
  void shoot(){
    PVector cannon = new PVector(0, cannonLength).rotate(rotation);
    PVector nozzle = PVector.add(pos, cannon);
    Projectile p = new Projectile(nozzle, 10.0, this);
    p.vel = cannon.normalize().mult(charge);
    addGameObject(p);
    activeProjectile = p;
    charge = 0.0;
    state = PlayerState.GUIDING;
  }
  Projectile collides(){
    for(Projectile p: gameObjects.projs) {
      if (p.pos.x <= pos.x + bodyWidth / 2 && p.pos.x >= pos.x - bodyWidth / 2) {
        if(p.pos.y <= pos.y + bodyWidth / 2 && p.pos.y >= pos.y - bodyWidth / 2) {
          return p;
        }
      }
    }
    return null;
  }
}
