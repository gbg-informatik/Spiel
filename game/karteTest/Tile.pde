public class Tile {
  private int id;
  private String name;
  private String filepath;
  private PImage icon;
  private int tileSize;
  
  Tile(String name, int id, String filepath, int tileSize) {
    this.name = name;
    this.id = id;
    this.filepath = filepath;
    this.tileSize = tileSize;
    loadIcon();
  }
  
  void loadIcon() {
    icon = loadImage(filepath);
    icon.resize(tileSize,tileSize);
  }
  
  String getName() {
    return name;
  }
  
  int getId() {
    return id;
  }
  
  PImage getIcon() {
    return icon;
  }
}
