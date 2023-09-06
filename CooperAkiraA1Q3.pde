/*
 * COMP 1010  SECTION A04
 * INSTRUCTOR: MIKE DOMARATZKI
 * NAME: AKIRA COOPER
 * ASSIGNMENT: #1
 * QUESTION: #3
 
 * PURPOSE:  CREATE AN ASTEROID THAT MOVES AT VARYING SPEEDS DEPENDING ON MOUSE POSITION
 */

final int MAX_SIZE = 30;
final int MAX_SPEED = 20;
// global constants for asteroid size and speed

int xPosn = 0;
int yPosn = 0;
// global variables for asteroid position

void setup() {
  size(500, 500);
}
// size of canvas

void draw() {
  background(230);
  moveAsteroid();
  drawAsteroid();
}
// draw function for asteroid

void moveAsteroid() {
  int speedX = (mouseX-250)/MAX_SPEED;
  int speedY = (mouseY-250)/MAX_SPEED;
  xPosn = xPosn + speedX;
  yPosn = yPosn + speedY;
  xPosn = xPosn%width;
  xPosn = (xPosn+width)%width;
  yPosn = yPosn%height;
  yPosn = (yPosn+height)%height;
}
// function to move asteroid at varying speeds according to mouse position

void drawAsteroid() {
  fill(100, 20, 0);
  ellipse(xPosn, yPosn, MAX_SIZE, MAX_SIZE);
}
// function to draw asteroid image 