float maxX = 800;
float maxY = 400;
float offsetX;
float offsetY;

int peopleCount = 4000;
Individuum[] individuum = new Individuum[peopleCount];
float immuneIndividuals = 70; // Percent
float infected = 10; // Percent of the non-immune

color colorHealthyNormal = color(200, 200, 0);
color colorHealthyImmune = color(0, 128, 0);
color colorSick = color(255, 0, 0);
float individuumSize = 5;
float individuumSizeHalf = individuumSize / 2;

void setup() {
  fullScreen();
  background(50);
  noStroke();
  offsetX = (width - maxX)/2;
  offsetY = (height - maxY)/2;

  for (int i = 0; i < peopleCount; i++) {
    // Individuum(float x, float y, float maxDist, int duration, float pNormal, float pImmune, boolean immune, boolean infected)
    boolean immune = ((float) i * 100 / peopleCount < immuneIndividuals); 
    individuum[i] = new Individuum(random(maxX), random(maxY), 20, 5, 5.0, 0.0, immune, (!immune && infected > random(100)));
    plotIndividuum(individuum[i]);
  }
}

void draw() {
  for (int i = 0; i < peopleCount; i++) {
    for (int j = 0; j < peopleCount; j++) {
      if (i==j) {
        continue;
      }

      individuum[i].interact(individuum[j]);
    }
  }

  background(50);
  for (int i = 0; i < peopleCount; i++) {
    individuum[i].finalize();
    plotIndividuum(individuum[i]);
    moveIndividuum(individuum[i]);
  }
}

void plotIndividuum(Individuum individuum) {
  fill(individuum.infected ? colorSick : (individuum.immune ? colorHealthyImmune : colorHealthyNormal)); 
  square(offsetX - individuumSizeHalf + individuum.x, offsetY - individuumSizeHalf + individuum.y, individuumSize);
}

void moveIndividuum(Individuum i) {
  i.x += (random(6)-random(6));
  if (i.x < 0) {
    i.x += maxX;
  }
  if (i.x > maxX) {
    i.x -= maxX;
  }

  i.y += (random(6)-random(6));
  if (i.y < 0) {
    i.y += maxY;
  }
  if (i.y > maxY) {
    i.y -= maxY;
  }
}
