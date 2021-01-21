Map test = new Map();

int dispWidth;
int dispHeight;

int posx = 550;
int posy = 540;

void setup()
{
  //size(1920, 1080);                        
  background(0);
  test.loadTiles();
  test.loadMap("map.json");
  size(1000, 700);
  surface.setResizable(true);
  
  dispWidth = test.getWidth() * test.getTileSize();
  dispHeight = test.getHeight() * test.getTileSize();
}

void draw() 
{ 
  test.drawMap(posx,posy);
  fill(0);
  rectMode(CENTER);
  rect(width/2.,height/2.,25,25);
}

void keyPressed()
{
  if (key == 119 && posy > 0 + test.getTileSize()/2) // W
  {
    posy -= 5;
  }
  if (key == 97 && posx > 0 + test.getTileSize()/2) // A
  {
    posx -= 5;
  }
  if (key == 100 && posx < dispWidth - test.getTileSize()/2) // D
  {
    posx += 5;
  }
  if (key == 115 && posy < dispHeight - test.getTileSize()/2) // S
  {
    posy += 5;
  }
}
