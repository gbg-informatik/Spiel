class Map
{
  // Tiles einlesen
  int numTiles = 7;
  String gPath = "../graphics/map/";
  StringList tileNames = new StringList(new String [] {"boden", "mauer", "lava", "wasser", "buton", "coop_a", "coop_b"});
  String tileImageNames[] = {"Treibsand.png", "MauerEinzel.png", 
                            "LavaKreuzung.png", "WasserKreuzung.png",
                            "Button.png", "CoOp-A.png", "CoOp-B.png"};
                            
  // eingelesene Tiles
  Tile tiles[] = new Tile[numTiles];
  
  // Raster, das aus Tiles besteht
  Tile map[][];
  
  // größe des Rasters
  int mapWidth, mapHeight;
  int tileSize = 50;
  
  // tiles einlesen
  void loadTiles() {
    for(int i = 0; i < numTiles; i++) {
      tiles[i] = new Tile(tileNames.get(i), i, gPath + tileImageNames[i], tileSize);      
    }
  }
  
  // map aus json einlesen
  void loadMap(String filename) {
    // .json einlesen
    JSONObject json_map = loadJSONObject(filename);
    
    // Rastergröße aus .json auslesen 
    mapWidth = json_map.getInt("width");
    mapHeight = json_map.getInt("height");
    
    // Raster initialisieren
    map = new Tile[mapWidth][mapHeight];
    
    // Alle Tiles in Raster einfügen
    for(String name : tileNames) {
      JSONArray arr = json_map.getJSONArray(name);
      if(arr == null) continue;
      for(int i = 0; i < arr.size(); i++) {
        JSONObject pos = arr.getJSONObject(i);
        map[pos.getInt("x")][pos.getInt("y")] = tiles[tileNames.index(name)];
      }
    }
  }
  
  // map zeichnen
  void drawMap(int posX, int posY)    // posX / posY steht für den Bildmittelpunkt der Map / Spieler in der Mitte des Displays
  {
    clear();
    // Verschiebung des Bildausschnittes auf der Map
    double _offsetX = (posX - (width / 2.));
    double _offsetY = (posY - (height / 2.));
    
    // x/y index der oberen linken Kachel im Bild berechnen.
    int offsetX = (int) ( _offsetX / 50 ) ;
    int offsetY = (int) (_offsetY / 50 );
    
    // Verschiebung der Kacheln, damit die Map unter dem Spieler smooth läuft und er nicht von Kachel zu Kachel "springt" 
    int addX = (int)(_offsetX % 50);
    int addY = (int )(_offsetY % 50);
    int drawX, drawY;
    
    // Alle Tiles im Bildausschnitt Zeichnen
    for(int x = -1; x < width / 50 + 2; x++) {
      for(int y = -1; y < height / 50 + 2; y++) {       
        
        // Position der Tile / Kachel berechnen
        drawX = x*50 - addX;
        drawY = y*50 - addY;
                       
        // Wenn x/y + offsetX/Y sich innerhalb des Rasters befindet und Bild vorhanden -> Bild zeichnen
        if(x + offsetX >= 0 && x + offsetX < mapWidth && y + offsetY >= 0 && y + offsetY < mapHeight && map[x + offsetX][y + offsetY] != null) {
          image(map[x + offsetX][y + offsetY].getIcon(), drawX, drawY);
        
        // Sonst ist die Kachel außerhalb des Rasters/ der Map -> Rand zeichnen
        /*} else {
          rectMode(CORNER);
          fill(50);
          rect(drawX ,drawY ,50,50);*/
        }
      }
    }
  }
  
  int getWidth() {
   return mapWidth; 
  }
  
  int getHeight() {
   return mapHeight; 
  }
  
  int getTileSize() {
    return tileSize;
  }
}
