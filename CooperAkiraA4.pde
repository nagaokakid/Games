/*
 * COMP 1010  SECTION A04
 * INSTRUCTOR: DOMARATZKI
 * NAME: AKIRA COOPER
 * ASSIGNMENT: #4
 
 * PURPOSE:  CREATE A FROGGER-TYPE GAME WHERE THE PLAYER MUST AVOID MOVING OBJECTS WHILE TRYING TO REACH THE OTHER SIDE
 
 * HIGHEST PHASE COMPLETED: PHASE 6
 */


final float OFFSET_INC = 0.75; // global constant that increases offset incrementally 
int level; // global variable for game level
float bandHeight; // height of each "band" that is dependent on level

float frogSize; // size of frog
float frogX; // x position of frog
float frogY; // y position of frog
float move; // the distance the frog can jump

float red;
float green;
float blue;
// global float variables for hazard colors

boolean inCanvas; // global boolean that detects if frog is outside canvas
boolean levelUp; // global boolean that detects if player has reached end of level (top of canvas)
boolean hazardHit; // global boolean that detects if player has collided with hazard

float offset;
// global float variable that adjusts hazard positions to make them move off screen and reappear

String showText;
// global string that changes game text depending on whether player reaches next level or hits a hazard


void setup() {
  fullScreen();
  noStroke();

  level = 1; // start game on level 1
  bandHeight = height/(level+4); // start game with 5 bands of equal height

  frogX = width/2; // draw x position in the middle of the screen
  frogY = height - bandHeight/2; // draw y position at the bottom of the screen
  frogSize = bandHeight/3; // set frog size in direct proportion to bandHeight

  offset = 0; // default value for mobile hazards (start position)
  levelUp = false; // defaut setting for levelUp (player has not reached top of canvas yet)

  showText = "";
}


void draw() {
  drawWorld();
  drawFrog(frogX, frogY, frogSize);
  drawHazards();
  detectWin(frogY);
  displayMessage(showText);

  bandHeight = height/(level+4); // adjusts bandHeight according to level
  move = bandHeight; // adjusts frog jumping distance according to level and bandHeight
}


void keyPressed() {

  if (key == 'w' || key == 'i') {
    moveFrog(0, -move); // move frog up if 'w' or 'i' is pressed
  } else if (key == 's' || key == 'k') {
    moveFrog(0, move); // move frog down if 's' or 'k' is pressed
  } else if (key == 'a' || key == 'j') {
    moveFrog(-move, 0); // move frog left if 'a' or 'j' is pressed
  } else if (key == 'd' || key == 'l') {
    moveFrog(move, 0); // move frog right if 'd' or 'l' is pressed
  }
}

void drawWorld() {

  for (int i = 0; i < (level+4); i++) {

    if (i == 0 || i == (level+3)) {
      red = 200;
      green = 100;
      blue = 50;
    } else if (i > 0 && i < (level+3)) {
      red = 50;
      green = 100;
      blue = 150;
    }
    // draws three blue bands in the middle of canvas and one dirt colored band on the top and bottom ends

    fill(red, green, blue); // set color of band according to its y position on canvas
    rect(0, bandHeight*i, width, bandHeight); // draw bands
  }
}

void drawFrog(float x, float y, float diam) {
  fill (10, 225, 50); // set frog color to green
  ellipse(x, y, diam, diam); // draws frog image
}

void moveFrog(float xChange, float yChange) {

  frogX += xChange; // move frog in x position
  frogY += yChange; // move frog in y position

  objectInCanvas(frogX, frogY, frogSize); 
  // apply global variables for frog position and size to boundaries set by boolean function

  if (!inCanvas) {
    if (frogX < 0) {
      frogX = 0 + frogSize/2;
    } else if (frogX > width) {
      frogX = width - frogSize/2;
    } else if (frogY < 0) {
      frogY = 0 + frogSize/2;
    } else if (frogY > height) {
      frogY = height - frogSize/2;
    }
  } // redraws frog image in canvas if player attempts to move outside canvas
}

boolean objectInCanvas(float x, float y, float diam) {

  if (x > -(diam/2) && x < width + (diam/2) && y > -(diam/2) && y < height + (diam/2)) {
    inCanvas = true; // set boundaries that determine when frog is inside canvas
  } else {
    inCanvas = false;
  } 

  return inCanvas; // return boolean to determine whether frog is inside or outside canvas
}

boolean drawHazard(int type, float x, float y, float size) {

  if (type == 0) {
    fill(225, 10, 0);
    ellipse(x, y, size, size);
  } else if (type == 1) {
    fill (255, 255, 0);
    triangle(x, y - size/2, x - size/2, y + size/2, x + size/2, y + size/2);
  } else if (type == 2) {
    fill (120, 100, 30);
    rect(x - size/2, y - size/2, size, size);
  }
  // local if statements that represent the three types of hazards (type 0 - 2)

  objectsOverlap(frogX, frogY, x, y, frogSize, size/2); // apply global and local variables to function to check if frog overlaps with hazard

  return hazardHit; // check to see if frog overlaps with hazard and initiate appropriate sequences
}

boolean drawHazards() {

  offset = (offset + OFFSET_INC) % bandHeight; // shift x position of hazards and redraw at the end of canvas

  for (int i = 0; i < level+2; i++) {
    float space = bandHeight*(i+3); // local variable that controls spacing of hazards
    int reverse = 1; // local variable that controls direction of hazard movement

    if ((i+3) % 2 == 0) {
      reverse = reverse*(-1); // make next line of hazards move in opposite direction from previous line
    }

    for (int multi = 0; multi <= (level+5); multi++) {
      drawHazard((i+3) % 3, offset*(reverse)*(i+3) + space*multi - bandHeight/4, height - (bandHeight*(i+1)) - bandHeight/2, bandHeight/2);
    } // draw multiple hazards with different spaces according to y position
  }

  return hazardHit; // check to see if frog overlaps with hazard and initiate appropriate sequences
}

boolean detectWin(float yPosn) {

  if (yPosn <= bandHeight) {
    levelUp = true;
  } else {
    levelUp = false;
  }
  // initiates levelUp sequence if player reaches top of canvas

  return levelUp;
}

void displayMessage(String m) {

  if (levelUp) {
    level++;
    frogX = width/2;
    frogY = height - bandHeight/2;
    frogSize = bandHeight/3;
  }
  // if player reaches top of canvas, increase level by 1 and move frog back to bottom of canvas

  if (!hazardHit) {
    showText = "Level " + str(level);
    fill(0);
    textSize(bandHeight/3);
    text(m, width/2 - bandHeight/2, bandHeight/2 + bandHeight/10);
  } 
  // display level number if player has not hit hazard
} 

boolean objectsOverlap(float x1, float y1, float x2, float y2, float size1, float size2) {

  if (x1 > (x2-(size1/2)) && x1 < (x2+size2+(size1/2)) && y1 > (y2-(size1/2)) && y1 < (y2+size2+(size1/2))) {
    hazardHit = true;
  } else {
    hazardHit = false;
  }
  // set parameters to determine when frog overlaps with hazard

  if (hazardHit) {
    showText = "GAME OVER";
    noLoop();
  } 
  // show "game over" text and stop program if player hits hazard

  return hazardHit;
}