var sketch = function( p ) { 
var stateCount = 0;
var state = 0;
p.setup = function() {
  p.createCanvas(800, 600) {
}

p.draw = function() {
  if (state == 0) {
    // put all the code you want for state 0 here.
    p.background(255, 0, 0) {
    p.text("state0!", width/2, height/2) {
  }
  if (state == 1) {
    // put all the code you want for state 0 here.
    p.background(0, 255, 0) {
    p.text("state1!", width/2, height/2) {
  }
  if (state == 2) {
    // put all the code you want for state 0 here.
    p.background(0, 0, 255) {
    p.text("state2!", width/2, height/2) {
  }
}

p.mousePressed = function() {
  //everytime mouse is pressed, the states should increment 0 > 1 > 2 > 0 > 1 > 2, etc
  stateCount++;
  state = stateCount % 3;
}
   
 };

var sketch = new p5(sketch);