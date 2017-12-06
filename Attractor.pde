class Attractor {
  float mass;
  float G;
  PVector location;

  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 20;
    G = 1;
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location,m.location);
    float d = force.mag();
    d = constrain(d,5.0,25.0);
    force.normalize();
    float strength = (G * mass * m.mass) / (d * d);
    force.mult(strength);
    return force;
  }
}