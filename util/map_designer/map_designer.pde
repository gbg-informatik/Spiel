
Toolbar toolbar;

void setup() {
  size(1280, 720);
  
  Tile sand = new Tile("sand", 0, "sand.png");
  toolbar = new Toolbar(0,0, 50, 500);
  toolbar.addTile(sand);
  
}

void draw() {
  
  toolbar.show();
  
}


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

static final int EDIT = 0;
static final int DELETE = 1;

class Toolbar {
 
 PImage img_delete;
 PImage img_edit;
 
  
 Tile tiles[] = new Tile[30]; 
 int numTiles = 0;
 float x, y, width, height;
 int mode = EDIT;
 
 Toolbar(float x, float y, float width, float height) {
   this.x = x;
   this.y = y;
   this.width = width;
   this.height = height;
   
   img_edit = loadImage("icons/edit.png");
   img_delete = loadImage("icons/delete.png");
 }
 
 void addTile(Tile t) {
   tiles[numTiles] = t;
   numTiles++;
 }
  
 void show() {
   fill(220);
   noStroke();
   rect(x,y,width, height);
   
   if(mode == EDIT) {
     fill(250);
     rect(2,2,46,46,6);
   } else {
     fill(250);
     rect(2,52,46,46,6);
   }
   
   image(img_edit, 5, 5, 40,40);
   image(img_delete, 5, 55, 40,40);
   
   for(int t = 0; t < numTiles; t++) {
     image(tiles[t].getIcon(), 5, t*50 + 105, 40,40);
   }
 }
 
 void setMode(int mode) {
   switch(mode) {
     case EDIT:
       this.mode = EDIT;
       break;
     case DELETE:
       this.mode = DELETE;
       break;
     default:
       this.mode = EDIT;
   }
 }
}
