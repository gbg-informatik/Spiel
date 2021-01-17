class Player {
  PVector pos;
  color c;

  Player(color c_) {
    pos = new PVector(width/2, height/2);
    c = c_;
  }

  void show() {
    fill(c);
    circle(pos.x, pos.y, width/10);
  }

  void update(char k) {
    switch(k) {
    case 'w':
      if (pos.y < height)
        pos.y -= 10;
      break;
    case 's':
      if (pos.y > 0)
        pos.y += 10;
      break;
    case 'd':
      if (pos.x < width)
        pos.x += 10;
      break;
    case 'a':
      if (pos.x > 0)
        pos.x -= 10;
      break;
    }
  }
  
  String getPosition() {
    String position = "";
    position += pos.x + ";" + pos.y;
    return(position);
  }
  
  void changePosition(float x, float y) {
    pos.x = x;
    pos.y = y;
  }
}
