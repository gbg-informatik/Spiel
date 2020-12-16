

guiButton menujoin = new guiButton(20,20,100,30,2);

void setup() {
  size(640, 360);
  
}

void draw() {
  background(255);
  menujoin.updateMouse(mouseX, mouseY);
  menujoin.show();
}


class guiButton {

  boolean highlighted = false;

  float x, y;
  float width, height, radius;

  guiButton (float x, float y, float width, float height, float radius) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.radius = radius;
  }

  private boolean mouseOnButton(int mouse_x, int mouse_y) {
    return mouse_x > x && mouse_x < x + width && mouse_y > y && mouse_y < y + height;
  }

  void updateMouse(int mouse_x, int mouse_y) {
    if( mouseOnButton(mouse_x, mouse_y) ) {
      highlighted = true;
    } else {
      highlighted = false;
    }
  }

  void show() {
    rectMode(CORNER);

    if(highlighted) {
      fill(170);
    } else {
      fill(150);
    }
    rect(x, y, width, height, radius);
  }

  // gibt true zurück, wenn der Button mit der Maus angeklickt wurde
  boolean clicked(int mouse_x, int mouse_y) {
    return mouseOnButton(mouse_x, mouse_y);
  }

}
