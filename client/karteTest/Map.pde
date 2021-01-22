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
      tiles[i] = new Tile(tileNames.get(i), i, gPath + tileImageNames[i]);      
    }
  }
  
  // map aus json einlesen
  void loadMap(String filename) {
    JSONObject json_map = loadJSONObject(filename);
    
    mapWidth = json_map.getInt("width");
    mapHeight = json_map.getInt("height");
    
    map = new Tile[mapWidth][mapHeight];
    
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
    
    // x/y index der oberen linken Kachel im Bild berechnen.
    double _offsetX = ((posX - (width / 2.)) / tileSize);
    double _offsetY = (posY - (height / 2.)) / tileSize;
    
    int offsetX = _offsetX < 0 && _offsetX % 1 != 0 ? ((int)(_offsetX - 1)) : (int) _offsetX;
    int offsetY = _offsetY < 0 ? ((int)(_offsetY - 0.5)) : (int) _offsetY;
    
    print("tl "); print(posX - (width / 2.));
    print("/ offsx "); print(_offsetX); print("/ "); print(offsetX);
    print("/ offsy "); print(_offsetY); print("/ "); print(offsetY);
    print("/ posx "); print(posX);
    print("/ posY "); print(posY);
    print("/ %X ");  print(posX % tileSize);
    print("/ %Y ");  print(posY % tileSize);
    
    print("/ drawX "); print(0*50 - posX % tileSize);
    print("/ drawX "); println(0*50 - posY % tileSize);
    
    // Alle Tiles im Bildausschnitt Zeichnen
    for(int x = -1; x < width / 50 + 1; x++) {
      for(int y = -1; y < height / 50 + 1; y++) {       
        
        // Position der Tile / Kachel berechnen
        int drawX = x*50 - posX % tileSize + ((width / 2) % 50);
        int drawY = y*50 - posY % tileSize + ((height /2)  % 50);
                
        // drawX/Y korrigieren, da sonst wenn (posX/Y - width/2) < 0 die Kacheln nach links versetzt sind, wenn posX/Y % tileSize(50) != 0.
        // Liegt irgendwie am Modulo oder Teilen mit negativen Zahlen. Vielleicht weil: 1.23 -> 1 (nach links verschoben)  und  -1.23 -> -1 (nach rechts verschoben)
       // if(posX - (width / 2.) < 0 && (posX % 50) != 0) drawX += 50;
       // if(posY - (height / 2.) < 0 && (posY % 50) != 0) drawY += 50;
        
        // Wenn x/y + offsetX/Y sich innerhalb des Rasters befindet und Bild vorhanden -> Bild zeichnen
        if(x + offsetX >= 0 && x + offsetX < mapWidth && y + offsetY >= 0 && y + offsetY < mapHeight && map[x + offsetX][y + offsetY] != null) {
          image(map[x + offsetX][y + offsetY].getIcon(), drawX, drawY, 50,50);
        
        // Sonst ist die Kachel außerhalb des Rasters/ der Map -> Rand zeichnen
        } else {
          rectMode(CORNER);
          fill(50);
          rect(drawX ,drawY ,50,50);
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
