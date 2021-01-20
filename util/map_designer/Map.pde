class Map {
  
  String name;
  int id;
  int mapWidth, mapHeight, drawWidth, drawHeight;
  int xOffset;
  
  // 0/0 ist oben links
  int posX = -1;
  int posY = -1;
  
  Tile tiles[][];
  
  Map(String name, int id, int mapWidth, int mapHeight, int drawWidth, int drawHeight, int xOffset) {
    this.name = name;
    this.id = id;
    this.mapWidth = mapWidth;
    this.mapHeight = mapHeight;
    this.drawWidth = drawWidth;
    this.drawHeight = drawHeight;
    this.xOffset = xOffset;
    tiles = new Tile[mapWidth][mapHeight];
  }
  
  void writeJSON() {
    JSONObject json = new JSONObject();
    
    json.setString("name", name);
    json.setInt("id", id);
    json.setInt("width", mapWidth);
    json.setInt("height", mapHeight);
        
    ArrayList<JSONArray> block_arrays = new ArrayList<JSONArray>(); // Liste der koordinaten der blöcke
    ArrayList<String> block_array_names = new ArrayList<String>();  // Liste der Namen
    
    for(int x = 0; x < mapWidth; x++) {
      for(int y = 0; y < mapWidth; y++) {
        Tile cur_tile = tiles[x][y];       
        if(cur_tile != null) {
          
          JSONObject cur_loc = new JSONObject();
          cur_loc.setInt("x", x);
          cur_loc.setInt("y", y);
          
          // wenn noch keine Blöcke im array sind direkt adden
          if(block_arrays.size() == 0) {
            block_arrays.add(new JSONArray());
            block_arrays.get(0).append(cur_loc);
            block_array_names.add(cur_tile.getName());
          }
          
          else {
            
            // JSONArray finden, in dem die gleichen Tiles sind
            int index = -1;
            for(int i = 0; i < block_array_names.size(); i++) {
              if(block_array_names.get(i) == cur_tile.getName()) {
                index = i;
                break;
              }
            }
            // noch nicht vorhanden, block neu adden
            if(index == -1) {
              block_arrays.add(new JSONArray());
              block_arrays.get(block_arrays.size()-1).append(cur_loc);
              block_array_names.add(cur_tile.getName());
            }
            
            // blöcke mit gleichem namen an stelle index schon vorhanden
            else {
              block_arrays.get(index).append(cur_loc);
            }
          }
        }
      }
    }
    
    for(int i = 0; i < block_arrays.size(); i++) {
      json.setJSONArray(block_array_names.get(i), block_arrays.get(i));
    }
    
    saveJSONObject(json, name + ".json" ,"compact");
  }
  
  void set(Tile tile, boolean fill) {
    int x = posX + (mouseX - xOffset) / 50;
    int y = posY + (mouseY / 50);
    if( x >= 0 && y >= 0 && x < mapWidth && y < mapHeight) {
      
      
      if(fill) {
        
        // BUG! funktioniert noch nicht so ganz.. 
        // zeichnet nur nach oben und nach links
        for(int i = 0; i < mapWidth; i++) {
          for(int j = 0; j < mapHeight; j++) {
            if( tiles[i][j] == tiles[x][y]) {
              tiles[i][j] = tile;
            }
          }
        }
      } else {
        tiles[x][y] = tile;
      }
    }
  }
  
  void reset() {
    for(int x = 0; x < mapWidth; x++) {
      for(int y = 0; y < mapHeight; y++) {
        tiles[x][y] = null;
      }
    }
  }
  
  void show() {
    stroke(50);
    for(int x = 0; x < drawWidth / 50; x++) {
      for(int y = 0; y < drawHeight / 50; y++) {
        if(x + posX >= 0 && x + posX < mapWidth && y + posY >= 0 && y + posY < mapHeight) {
          if(tiles[x + posX][y + posY] != null) {
            image(tiles[x + posX][y + posY].getIcon(), xOffset + x*50, y*50, 50,50);
          } else {
            fill(200);
            rect(xOffset + x*50,y*50,50,50);
          }
        } else {
          fill(50);
          rect(xOffset + x*50,y*50,50,50);
        }
      }
    }
  }
  
  void updateKeys() {
    if(keyCode == LEFT && posX >= 0) {
      posX--;
    } else if (keyCode == RIGHT && posX <= mapWidth - drawWidth / 50) {
      posX++;
    } else if (keyCode == UP && posY >= 0) {
      posY--;
    } else if (keyCode == DOWN  && posY <= mapHeight - drawHeight / 50) {
      posY++;
    }
  }
}
