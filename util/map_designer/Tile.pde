public class Tile {
  private int id;
  private String name;
  private String filepath;
  private PImage icon;
  
  Tile(String name, int id, String filepath) {
    this.name = name;
    this.id = id;
    this.filepath = filepath;
    loadIcon();
  }
  
  void loadIcon() {
    icon = loadImage(filepath);
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
