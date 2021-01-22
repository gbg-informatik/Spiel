// Map variable erstellen 
Map test = new Map();

int dispWidth;
int dispHeight;

int posx = 550;
int posy = 540;

boolean wKey = false;
boolean aKey = false;
boolean sKey = false;
boolean dKey = false;

void setup()
{                    
  background(0);
  size(1000, 700);
  surface.setResizable(true);
  
  // dateien der Tiles laden
  test.loadTiles();
  // Map datei laden
  test.loadMap("map.json");
  
  dispWidth = test.getWidth() * test.getTileSize();
  dispHeight = test.getHeight() * test.getTileSize();
}

void draw() 
{ 
  // update keys
  
  if (wKey && posy > 0 + test.getTileSize()/2) // W
  {
    posy -= 5;
  }
  if (aKey && posx > 0 + test.getTileSize()/2) // A
  {
    posx -= 5;
  }
  if (dKey && posx < dispWidth - test.getTileSize()/2) // D
  {
    posx += 5;
  }
  if (sKey && posy < dispHeight - test.getTileSize()/2) // S
  {
    posy += 5;
  }
    
  // Map zseichnen anhand der Spielerposition, spieler in der Mitte
  test.drawMap(posx,posy);
  
  // Spieler Platzhalter
  fill(0);
  rectMode(CENTER);
  rect(width/2.,height/2.,25,25);  
}

// keyPressed verursacht lags, wenn die Koordinatenabfrage da drin stattfindet, deshalb oben in draw() und mit boolean
void keyPressed()
{
 if (key == 119) { // W
   wKey = true;
 }
 
 if (key == 97) { // A
   aKey = true;
 }  
 
 if (key == 100) // D
  {
    dKey = true;
  }
  if (key == 115) // S
  {
    sKey = true;
  }   
}

void keyReleased()
{
 if (key == 119) { // W
   wKey = false;
 }
 
 if (key == 97) { // As
   aKey = false;
 }  
 
 if (key == 100) // D
  {
    dKey = false;
  }
  if (key == 115) // S
  {
    sKey = false;
  }   
}
