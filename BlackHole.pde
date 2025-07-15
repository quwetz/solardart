class BlackHole extends Planet{
 BlackHole(PVector pos, int diameter, float mass){
  super(pos, diameter, 0.0);
  this.mass = mass;
 }
 void draw(){
     color c = color(255, 255, 0);
     fill(c);
     stroke(c);
     circle(screenPosition.x, screenPosition.y, diameter);
  }
}
