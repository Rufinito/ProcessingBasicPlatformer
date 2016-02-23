//key vars
Boolean keyUp = false;
Boolean keyLeft = false;
Boolean keyRight = false;

//other vars
PVector pos = new PVector (50, 200);

float a = 0.1;  //acceleration
PVector targetSpeed = new PVector (4, 4);
PVector currSpeed = new PVector (0, 0);
float threshold = 0.1;

Boolean jumping = false;
float startY = pos.y;
float jumpSpeed = 0;

void setup()
{
  //setup the window size
  size(800, 250);
  frameRate(60);
}

void draw()
{
  background(255);
  fill(0);
  smooth();
  noStroke();
  ellipse(pos.x, pos.y, 10, 10);
  
  update();
}

void update()
{

  //get key states and set x speed according to them
  if (keyRight)
    targetSpeed.x = 5;
  if (keyLeft)
    targetSpeed.x = -5;
  if (!keyLeft && !keyRight)
    targetSpeed.x = 0;

  //movement physics 
  targetSpeed.mult(a);
  currSpeed.mult( 1- a);
  currSpeed.add(targetSpeed);

  //make sure to stay within the threshold (not go under 0)
  if (abs(currSpeed.x) < threshold)
    currSpeed.y = 0;
  if (abs(currSpeed.y) < threshold)
    currSpeed.y = 0;

  //set calculated values to the actual position
  PVector newPos = new PVector (pos.x, pos.y);
  newPos.add(currSpeed);

  pos = new PVector(newPos.x, newPos.y);

  //call the jump function
  ajump();
}

void ajump()
{
  //concept from here: http://flatformer.blogspot.ca/2010/02/making-character-jump-in-xnac-basic.html

  if (jumping)
  {

    pos.y += jumpSpeed;
    jumpSpeed +=1;

    if (pos.y >= startY)
    {
      pos.y = startY;
      jumping = false;
    }
  } else
  {
    if (keyUp)
    {
      jumping = true;
      jumpSpeed = -10;
    }
  }
}


void keyPressed()
{
  if (keyCode == UP) keyUp = true;
  if (keyCode == RIGHT) keyRight = true;
  if (keyCode == LEFT) keyLeft = true;
}

void keyReleased()
{
  if (keyCode == UP) keyUp = false;
  if (keyCode == RIGHT) keyRight = false;
  if (keyCode == LEFT) keyLeft = false;
}