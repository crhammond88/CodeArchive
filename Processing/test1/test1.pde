void setup() {
  size(640,480);
  background(255);
}
void draw() { }

void mouseDragged() {
  smooth();
  fill(250,0,0);
  strokeWeight(2);
  stroke(10,0,200);
  ellipse(mouseX, mouseY, 14, 14);
  
  strokeWeight(2);
  stroke(10,100,10);
  int silly = random(-100,100);
  int ext = 200;
  line(mouseX, mouseY, mouseX + ext, mouseY + silly);
  line(mouseX, mouseY, mouseX - ext, mouseY - silly);
  
  fill(150,0,150,50);
  stroke(100,0,0);
  strokeWeight(1);
  triangle(mouseX, mouseY, 0, 0, 640, 0);
  triangle(mouseX, mouseY, 0, 480, 640, 480);
  
  strokeWeight(1);
  stroke(50,50,10);
  int what = random(640);
  line(mouseX, mouseY, what, 0);
  line(mouseX, mouseY, what, 480);
}

void mouseReleased() {
  strokeWeight(5);
  stroke(random(255),random(255),random(255));
  fill(random(255),random(255),random(255));
  arc(mouseX, mouseY, 100, 100, 0, HALF_PI);
  arc(mouseX, mouseY, 100, 100, PI, PI + HALF_PI);
  stroke(random(255),random(255),random(255));
  fill(random(255),random(255),random(255));;
  arc(mouseX, mouseY, 100, 100, HALF_PI, PI);
  arc(mouseX, mouseY, 100, 100, PI + HALF_PI, TWO_PI);
  
}



