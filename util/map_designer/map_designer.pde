
Toolbar toolbar;
Map map;

void setup() {
  
  size(1280, 720);
  String gPath = "../../client/graphics/map/";
  Tile boden = new Tile("boden", 0, gPath + "Boden.png");
  Tile wall = new Tile("mauer", 1, gPath + "MauerEinzel.png");
  Tile lava = new Tile("lava", 2, gPath + "LavaKreuzung.png");
  Tile water = new Tile("wasser", 3, gPath + "WasserKreuzung.png");
  Tile button = new Tile("button", 4, gPath + "Button.png");
  Tile coop_a = new Tile("coop_a", 5, gPath + "CoOp-A.png");
  Tile coop_b = new Tile("coop_b", 6, gPath + "CoOp-B.png");
  
  Tile beschleunigung = new Tile("beschleunigung", 7, gPath + "Accelerator.png");
  Tile abbremsung = new Tile("abbremsung", 8, gPath + "Deceleration.png");
  Tile electricfloor = new Tile("electricfloor", 9, gPath + "Electric Floor.png");
  Tile hiddendoor = new Tile("hidden door", 10, gPath + "Hidden door; open.png");
  Tile horgan = new Tile("horgan", 11, gPath + "Horgan.png");
  Tile mine = new Tile("mine", 12, gPath + "Mine; sichtbar.png");
  Tile mysteryobject = new Tile("mysteryobject", 13, gPath + "Mystery object.png");
  Tile schlange = new Tile("schlange", 14, gPath + "Schlange.png");
  Tile treibsand = new Tile("treibsand", 15, gPath + "Treibsand.png");
  
  toolbar = new Toolbar(0,0, 50, height);
  toolbar.addTile(boden);
  toolbar.addTile(wall);
  toolbar.addTile(lava);
  toolbar.addTile(water);
  toolbar.addTile(button);
  toolbar.addTile(coop_a);
  toolbar.addTile(coop_b);
  
  toolbar.addTile(beschleunigung);
  toolbar.addTile(abbremsung);
  toolbar.addTile(hiddendoor);
  toolbar.addTile(horgan);
  toolbar.addTile(mine);
  toolbar.addTile(mysteryobject);
  toolbar.addTile(schlange);
  toolbar.addTile(treibsand);
  
  
  map = new Map("map", 0, 50, 50, width-50, height, 50);
}

void draw() {
  background(200);
  map.show();
  toolbar.show();
  
  if(mousePressed && mouseButton == LEFT && mouseX > 50) {
    map.set(toolbar.getTile(), toolbar.getFill());
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
