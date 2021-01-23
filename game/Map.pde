class Map
{
  // Tiles einlesen
  int numTiles = 7;
  String gPath = "graphics/map/";
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
  int tileSize;
  
  
  Map(String filename, int tileSize) {
    this.tileSize = tileSize;
    // dateien der Tiles laden
    loadTiles();
  // Map datei laden
    loadMap(filename);
  }
  

  // tiles einlesen
  void loadTiles() {
    for (int i = 0; i < numTiles; i++) {
      tiles[i] = new Tile(tileNames.get(i), i, gPath + tileImageNames[i], tileSize);
    }
  }

  // map aus json einlesen
  void loadMap(String filename) {
    // .json einlesen
    JSONObject json_map = loadJSONObject( "../maps/" + filename);

    // Rastergröße aus .json auslesen 
    mapWidth = json_map.getInt("width");
    mapHeight = json_map.getInt("height");

    // Raster initialisieren
    map = new Tile[mapWidth][mapHeight];

    // Alle Tiles in Raster einfügen
    for (String name : tileNames) {
      JSONArray arr = json_map.getJSONArray(name);
      if (arr == null) continue;
      for (int i = 0; i < arr.size(); i++) {
        JSONObject pos = arr.getJSONObject(i);
        map[pos.getInt("x")][pos.getInt("y")] = tiles[tileNames.index(name)];
      }
    }
  }

  void drawMap(PVector pos) {
    drawMap((int)pos.x, (int)pos.y);
  }

  // map zeichnen
  void drawMap(int posX, int posY)    // posX / posY steht für den Bildmittelpunkt der Map / Spieler in der Mitte des Displays
  {
    // Verschiebung des Bildausschnittes auf der Map
    double drawOffsetX = (posX - (width / 2.));
    double drawOffsetY = (posY - (height / 2.));

    // x/y index der oberen linken Kachel im Bild berechnen.
    int tileOffsetX = (int) ( drawOffsetX / tileSize ) ;
    int tileOffsetY = (int) (drawOffsetY / tileSize );

    // Verschiebung der Kacheln, damit die Map unter dem Spieler smooth läuft und er nicht von Kachel zu Kachel "springt" 
    int addX = (int)(drawOffsetX % tileSize);
    int addY = (int )(drawOffsetY % tileSize);
    int drawX, drawY;

    // Alle Tiles im Bildausschnitt Zeichnen
    for (int x = -1; x < width / tileSize + 2; x++) {
      for (int y = -1; y < height / tileSize + 2; y++) {

        // Position der Tile / Kachel berechnen
        drawX = x*tileSize - addX;
        drawY = y*tileSize - addY;

        // Wenn x/y + tileOffsetX/Y sich innerhalb des Rasters befindet und Bild vorhanden -> Bild zeichnen
        if (x + tileOffsetX >= 0 && x + tileOffsetX < mapWidth && y + tileOffsetY >= 0 && y + tileOffsetY < mapHeight && map[x + tileOffsetX][y + tileOffsetY] != null) {
          image(map[x + tileOffsetX][y + tileOffsetY].getIcon(), drawX, drawY);

          // Sonst ist die Kachel außerhalb des Rasters/ der Map -> Rand zeichnen
          /*} else {
           rectMode(CORNER);
           fill(50);
           rect(drawX ,drawY ,50,50);*/
        }
      }
    }
  }

  int collisionDetection(PVector pos, float pSize){  //l;  lo;  o;  ro;  r;  ru;  u;  lu    (only first eight bits of byte get used)
    int returnByte = 255;                            //0;   1;  2;   3;  4;   5;  6;   7

    //--Edge of Map--------
    if(pos.x-pSize/2 <= 0){    //left edge of map
      returnByte = changeBit(returnByte, 0, 0);        //input byte, position, value
    }
    if(pos.x+pSize/2 >= mapWidth*tileSize){    //right edge of map
      returnByte = changeBit(returnByte, 4, 0);        //input byte, position, value    
    }
    if(pos.y-pSize/2 <= 0){    //top edge of map
      returnByte = changeBit(returnByte, 2, 0);        //input byte, position, value    
    }
    if(pos.y+pSize/2 >= mapHeight*tileSize){    //bottom edge of map
      returnByte = changeBit(returnByte, 6, 0);        //input byte, position, value    
    }
    
    return returnByte;
  }

  int changeBit(int input, int pos, int val){
    int mask = 1 << pos;
    return (input & ~mask) | ((val << pos) & mask);
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
