class Map
{
  int numTiles = 7;
  String gPath = "../graphics/map/";
  StringList tileNames = new StringList(new String [] {"boden", "mauer", "lava", "wasser", "buton", "coop_a", "coop_b"});
  String tileImageNames[] = {"Boden.png", "MauerEinzel.png", 
                            "LavaKreuzung.png", "WasserKreuzung.png",
                            "Button.png", "CoOp-A.png", "CoOp-B.png"};
  Tile tiles[] = new Tile[numTiles];
  
  Tile map[][];
  
  int mapWidth, mapHeight;
  
  void loadTiles() {
    for(int i = 0; i < numTiles; i++) {
      tiles[i] = new Tile(tileNames.get(i), i, gPath + tileImageNames[i]);      
    }
  }
  
 
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
  
  void drawMap(int x, int y)
  {
    clear();
    kachelx = floor((x-12*75)/75);
    kachely = floor((y-7*75)/75);
    for (int i = 0; i < mapWidth; i++)
    {
      for (int j = 0; j < mapHeight; j++)
      {
        if( kachelx + i < mapWidth && kachely+j < mapHeight && map[kachelx+i][kachely+j] != null) {
          image( map[kachelx+i][kachely+j].getIcon() ,i*75-posx%75,j*75-posy%75);
        }
        //fill(150);
        //rect(i*75 - x%75, j*75 - y%75, 75, 75);
      }
    } 
  }
}
