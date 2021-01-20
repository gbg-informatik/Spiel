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
  void drawMap(int posX, int posY)    // x / y steht für die Spielerposition auf der Map
  {
    clear();
    int kachelx = (int)(posX - (width / 2.)) / tileSize;
    int kachely = (int)(posY - (height / 2.)) / tileSize;
    
    
    print("tl "); print(posX - (width / 2.));
    print("/ kachx "); print(kachelx);
    print("/ kachy "); print(kachely);
    print("/ posx "); print(posX);
    print("/ posY "); print(posY);
    print("/ %X ");  print(posX % tileSize);
    print("/ %Y ");  println(posY % tileSize);
    
    for(int x = -1; x < width / 50 + 1; x++) {
      for(int y = -1; y < height / 50 +1; y++) {       
        int drawX = x*50 - posX % tileSize;
        int drawY = y*50 - posY % tileSize;
        if(posX - (width / 2.) < 0 && (posX % 50) != 0) drawX += 50;
        if(posY - (height / 2.) < 0 && (posY % 50) != 0) drawY += 50;
           
        
        if(x + kachelx >= 0 && x + kachelx < mapWidth && y + kachely >= 0 && y + kachely < mapHeight && map[x + kachelx][y + kachely] != null) {
          image(map[x + kachelx][y + kachely].getIcon(), drawX, drawY, 50,50);
        } else {
          rectMode(CORNER);
          fill(50);
          rect(drawX ,drawY ,50,50);
        }
      }
    }
    
    
    
    
    
    
    
    //                   ( positionX - (nPixel über spieler) ) / kachelgröße -> Nachkommastellen streichen 
    // ***********  ********************
    //* ----------  -------------------*
    //*-----------  -------------------*
    //*-----------  -------------------*
    
    /*for (int x = 0; x < width / tileSize + 2; x++)
    {
      for (int y = 0; y < height / tileSize + 2; y++)
      {
        if( ( kachelx + x >= 0 ) && ( kachely + y >= 0 ) && ( kachelx + x < mapWidth ) && ( kachely+y < mapHeight ) && ( map[kachelx + x][kachely + y] != null) ) {
          int drawX = x * tileSize - posX % tileSize;
          int drawY = y * tileSize - posY % tileSize;       
          
          image( map[kachelx + x][kachely + y].getIcon(), drawX, drawY, tileSize, tileSize);
        } else {
          
        }
        //fill(150);
        //rect(i*75 - x%75, j*75 - y%75, 75, 75);
      }
    }*/
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
