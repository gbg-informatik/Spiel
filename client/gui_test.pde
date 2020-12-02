class MenuButton {

  bool highlighted = false;

  float x,y;
  float width, height, radius;

  MenuButton (float x, y, width, height, radius) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  private bool mouseOnButton(int mouse_x, mouse_y) {
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
  bool clicked(int mouse_x, mouse_y) {
    return mouseOnButton(mouse_x, mouse_y);
  }

}
