import java.util.Collections;

GOContainer gameObjects;
Player activePlayer;
ArrayList<GameObject> toAdd;
ArrayList<GameObject> toDelete;
float aspectRatio;
PVector center;
Score score;

int points = 0;

void setup(){
  fullScreen();
  frameRate(60);
  score = new Score();
  aspectRatio = (float)height / (float)width;
  center = new PVector(width/2, height/2);
  toAdd = new ArrayList<GameObject>();
  toDelete = new ArrayList<GameObject>();
  gameObjects = new GOContainer();
  //addPlayer(new PVector(width - width * 0.2, height/2), color(21, 218, 57));
  addPlayer(new PVector(width * 0.2, height/2), color(157, 51, 240));
  addTarget(new PVector(width - width * 0.2, height/2));
  activePlayer = gameObjects.players.get(0);
  activePlayer.state = PlayerState.AIMING;
  initializeGalaxy();
}

void addTarget(PVector pos){
  Target t = new Target();
  gameObjects.add(t);
  t.pos = pos;
  t.score = score;
}

void addPlayer(PVector pos, color c){
  Player p = new Player();
  gameObjects.add(p);
  p.pos = pos;
  p.c = c;
}

void draw(){
  background(0);
  for(GameObject o: gameObjects.all){
     o.update();
  }
  doCollisionChecks();
  addObjects();
  deleteObjects();
  score.draw();
}

void initializeGalaxy(){
  gameObjects.add(new BlackHole(new PVector(0,0), int(width * 0.1), 1000 * width));
  spawnPlanets(7);
}

void spawnPlanets(int n){
  PVector uniformPosition = new PVector(width * 0.15, 0);
  float distRange = width * 0.3 / n;
  
  ArrayList<PVector> posVectorsFromCenter = new ArrayList<PVector>();
  float[] rotations = new float[n];
  
  for(int i = 0; i < n; i++){
    PVector pos = new PVector(distRange, 0).mult(i).add(uniformPosition);
    posVectorsFromCenter.add(pos);
    rotations[i] = 0.0; //2 * PI * i / n + random(0, PI / 32); 
  }
  Collections.shuffle(posVectorsFromCenter);
  for(PVector v: posVectorsFromCenter){
   v.rotate(rotations[posVectorsFromCenter.indexOf(v)]); //<>//
   addGameObject(new Planet(v, int(random(width * 0.02, width * 0.04)), random(2 * PI / 60, 4 * PI / 60)));
  }

}
void mousePressed(){
  activePlayer.mouseDown();
}
void mouseReleased(){
  activePlayer.mouseUp();
}
void keyPressed(){
 if(key == ' '){
  setup(); 
 }
}

void endTurn(){
  activePlayer.state = PlayerState.INACTIVE;
  ArrayList<Player> p = gameObjects.players;
  activePlayer = p.get((p.indexOf(activePlayer) + 1) % p.size());
  activePlayer.state = PlayerState.AIMING;
}

void doCollisionChecks(){
  for(Collidable c: gameObjects.colliders){
     Projectile p = c.collides();
     if(p != null){
      p.explode(); 
     }
  }
}

void addGameObject(GameObject o){
 toAdd.add(o); 
}
void deleteGameObject(GameObject o){
  toDelete.add(o);
}

private void addObjects(){
 for(GameObject o: toAdd){
  gameObjects.add(o); 
 }
 toAdd.clear();
}

private void deleteObjects(){
 for(GameObject o: toDelete){
   gameObjects.remove(o);
 }
 toDelete.clear();
}
