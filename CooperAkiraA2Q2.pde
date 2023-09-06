/*
 * COMP 1010  SECTION A04
 * INSTRUCTOR: DOMARATZKI
 * NAME: AKIRA COOPER
 * ASSIGNMENT: #2
 * QUESTION: #2
 
 * PURPOSE:  CREATE A PAINT PROGRAM THAT ALLOWS THE USER TO DRAW A CONTINUOUS LINE AND CHANGE SEVERAL FEATURES
 */
 
 
int red;
int green;
int blue;
// global variables for background color

int redStroke;
int greenStroke;
int blueStroke;
// global variables for stroke color

int thickness;
// global variable for stroke weight

void setup() {
  size(800, 600);
  drawPalette();
  drawSubCanvas();
}

void draw() {
  checkPaletteClick();
  drawInCanvas();
}

void backgroundPalette() {
  strokeWeight(1);
  fill(0);
  textSize(15);
  text("Background Color", 5, 25); // background color title text
  fill(255, 0, 0);
  rect(5, 35, 30, 30); // red background
  fill(0, 255, 0);
  rect(40, 35, 30, 30); // green background
  fill(0, 0, 255);
  rect(75, 35, 30, 30); // blue background
  fill(255, 255, 0);
  rect(110, 35, 30, 30); // yellow background
} // draw the palette for background colors

void strokeColorPalette() {
  strokeWeight(1);
  fill(0);
  textSize(15);
  text("Stroke Color", 5, 125); // stroke color title text
  fill(255, 0, 0); 
  rect(5, 135, 30, 30); // red stroke
  fill(0, 255, 0); 
  rect(40, 135, 30, 30); // green stroke
  fill(0, 0, 255);
  rect(75, 135, 30, 30); // blue stroke
  fill(255, 255, 0); 
  rect(110, 135, 30, 30); // yellow stroke
} // draw the palette for stroke colors

void thicknessPalette() {
  strokeWeight(1);
  fill(0);
  textSize(15);
  text("Thickness", 5, 225); // thickness title text

  fill(180);
  strokeWeight(1);
  rect(5, 235, 30, 30);
  line(10, 250, 30, 250); // thickness +1

  strokeWeight(1);
  rect(40, 235, 30, 30);
  strokeWeight(3);
  line(45, 250, 65, 250); // thickness +2

  strokeWeight(1);
  rect(75, 235, 30, 30);
  strokeWeight(5);
  line(80, 250, 100, 250); // thickness +3

  strokeWeight(1);
  rect(110, 235, 30, 30);
  strokeWeight(7); 
  line(115, 250, 135, 250); // thickness +4
} // draw the palette for thickness levels

void drawPalette() {
  background(180);
  backgroundPalette();
  strokeColorPalette();
  thicknessPalette();
} // draw entire palette on left side of screen

void drawSubCanvas() {
  strokeWeight(1);
  fill(red, green, blue); // displays background color depending on what user clicks on
  rect(180, 10, 610, 580); // draws subcanvas
} // draw sub canvas on right side of screen

void setBackground() {
  
  if (mousePressed) {

    if (mouseX>=5&&mouseX<=35&&mouseY>=35&&mouseY<=65) {
      red = 255;
      green = 0;
      blue = 0;
      drawSubCanvas();
    } // sets background to red if box is clicked
      else if (mouseX>=40&&mouseX<=70&&mouseY>=35&&mouseY<=65) {
        red = 0;
        green = 255;
        blue = 0;
        drawSubCanvas();
    } // sets background to green if box is clicked
      else if (mouseX>=75&&mouseX<=105&&mouseY>=35&&mouseY<=65) {
        red = 0;
        green = 0;
        blue = 255;
        drawSubCanvas();
    } // sets background to blue if box is clicked
      else if (mouseX>=110&&mouseX<=140&&mouseY>=35&&mouseY<=65) {
        red = 255;
        green = 255;
        blue = 0;
        drawSubCanvas();
    } // sets background to yellow if box is clicked
  }
} // conditional that changes background color depending on which box is clicked

void setThickness() {
 if (mousePressed) {
  
   if (mouseX>=5&&mouseX<=35&&mouseY>=235&&mouseY<=265) {
     thickness = 0;
   } // sets thickness to level 1
     else if (mouseX>=40&&mouseX<=70&&mouseY>=235&&mouseY<=265) {
       thickness = 2;
   } // sets thickness to level 2
     else if (mouseX>=75&&mouseX<=105&&mouseY>=235&&mouseY<=265) {
       thickness = 4;
     } // sets thickness to level 3
     else if (mouseX>=110&&mouseX<=140&&mouseY>=235&&mouseY<=265) {
       thickness = 6;
     } // sets thickness to level 4
 } 
} // conditional that changes stroke weight depending on which box is clicked

void setStrokeColor() {

  if (mousePressed) {

    if (mouseX>=5&&mouseX<=35&mouseY>=135&mouseY<=165) {
      redStroke = 255;
      greenStroke = 0;
      blueStroke = 0;
    } // sets stroke color to red
      else if (mouseX>=40&&mouseX<=70&&mouseY>=135&&mouseY<=165) {
      redStroke = 0;
      greenStroke = 255;
      blueStroke = 0;
    } // sets stroke color to green
      else if (mouseX>=75&mouseX<=105&&mouseY>=135&&mouseY<=165) {
      redStroke = 0;
      greenStroke = 0;
      blueStroke = 255;
    } // sets stroke color to blue
      else if (mouseX>=110&&mouseX<=140&&mouseY>=135&&mouseY<=165) {
      redStroke = 255;
      greenStroke = 255;
      blueStroke = 0;
    } // sets stroke color to yellow
  }
} // conditional that changes stroke color depending on which box is clicked

void checkPaletteClick() {
  setBackground();
  setStrokeColor();
  setThickness();
} // checks for mouse clicks in palette area and changes color and/or thickness accordingly

void drawInCanvas() {
  if (mousePressed&&(mouseX>=180&&mouseX<=790&&mouseY>=10&&mouseY<=590)) {
    strokeWeight(thickness);
    stroke(redStroke, greenStroke, blueStroke);
    line(pmouseX, pmouseY, mouseX, mouseY);
  } // draws colored line if mouse clicked in sub canvas area
}