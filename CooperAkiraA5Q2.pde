/*
 * COMP 1010  SECTION A04
 * INSTRUCTOR: DOMARATZKI
 * NAME: AKIRA COOPER
 * ASSIGNMENT: #5
 * QUESTION: #2
 
 * PURPOSE:  CREATE A WHACK-A-MOLE GAME THAT KEEPS TRACK OF BOTH TIME AND SCORE
 
 * NOTE: All SVG files in this assignment are those provided on UMLEARN
 */


final float HOLE_SIZE = 1000/10; // global constant for hole size
final int MAX_TIME = 15; // global constant for total game time (15 seconds)

PShape pic1; // global variable for empty hole SVG file
PShape pic2; // global variable for mole SVG file

boolean[] moleUp = new boolean [10]; // set array to size 10
boolean gameOver; // global boolean that initiates game over sequence once timer reaches 0

float minVal;
int t;
float timeInc;
float time;
int keepScore;
// global variables state variables associated with drawing moles randomly, setting and adjusting game time, and keeping track of score

void setup () {
  size(1000, 600);

  pic1 = loadShape("empty.svg");
  pic2 = loadShape("full.svg");
  t = 0;
  time = MAX_TIME;
  keepScore = 0;
}

void draw() {
  background(230);
  updateArray(moleUp);
  drawMoles(moleUp);
  drawScore(keepScore, int(time));
  checkMoleHit();

  t++;
  timeInc = t/60;
  time = MAX_TIME - timeInc; // decrease time by 1 every second

  if (time < 0) {
    time = 0;
  }
}


void updateArray (boolean[] moleUp) { // function that draws moles or empty holes, selected at random

  for (int i = 0; i < moleUp.length; i++) {

    float R = random (0, 1);
    minVal = 0.001;

    if (R < minVal) {
      moleUp[i] = !moleUp[i]; // move mole up if hole is empty, or erase mole if it is already drawn
      minVal += 0.005; // increase minVal to increase speed at which moles are drawn (speed increases as game progresses)
    }
  }
}

void drawMoles(boolean[] moleUp) { // function that draws either an empty hole or mole up

  for (int i = 0; i < moleUp.length; i++) {
    if (moleUp[i]) {
      shape(pic2, i*HOLE_SIZE, height/4, HOLE_SIZE, HOLE_SIZE); // draw mole up if boolean array at [i] is true
    } else {
      shape(pic1, i*HOLE_SIZE, height/4, HOLE_SIZE, HOLE_SIZE); // draw empty hole if boolean array at [i] is false
    }
  }
}

void drawScore(int score, int framesLeft) { // function that controls game timer, score, and game over sequence

  if (framesLeft != 0) {
    fill(0);
    textSize(15);
    text("Score:" + str(score), width/2 - width/14, height/2); // keep track of score

    fill(0);
    textSize(15);
    text("Time left: " + str(framesLeft) + " sec", width/2 + width/50, height/2); // draw game timer that decreases (in seconds)
  }

  if (gameOver) {
    framesLeft = 0;
    fill(0);
    textSize(15);
    text("Game Over! Final Score:" + str(score), width/2 - width/11, height/2);
    noLoop(); // stops the program and displays game over text with score if true
  }

  if (framesLeft <= 0) {
    gameOver = true; // if timer reaches 0, display "game over" text and final score
  }
}

boolean isInEllipse(float x, float y, float ellipseX, float ellipseY, float ellipseWidth, float ellipseHeight) {

  boolean inside = false;

  if ( (((sq(x-ellipseX)) / sq(ellipseWidth/2)) + (((sq(y-ellipseY)) / sq(ellipseHeight/2)))) <= 1 ) { // check to see if point is in specified ellipse
    inside = true;
  }

  return inside;
}

void checkMoleHit() {

  if (mousePressed) {

    for (int i = 0; i < moleUp.length; i++) {

      if (isInEllipse(mouseX, mouseY, HOLE_SIZE/2 + i*HOLE_SIZE, height/4 + 0.835*HOLE_SIZE, HOLE_SIZE, HOLE_SIZE*0.325) && moleUp[i]); // if mouse is in hole area and mole is up, execute the following:
      moleUp[i] = false; // draw an empty hole
      keepScore++; // increase score by 1
    }
  }
}