/*
 * PURPOSE:  CREATE A SIMPLE TRAVERSAL GAME WITH A CLEAR OBJECTIVE
 */
 

final int HERO_SPEED = 5;
final int HERO_SIZE = 40;
final int MAX_TIME = 20;
// global constants for hero size and speed and game timer

int heroX;
int heroY;
// global variables for hero's position on canvas

boolean heroNearKey;
boolean heroHoldsKey;
// global boolean variables to control key position depending on hero's position

boolean heroHasTreasure;
boolean heroWins;
boolean showInitialText;
boolean showEndText;
boolean gameGuide;
// global boolean variables to provide instructions and initiate "game over" sequence

int t = 0;
float decreaseTime = 0;
String currentTime;
// global variable and String for game timer (in seconds)


void setup() {
  size (800, 600);
}


void draw() {
  background(70, 100, 100);
  drawAndControlHero();
  drawAndControlBarrier();
  drawTreasure();
  drawKey();
  gameInstructions();
  gameTimer();
}


void drawAndControlHero() {
  strokeWeight(1);
  fill(100, 150, 0);
  ellipse(heroX, heroY, HERO_SIZE, HERO_SIZE);
  // draw hero image

  if (keyPressed) {
    if (key=='w') {
      heroY -= HERO_SPEED;
    } // moves hero up if "w" key is pressed
      else if (key=='s') {
      heroY += HERO_SPEED;
    } // moves hero down if "s" key is pressed
      else if (key=='a') {
      heroX -= HERO_SPEED;
    } // moves hero left if "a" key is pressed
      else if (key=='d') {
      heroX += HERO_SPEED;
    } // moves hero right if "d" key is pressed
  }
  // conditionals for controlling hero movement with keyboard

  if (heroX<=HERO_SIZE/2) {
    heroX = HERO_SIZE/2;
  } 
  if (heroX>=width-HERO_SIZE/2) {
    heroX = width-HERO_SIZE/2;
  }
  if (heroY<=HERO_SIZE/2) {
    heroY = HERO_SIZE/2;
  }
  if (heroY>=height-HERO_SIZE/2) {
    heroY = height-HERO_SIZE/2;
  }
  // 4 conditionals for keeping hero image within the canvas
}
// function for drawing hero image, controlling its movement, and keeping it within the canvas


void drawAndControlBarrier() {
  strokeWeight(3);
  line(width-200, 0, width-200, height);
  line(width-150, 0, width-150, height);
  line(width-200, 25, width-150, 25);
  line(width-200, 50, width-150, 50);
  line(width-200, 75, width-150, 75);
  line(width-200, 100, width-150, 100);
  line(width-200, 125, width-150, 125);
  line(width-200, 150, width-150, 150);
  line(width-200, 175, width-150, 175);
  line(width-200, 200, width-150, 200);
  line(width-200, 225, width-150, 225);
  line(width-200, 375, width-150, 375);
  line(width-200, 400, width-150, 400);
  line(width-200, 425, width-150, 425);
  line(width-200, 450, width-150, 450);
  line(width-200, 475, width-150, 475);
  line(width-200, 500, width-150, 500);
  line(width-200, 525, width-150, 525);
  line(width-200, 550, width-150, 550);
  line(width-200, 575, width-150, 575);
  // vault bars

  if ((!heroNearKey)&&(!heroHoldsKey)) {
    fill(50);
    rect(width-200, 250, 50, 100);
    // vault hatch

    fill(80);
    ellipse(width-175, 300, 50, 50);
    line(width-190, 300, width-160, 300);
    line(width-175, 285, width-175, 315);
    // vault door

    if (heroX>=(width-200-HERO_SIZE/2)) {
      heroX = width-200-HERO_SIZE/2;
    }
  }
  // conditional prohibiting hero from passing through vault without key

  if (heroHoldsKey) {
    if (heroX==width-200&&heroY<=225||heroX==width-200&&heroY>=375) {
      heroX = width-200-HERO_SIZE/2;
    } 
    if (heroX==width-150&&heroY<=225||heroX==width-150&&heroY>=375) {
      heroX = width-150+HERO_SIZE/2;
    } 
    if (heroX>=width-200&&heroX<=width-150&&heroY<=225) {
      heroY = 225 + HERO_SIZE/2;
    }
    if (heroX>=width-200&&heroX<=width-150&&heroY>=375) {
      heroY = 375 - HERO_SIZE/2;
    }
  }
  // conditional prohibiting movement through vault bars regardless of key possession
}
// function for drawing barrier image and prohibiting hero from entering through it


void drawKey() {

  if (heroX>=0&&heroX<=120&&heroY>=(height-40)&&heroY<=height) {
    heroNearKey = true;
  }
  // conditional that tests whether hero is close enough to key to hold it

  if (heroHoldsKey) {
    strokeWeight(2);
    fill(150, 150, 50);
    rect(heroX-30, heroY-20, 60, 10);
    rect(heroX-30, heroY-10, 10, 20);
    rect(heroX-10, heroY-10, 10, 20);
    ellipse(heroX+50, heroY-15, 40, 40);
    fill(70, 100, 100);
    ellipse(heroX+50, heroY-15, 20, 20);
  }
  // conditional that draws key image on top of hero

  if (heroNearKey) {
    heroHoldsKey = true;
  }
  // conditional that allows hero to "hold" the key if near it

  if (!heroNearKey) {
    strokeWeight(2);
    fill(150, 150, 50);
    rect(20, height-30, 60, 10);
    rect(20, height-20, 10, 20);
    rect(40, height-20, 10, 20);
    ellipse(100, height-25, 40, 40);
    fill(70, 100, 100);
    ellipse(100, height-25, 20, 20);
  }
  // draw key image at bottom of screen if hero is not near it to pick it up
}
// function for drawing key image and controlling its position depending on hero's position


void drawTreasure() {
  strokeWeight(2);
  fill(250, 250, 10);
  rect(width-125, height-50, 100, 40);
}
// function for drawing treasure image


void gameInstructions() {
  if (heroX>=width-125&&heroX<=width-25&&heroY>=height-50&&heroY<=height-10) {
    heroHasTreasure = true;
  }
  // conditional that tests to see if hero is close to treasure

  if (heroWins) {
    fill(0, 255, 0);
    textSize(100);
    text("YOU WIN!", 60, height/2);
    textSize(25);
    text("You escaped with the gold.",130,height/2+60);
    noLoop();
  }
  // conditional that displays "YOU WIN!" text when hero wins, and then stops program

  if (heroHasTreasure) {
    heroWins = true;
  }
    else {
      heroWins = false;
    }
  // displays "YOU WIN!" text when hero grabs treasure
  
  if (showInitialText) {
    fill(255);
    textSize(15);
    text("|OBJECTIVE|",150,25);
    text("Grab the Key to Unlock the Vault!",150,50);
  }
  // conditional that displays text for first objective
  
  if (showEndText) {
    fill(255);
    textSize(15);
    text("|OBJECTIVE|",150,25);
    text("The Vault Door is Open! Steal the Gold!",150,50);
  }
  // conditional that displays text for second objective
  
  if (!heroNearKey) {
    showInitialText = true;
    showEndText = false;
  }
  // shows text for first objective
  
  if (heroNearKey) {
    showInitialText = false;
    showEndText = true;
  }
  // shows second objective if hero holds key and does not have treasure
  
  if (heroHasTreasure) {
    showEndText = false;
    showInitialText = false;
  }
  // clear second objective text if hero reaches treasure
  
  if (gameGuide) {
    fill(255);
    textSize(15);
    text("|GUIDE|",width/2+105,25);
    text("W = UP",width/2+105,50);
    text("S = DOWN",width/2+105,75);
    text("A = LEFT",width/2+105,100);
    text("D = RIGHT",width/2+105,125);
  }
  // instructions for user on how to move hero
   
  if (!heroHasTreasure) {
    gameGuide = true;
  }
    else {
    gameGuide = false;
  }
} // conditional that clears game guide text if hero reaches treasure

void gameTimer() {
  
  t+=1;
  decreaseTime = t/60;
  currentTime = str(int(MAX_TIME-decreaseTime));
  // set values for time and convert it to an integer, and then a string
  
  if ((MAX_TIME-decreaseTime)<0) {
    currentTime = str(0); // stop game timer at 0
    fill(255,0,0);
    textSize(100);
    text("YOU LOSE!",50,height/2); // display "YOU LOSE!" text
    textSize(25);
    text("The police have now arrived at the bank.", 60,height/2+60);
    noLoop(); // stop program if hero loses
  } // shows "YOU LOSE!" text if timer reaches 0
  
  if (!heroHasTreasure) {
    fill(255,90,0);
    textSize(20);
    text("The police will arrive in.... "+currentTime+" sec", 150,100);
    }
  // displays warning text and game timer as long as hero does not have treasure

}// function that controls game timer and "YOU LOSE" sequence
