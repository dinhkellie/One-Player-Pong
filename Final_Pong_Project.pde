int ballX, ballY, ballW, ballH, speedX, speedY;
int leftPaddleX, leftPaddleY, leftPaddleW, leftPaddleH, leftPaddleS;
int rightPaddleX, rightPaddleY, rightPaddleW, rightPaddleH, rightPaddleS;
boolean up, down;
color paddleColor = color(0);
color gameOverText = color(255, 0, 0);
int score = 0;
PVector p1, p2;
 
void setup() {
  size(displayWidth, displayHeight);
  smooth();
 
  //initialize variables for ball
  ballX = width/2;
  ballY = height/2;
  ballW = 100;
  ballH = 100;
  speedX = 7;
  speedY = 7;
 
  //initialize variables for leftPaddle
  rectMode(CENTER);
  leftPaddleX = 50;
  leftPaddleY = height/2;
  leftPaddleW = 50;
  leftPaddleH = 175;
  leftPaddleS = 15;
  p1 = new PVector(50, height/2);
 
  //initialize variables for rightPaddle
  rectMode(CENTER);
  rightPaddleX = width-50;
  rightPaddleY = height/2;
  rightPaddleW = 50;
  rightPaddleH = 175;
  rightPaddleS = 15;
  p2 = new PVector(width-50, height/2);
}
 
void draw() {
  background(255);
  stroke(0);
 
  for (int i=0; i < width; i+=50) {
    line(i, 0, i, height);
  }
  text("Get to 10 to win", width/2 - 120, 35);
   
  //methods for ball
  drawCircle();
 
  moveCircle();
 
  bounceCircle();
 
  //methods for leftPaddle
  drawLeftPaddle();
 
  moveLeftPaddle();
 
  restrictLeftPaddle();
 
  bounceLeftPaddle();
 
  //methods for rightPaddle
  drawRightPaddle();
 
  moveRightPaddle();
 
  restrictRightPaddle();
 
  bounceRightPaddle();
 
  //score
  score();
 
  //game over page
  gameOver();
}
 
//draws circle
void drawCircle() {
  noStroke();
  fill(random(255));
  ellipse(ballX, ballY, ballW, ballH);
}
 
//makes circle move
void moveCircle() {
  ballX = ballX + speedX;
  ballY = ballY + speedY;
}
 
//makes ball bounce back from edge of screen
void bounceCircle() {
  if (ballX > width - ballW/2) {
    setup();
    score = 0;
    speedX = -speedX;
  } else if (ballX < 0 + ballW/2) {
    speedX = -speedX;
    setup();
    score = 0;
  }
 
  if (ballY > height - ballH/2) {
    speedY = -speedY;
  } else if (ballY < 0 + ballH/2) {
    speedY = -speedY;
  }
}
//draws leftPaddle
void drawLeftPaddle() {
  fill(paddleColor);
 
  rect(p1.x, p1.y, leftPaddleW, leftPaddleH);
}
 
//moves leftPaddle
void moveLeftPaddle() {
  if (up) {
    p1.y = p1.y - leftPaddleS;
  }
  if (down) {
    p1.y = p1.y + leftPaddleS;
  }
}
 
//makes leftPaddle not be able to move farther than the top and bottom of screen
void restrictLeftPaddle() {
  if (p1.y - leftPaddleH/2 < 0) {
    p1.y = p1.y + leftPaddleS;
  }
  if (p1.y + leftPaddleH/2 > height) {
    p1.y = p1.y - leftPaddleS;
  }
}
 
//makes ball bounce off of leftPaddle
void bounceLeftPaddle() {
  if (ballX - ballW/2 < p1.x + leftPaddleW/2 && ballY - ballH/2 < p1.y + leftPaddleH/2 && ballY + ballH/2 > p1.y - leftPaddleH/2) {
    if (speedX < 0) {
      speedX = -speedX;
      score = score + 1;
    }
  }
}
 
//draws rightPaddle
void drawRightPaddle() {
  fill(paddleColor);
  rect(p2.x, p2.y, rightPaddleW, rightPaddleH);
}
 
//moves rightPaddle
void moveRightPaddle() {
  if (up) {
    p2.y = p2.y - rightPaddleS;
  }
  if (down) {
    p2.y = p2.y + rightPaddleS;
  }
}
 
//makes rightPaddle not be able to move farther than the top and bottom of screen
void restrictRightPaddle() {
  if (p2.y - rightPaddleH/2 < 0) {
    p2.y = p2.y + rightPaddleS;
  }
  if (p2.y + rightPaddleH/2 > height) {
    p2.y = p2.y - rightPaddleS;
  }
}
 
//makes ball bounce off of rightPaddle
void bounceRightPaddle() {
  if (ballX + ballW/2 > p2.x - rightPaddleW/2 && ballY - ballH/2 < p2.y + rightPaddleH/2 && ballY + ballH/2 > p2.y - rightPaddleH/2) {
    if (speedX > 0) {
      speedX = -speedX;
      score = score + 1;
    }
  }
}
 
//display score
void score() {
  fill(0);
  textSize(40);
  text(score, width/2 + 22, 75);
}
 
//game over screen
void gameOver() {
  if (score == 10) {
    gameOverScreen("You win!", gameOverText);
  }
}
 
 
void gameOverScreen (String text, color c) {
  speedX = 0;
  speedY = 0;
 
  fill(255, 0, 0);
  text("Click to play again", width/2, height/2 + 50);
  fill(c);
  text(text, width/2, height/4);
//if mouse is clicked then game restarts
  if (mousePressed) {
    score = 0;
    speedX = 7;
    speedY = 7;
  }
}
 
//function attaches vertical movement of paddle to up and down arrow keys
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      up = true;
    } else if (keyCode == DOWN) {
      down = true;
    }
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      up = false;
    } else if (keyCode == DOWN) {
      down = false;
    }
  }
}