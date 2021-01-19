class Toolbar {
 
 float x, y, width, height;
 
 PImage img_fill, img_clear, img_save;

 boolean fill = false;
 boolean reset = false;

 Tile tiles[] = new Tile[30]; 
 int numTiles = 0;
 int selectedTile = 0;
 
 Toolbar(float x, float y, float width, float height) {
   this.x = x;
   this.y = y;
   this.width = width;
   this.height = height;
   
   img_fill = loadImage("icons/fill.png");
   img_clear = loadImage("icons/clear.png");
   img_save = loadImage("icons/save.png");
 }
 
 void addTile(Tile t) {
   tiles[numTiles] = t;
   numTiles++;
 }
  
 Tile getTile() {
   return tiles[selectedTile];
 }
 
 void show() {
   fill(220);
   noStroke();
   rect(x,y,width, height);
   
   if(fill) {
     fill(250);
     rect(2,2,46,46,6);
   }
   
   if(reset) {
     fill(250);
     rect(2,52,46,46,6);
   }
   
   // show fill/clear/save buttons 
   image(img_fill, 5, 5, 40,40);
   image(img_clear, 5, 55, 40,40);
   image(img_save, 5, 105, 40, 40);
   
   // display tile icons
   for(int t = 0; t < numTiles; t++) {
     image(tiles[t].getIcon(), 5, t*50 + 155, 40,40);
   }
   
   // rect around selected tile
   noFill();
   stroke(255, 0, 0);
   rect(2, 152 + selectedTile*50, 45, 45, 2);
   
   if(mouseX > 2 && mouseX < 46) {
     
     // show fill title
     if( mouseY > 2 && mouseY < 48) {
       show_info(mouseX + 15, mouseY + 5, "Fill");
     } 
     
     // show reset title
     else if (mouseY > 52 && mouseY < 98) {
       if(reset) {
         show_info(mouseX + 15, mouseY + 5, "Press enter to confirm, click to abort");
       }
       else {
         show_info(mouseX + 15, mouseY + 5, "Reset");
       }
     }
     // show save title
     if( mouseY > 102 && mouseY < 148) {
       show_info(mouseX + 15, mouseY + 5, "Save");
     } 
     
     // show title of tiles
     else if( mouseY > 145) {
       int nTile = (mouseY - 145) / 50;
       if(nTile < numTiles) show_info(mouseX + 15, mouseY + 5, tiles[nTile].getName());
     }
   }   
 }
 
 void show_info(float x, float y, String text) {
   float tw = textWidth(text);
   stroke(240);
   fill(255);
   rect(x-2, y-2, tw + 4, 19, 3);
   fill(0);
   textSize(15);
   text(text, x, y + 15); 
 }
 
 void updateMouse() {
   // tile clicked
   if(mouseY > 155 && mouseY < 145 + numTiles * 50) {
     selectedTile = (mouseY - 145) / 50;
   }
   
   // Reset clicked
   else if(mouseY > 52 && mouseY < 98) {
     reset = !reset;
   }
   
   // fill clicked
   else if(mouseY > 2 && mouseY < 48) {
     fill = !fill;
   }
   
   else if(mouseY > 102 && mouseY < 148) {
     map.writeJSON();
   }
 }
 
 void updateKeys() {
   if(key == ENTER && reset) {
     map.reset();
     reset = false;
   }
 }
}
