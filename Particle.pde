class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  float r = 3;
  boolean highlight;

  Particle(float x, float y) {
    acceleration = new PVector(0, 0.01);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = new PVector(x, y);
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  void intersects(ArrayList<Particle> particles) {
    highlight = false;
    for (Particle other : particles) {
      if (other != this) {
        float d = PVector.dist(other.position, position);
        if (d < r + other.r) {
          highlight = true;
        }
      }
    }
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }


  void update() {

    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    // stroke(0, lifespan);
    // strokeWeight(2);
    noStroke();
    //fill(127, lifespan);
    if (highlight) {
     
      //fill(255, 117, 20);
    }
    //ellipse(position.x, position.y, 10, 10);
    //frameRate(15);
    twitterBackground.resize(45, 40);
    image(twitterBackground, position.x, position.y);


    noCursor();
  }


  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}