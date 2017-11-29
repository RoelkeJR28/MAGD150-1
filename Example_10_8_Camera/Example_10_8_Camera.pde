// Since 3D requires so many variables and functions,
// an object-oriented approach is increasingly preferable.
// See the Utilities demos for cameras and lights.

float angle, camSpeed, 
  x, y, z, 
  lookAtX, lookAtY, lookAtZ, 
  upX, upY, upZ, 
  orthoScale, 
  viewDist, 
  extents = 250;
boolean orthographic;

void setup() {
  surface.setResizable(true);
  surface.setTitle("Camera");
  pixelDensity(displayDensity());
  size(640, 420, P3D);
  background(64);
  noStroke();

  angle = 0;
  camSpeed = 5.0;
  x = width / 2.0;
  y = height / 2.0;
  z = viewDist = (height / 2.0) / tan(PI * 60.0 / 360.0);
  lookAtX = x;
  lookAtY = y;
  lookAtZ = 0;
  upX = 0;
  upY = 1;
  upZ = 0;
  orthoScale = 2.0;
  orthographic = false;
}

void draw() {
  background(32);
  pointLight(255, 127, 127, 0, 0, -extents);
  pointLight(127, 255, 127, width, 0, -extents);
  pointLight(127, 127, 255, width, 0, extents);
  pointLight(255, 127, 255, 0, 0, extents);
  directionalLight(127, 127, 127, 0, 0, -1);

  // Orthographic projection does not change the size of
  // an object based on distance.
  if (orthographic) {
    ortho(-width / orthoScale, 
      width / orthoScale, 
      -height / orthoScale, 
      height / orthoScale, 
      z / 1000.0, z * 1000.0);
  } else {
    perspective(PI / 3.0, 
      float(width) / float(height), 
      z / 2000.0, z * 2000.0);
  }
  camera(x, y, z, 
    lookAtX, lookAtY, lookAtZ, 
    upX, upY, upZ);

  keys();
  drawObjects();
  drawFloor(16, extents);
}

void drawObjects() {
  // Draw the sphere.
  pushMatrix();
  translate(width * 0.25, height / 2.0, -height / 1.5);
  sphere(height / 2.5);
  popMatrix();

  // Draw the box.
  pushMatrix();
  translate(width * 0.75, height / 2.0, -height / 1.5);
  rotateX(angle);
  rotateY(angle);
  box(height / 2.5);
  popMatrix();

  angle += 0.01;
}

void keys() {
  if (keyPressed) {
    if (y > 0
      && (key == 'w' || key == 'W' || keyCode == UP)) {
      y -= camSpeed;
      lookAtY = y;
    }
    if (x > -extents
      && (key == 'a' || key == 'A' || keyCode == LEFT)) {
      x -= camSpeed;
      lookAtX = x;
    }
    if (y < height - 10
      && (key == 's' || key == 'S' || keyCode == DOWN)) {
      y += camSpeed;
      lookAtY = y;
    }
    if (x < extents
      && (key == 'd' || key == 'D' || keyCode == RIGHT)) {
      x += camSpeed;
      lookAtX = x;
    }
    if (z > -extents
      && (key == 'q' || key == 'Q')) {
      if (orthographic) {
        orthoScale += 0.01;
      }
      z -= camSpeed;
      lookAtZ = z - viewDist;
    }
    if (z < extents
      && (key == 'e' || key == 'E')) {
      if (orthographic) {
        orthoScale -= 0.01;
      }
      z += camSpeed;
      lookAtZ = z - viewDist;
    }
  }
}

void drawFloor(int tiles, float scale) {
  float x, z, 
    min = tiles * -scale / 2.0, 
    max = tiles * scale / 2.0;
  for (int i = 0; i < tiles; ++i) {
    for (int j = 0; j < tiles; ++j) {

      if (i % 2 == j % 2) {
        fill(map(i, 0, tiles, 0, 255), 
          map(j, 0, tiles, 0, 255), 
          127);
      } else {
        fill(0, map(i, 0, tiles, 255, 127), 
          map(j, 0, tiles, 255, 
          127));
      }

      x = map(i, 0, tiles, min, max);
      z = map(j, 0, tiles, min, max);

      beginShape();
      vertex(x, height, z);
      vertex(x + scale, height, z);
      vertex(x + scale, height, z + scale);
      vertex(x, height, z + scale);
      endShape(CLOSE);
    }
  }
}

void mousePressed() {
  orthographic = !orthographic;
}