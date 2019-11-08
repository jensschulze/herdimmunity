final class Individuum {
  float x;
  float y;
  float maxDist;
  boolean infected = false;
  boolean immune = false;
  int duration = 5;
  int counter = 0;
  float pNormal = 0; // Percent
  float pImmune = 0; // Percent
  boolean transmitted = false;
  
  Individuum(float x, float y, float maxDist, int duration, float pNormal, float pImmune, boolean immune, boolean infected) {
    this.x = x;
    this.y = y;
    this.maxDist = maxDist;
    this.duration = duration;
    this.pNormal = pNormal;
    this.pImmune = pImmune;
    this.immune = immune;
    this.infected = infected;
  }
  
  public void interact(Individuum other) {
    if (!other.infected || this.infected) {
      return;
    }
    
    if (dist(this.x, this.y, other.x, other.y) > this.maxDist) {
      return;
    }
    
    if (this.immune && random(100) >= pImmune) {
      return;
    }
    
    if (!this.immune && random(100) >= pNormal) {
      return;
    }
    
    this.transmitted = true;
  }
  
  public void finalize() {
    if (this.counter > 0) {
      this.counter--;
    }
    
    if (0 == this.counter) {
      this.infected = false;
    }
    
    if (true == this.transmitted) {
      this.transmitted = false;
      this.infected = true;
      this.counter = this.duration;
    }
  }
}
