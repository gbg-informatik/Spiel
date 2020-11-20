Map test = new Map();
int posx = 960;
int posy = 540;
int kachelx, kachely;

void setup()
{
  size(1920, 1080);                        
  background(0);
  test.fillMap();
}

void draw() 
{ 
  test.drawMap(posx,posy);
  fill(0);
  rect(960,540,25,25);
}

void keyPressed()
{
  if (key == 119 && posy > 540) // W
  {
    posy -= 10;
  }
  if (key == 97 && posx > 960) // A
  {
    posx -= 10;
  }
  if (key == 100 && posx < 2690) // D
  {
    posx += 10;
  }
  if (key == 115 && posy < 3140) // S
  {
    posy += 10;
  }
  
}
