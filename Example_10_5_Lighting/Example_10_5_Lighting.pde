// Variables to control the ambient light.
float ambv1, ambv2, ambv3, ambx1, amby1, ambz1, 
  ambx2, amby2, ambz2;

// Variables to control the point light.
float ptv1, ptv2, ptv3, ptx1, pty1, ptz1, 
  ptx2, pty2, ptz2;

// Variables to control the directional light.
float dirv1, dirv2, dirv3, dirx1, diry1, dirz1, 
  dirx2, diry2, dirz2;

int rate, colorMode;

void setup() {
  surface.setResizable(true);
  surface.setTitle("Lighting");
  pixelDensity(displayDensity());
  size(640, 420, P3D);
  background(64);
  noStroke();

  // Initialize variables that control ambient light.
  ambv1 = random(0, 156);
  ambv2 = random(0, 156);
  ambv3 = random(0, 156);
  ambx1 = random(0, width);
  amby1 = random(0, height);
  ambz1 = 0;

  // Initialize variables that control point light.
  ptv1 = random(0, 156);
  ptv2 = random(0, 156);
  ptv3 = random(0, 156);
  ptx1 = random(0, width);
  pty1 = random(0, height);
  ptz1 = 0;

  // Initialize variables that control directional light.
  dirv1 = random(0, 80);
  dirv2 = random(0, 80);
  dirv3 = random(0, 80);

  // Unlike the other lights, the directional light doesn't
  // have a spatial position, only normals which are oriented
  // relative to positive and negative x, y, z axes.
  dirx1 = random(-1, 1);
  diry1 = random(-1, 1);
  dirz1 = random(-1, 1);

  rate = 100;
  colorMode = RGB;
}

void draw() {
  colorMode(colorMode, 255, 255, 255);
  background(32);

  // Create the lights using values for color and position.
  ambientLight(ambv1, ambv2, ambv3, ambx1, amby1, ambz1);
  pointLight(ptv1, ptv2, ptv3, ptx1, pty1, ptz1);
  directionalLight(dirv1, dirv2, dirv3, dirx1, diry1, dirz1);

  // Draw the sphere.
  pushMatrix();
  translate(width * 0.125, height / 2.0, -height / 1.25);
  sphere(height / 2.5);
  popMatrix();

  // Draw the box.
  pushMatrix();
  translate(width * 0.825, height / 2.0, -height / 1.25);
  rotateX(frameCount / 90.0);
  rotateY(frameCount / 90.0);
  box(height / 2.5);
  popMatrix();

  // Every so often,
  if (frameCount % rate == 0) {
    // Set a new destination for the ambient light.
    ambx2 = random(0, width);
    amby2 = random(0, height);
    ambz2 = random(-5.0, 5.0);

    // Set a new destination for the spot light.
    ptx2 = random(0, width);
    pty2 = random(0, height);
    ptz2 = random(-5.0, 5.0);

    // Set a new destination for the directional light.
    dirx2 = random(-1.0, 1.0);
    diry2 = random(-1.0, 1.0);
    dirz2 = random(-1.0, 1.0);
  }

  // Move from current position to destination.
  ambx1 = lerp(ambx1, ambx2, 0.05);
  amby1 = lerp(amby1, amby2, 0.05);
  ambz1 = lerp(ambz1, ambz2, 0.05);

  ptx1 = lerp(ptx1, ptx2, 0.05);
  pty1 = lerp(pty1, pty2, 0.05);
  ptz1 = lerp(ptz1, ptz2, 0.05);

  dirx1 = lerp(dirx1, dirx2, 0.05);
  diry1 = lerp(diry1, diry2, 0.05);
  dirz1 = lerp(dirz1, dirz2, 0.05);
}

// On mouse press, set the lights to a new random color. Print off the
// hex values.
void mousePressed() {
  ambv1 = random(0, 156);
  ambv2 = random(0, 156);
  ambv3 = random(0, 156);
  println("\nambient: #" + hex(color(ambv1, ambv2, ambv3)).substring(2));

  ptv1 = random(0, 156);
  ptv2 = random(0, 156);
  ptv3 = random(0, 156);
  println("point: #" + hex(color(ptv1, ptv2, ptv3)).substring(2));

  dirv1 = random(0, 80);
  dirv2 = random(0, 80);
  dirv3 = random(0, 80);
  println("directional: #" + hex(color(dirv1, dirv2, dirv3)).substring(2));
}