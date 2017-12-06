class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  SoundWave soundWave;

  Mover(float m) {
    mass = m;
    location = new PVector(random(width), random(height));
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
    soundWave = new SoundWave();
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    if(beat.isKick()) {
     f.mult(0.1); 
    }
    acceleration.add(f);
  }

  void update() {
    soundWave.rotate();
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  float[] getPoint() {
   return new float[]{location.x,location.y}; 
  }
  
}