/*
 * PURPOSE:  CREATE A DIGITAL RAIN PROGRAM WHERE RANDOM SETS OF LETTERS MOVE DOWN THE SCREEN
 */


final int NUM_LETTERS = 50; // global constant for max number of letters per column

int a = int('A');
int z = int('Z');
// global int values used in generateString() function to choose random letters

String randomLetter; // global string that generates a random letter
String letterSet; // global string that stores fixed set of random letters
String[] letterArray = new String [NUM_LETTERS]; // global array that contains sets of random letters

int[] bottomSet = new int [NUM_LETTERS];
int[] lengthSet = new int [NUM_LETTERS];
int[] speedSet = new int [NUM_LETTERS];
// global int arrays for bottom letter position, length of text, and speed at which text moves down the screen

float red;
float green;
float blue;
// global state variables used to set letter color depending on y position


void setup() {
  size(650, 650);
  frameRate(10);

  fillArray();
  generateBottoms();
  generateLengths();
  generateSpeeds();

  red = 0;
  green = 0;
  blue = 0;
}

void draw() {
  background(0);

  if (key != 'm') { // run digital rain if m is not pressed; if m is pressed, press any other key to run digital rain again
    drawDroplets(letterArray, bottomSet, lengthSet);
    updateBottoms(bottomSet, speedSet);
  }
}

void keyPressed() {
  if (key == 'm') {
    showAll(letterArray); // displays white letters on screen if 'm' is pressed
  }
}

String generateString() {

  letterSet = "";

  for (int i = 0; i < NUM_LETTERS; i++) {
    randomLetter = str((char)(int)random(a, z)); // generate random letter
    letterSet += " " + randomLetter; // store random letters
  }

  return letterSet; // return letter set
}

String[] fillArray() {

  for (int i = 0; i < letterArray.length; i++) {
    letterArray[i] = generateString(); // plug in a set of random letters in each array
  }

  return letterArray; // return array containing sets of letters
}

void showAll(String[] droplets) {

  for (int column = 0; column < NUM_LETTERS; column++) { // controls the column number of letter set

    for (int row = 0; row < NUM_LETTERS; row++) { // controls vertical row of letters
      fill(255);
      textSize(height/NUM_LETTERS);
      text(droplets[column].charAt(row), column * (width/NUM_LETTERS), row * (width/NUM_LETTERS));
      // takes each letter from the set and draws it vertically on the screen
    }
  }
}

int[] generateBottoms() {

  for (int i = 0; i < bottomSet.length; i++) {
    bottomSet[i] = int(random(0, NUM_LETTERS-1)); // generate random bottom letter position, then store in array
  }

  return bottomSet;
}

int[] generateLengths() {

  for (int i = 0; i < lengthSet.length; i++) {
    lengthSet[i] = int(random(10, 25)); // generate random length of letters, then store in array
  }

  return lengthSet;
}

int[] generateSpeeds() {

  for (int i = 0; i < speedSet.length; i++) {
    speedSet[i] = int(random(1, 5)); // generate random speed, then store in array
  }

  return speedSet;
}

void updateBottoms(int[] dropletBottom, int[] speed) {

  for (int i = 0; i < NUM_LETTERS; i++) {
    dropletBottom[i] += speed[i]; // moves lines of letters vertically down the screen at varying speeds
  }
}

void drawDroplets(String[] letters, int[] dropletBottom, int[] dropletLength) {

  int bottomLetter; // local state variable that represents which letters get drawn
  int topEnd; // value that represents top position of letter set
  int bottomEnd; // value that represents bottom position of letter set

  for (int column = 0; column < NUM_LETTERS; column++) { // controls column number of letter set

    topEnd = dropletBottom[column] - dropletLength[column];
    bottomEnd = dropletBottom[column]; 

    for (bottomLetter = bottomEnd; bottomLetter > topEnd; bottomLetter--) { // controls the number of letters drawn vertically on the screen (one over the other)

      if (bottomLetter == bottomEnd) { // set color of bottom-most letter to bright green
        red = 0;
        green = 255;
        blue = 10;
      } else if (bottomLetter < bottomEnd) { // set color of all other letters to darker green
        red = 0;
        green = 175;
        blue = 10;
      }

      fill(red, green, blue);
      textSize(height/NUM_LETTERS);
      text(letters[column].charAt((bottomLetter+NUM_LETTERS+1) % NUM_LETTERS), column * (width/NUM_LETTERS), (bottomLetter+NUM_LETTERS+1) % NUM_LETTERS * (height/NUM_LETTERS));
      // draws vertical set of letters on screen of varying lengths, and wraps text around the screen once it reaches bottom
    }
  }
}
