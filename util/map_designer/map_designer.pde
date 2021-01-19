
Toolbar toolbar;
Map map;

void setup() {
  
  size(1280, 720);
  String gPath = "../../client/graphics/map/";
  Tile boden = new Tile("boden", 1, gPath + "Boden.png");
  Tile wall = new Tile("mauer", 1, gPath + "MauerEinzel.png");
  Tile lava = new Tile("lava", 1, gPath + "LavaKreuzung.png");
  Tile water = new Tile("wasser", 1, gPath + "WasserKreuzung.png");
  Tile button = new Tile("button", 1, gPath + "Button.png");
  Tile coop_a = new Tile("coop_a", 1, gPath + "CoOp-A.png");
  Tile coop_b = new Tile("coop_b", 1, gPath + "CoOp-B.png");
  
  toolbar = new Toolbar(0,0, 50, height);
  toolbar.addTile(boden);
  toolbar.addTile(wall);
  toolbar.addTile(lava);
  toolbar.addTile(water);
  toolbar.addTile(button);
  toolbar.addTile(coop_a);
  toolbar.addTile(coop_b);
  
  map = new Map("map", 0, 20, 20, width-50, height, 50);
}

void draw() {
  background(200);
  map.show();
  toolbar.show();
  
  if(mousePressed && mouseButton == LEFT && mouseX > 50) {
    map.set(toolbar.getTile());
  }
}

void mouseClicked() {
  if(mouseX < 50) {
    toolbar.updateMouse();
  }
}

void keyPressed() {
  if (key == CODED) {
    map.updateKeys();
  }
  toolbar.updateKeys();
  if(key == 's') {
    map.writeJSON();
  }
}
