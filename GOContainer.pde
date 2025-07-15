class GOContainer {
  ArrayList<GameObject> all;
  ArrayList<Particle> particles;
  ArrayList<Projectile> projs;
  ArrayList<Planet> planets;
  ArrayList<Player> players;
  ArrayList<Target> targets;
  ArrayList<Collidable> colliders;
  
  GOContainer(){
   all = new ArrayList<GameObject>();
   particles = new ArrayList<Particle>();
   projs = new ArrayList<Projectile>();
   planets = new ArrayList<Planet>();
   players = new ArrayList<Player>();
   colliders = new ArrayList<Collidable>();
   targets = new ArrayList<Target>();
  }
  
  void add(GameObject o){
   all.add(o);
   if(o instanceof Collidable){
    colliders.add((Collidable) o); 
   }
   if(o instanceof Projectile){
    projs.add((Projectile) o); 
    return;
   }
   if(o instanceof Player){
    players.add((Player) o);
    return;
   }
   if(o instanceof Planet){
    planets.add((Planet) o);
    return;
   }
   if(o instanceof Particle){
     particles.add((Particle) o);
   return;
   }
   if(o instanceof Target){
     targets.add((Target) o);
   return;
   }
  }
  
  void remove(GameObject o){
   all.remove(o);
   if(o instanceof Collidable){
    colliders.remove((Collidable) o); 
   }
   if(o instanceof Projectile){
    projs.remove((Projectile) o); 
    return;
   }
   if(o instanceof Player){
    players.remove((Player) o);
    return;
   }
   if(o instanceof Planet){
    planets.remove((Planet) o);
    return;
   }
   if(o instanceof Particle){
     particles.remove((Particle) o);
   return;
   }
   if(o instanceof Target){
     targets.remove((Target) o);
   return;
   }
  }
}
