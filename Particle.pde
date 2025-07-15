abstract class Particle implements GameObject{
 float lifetime;
 PVector pos;
 PVector vel;
 float rotation;
 float scale;
 PShape shape;
 float alpha;
 color c;
 
 void update(){
   lifetime -= 1 / frameRate;
   pos.add(vel);
   draw();
   if (lifetime <= 0.0){
    deleteGameObject(this);
   }
 }
 
  void draw(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    scale(scale);
    shape.setFill(c);
    shape(shape, 0, 0);
    popMatrix();
  }
 
}
