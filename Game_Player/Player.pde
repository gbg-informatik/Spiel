class Player {
  //Button Press
  int aMov=0;
  int dMov=0;
  int sMov=0;
  int wMov=0;
  //Move Int
  int xMov=0;
  int yMov=0;

  //Cords n Movement Length
  PVector globalCords;
  PVector localCords;
  
  float diagonalMove = sqrt(12.5);

  //Box OffSet from Cord
  int xOffset = 50;
  int yOffset = 50;
  color col = color(0);

  Player(PVector p, color c){
    globalCords = new PVector(p.x,p.y);
    localCords = new PVector(0,0);
    col = c;
  }
  
  void globalToLocal(PVector pPos){
    localCords = new PVector(-pPos.x+globalCords.x,-pPos.y+globalCords.y);      // globale Koordinaten werden zu lokalen umgerechnet
  }

  void showPlayer() {
    fill(col);
    rect((width/2)-(xOffset/2), (height/2)-(yOffset/2), xOffset, yOffset);
  }

  void pseudoCords() {
    text(globalCords.x, 20, 20);
    text(globalCords.y, 20, 40);
  }

  void press(char _input) {
    switch(_input) {
    case 'a':
      aMov = -1;
      break;

    case 'd':
      dMov = 1;
      break;

    case 's':
      sMov = 1;
      break;

    case 'w':
      wMov = -1;
      break;

    default:
      println("UNKNOWN PRESS: " + _input);
    }
  }

  void release(char _input) {
    switch(_input) {
    case 'a':
      aMov = 0;
      break;

    case 'd':
      dMov = 0;
      break;

    case 's':
      sMov = 0;
      break;

    case 'w':
      wMov = 0;
      break;

    default:
      println("Release");
    }
  }

  void move() {
    yMov = wMov+sMov;
    xMov = aMov+dMov;
    if (xMov != 0 && yMov == 0) {
      globalCords.x += 5*xMov;
    }

    if (xMov == 0 && yMov != 0) {
      globalCords.y += 5*yMov;
    }

    if (xMov != 0 && yMov != 0) {
      globalCords.y += diagonalMove*yMov;
      globalCords.x += diagonalMove*xMov;
    }
  }

  void show() {
    fill(col);
    rect(localCords.x+width/2-xOffset, localCords.y+height/2-yOffset, 50, 50);
  }

  boolean xCordCheck(float _x) {
    if (_x>(localCords.x-width/2-xOffset) && _x<(localCords.x+width/2+xOffset)) {
      return true;
    } else {
      return false;
    }
  }

  boolean yCordCheck(float _y) {
    if (_y>(localCords.y-height/2-yOffset) && _y<(localCords.y+height/2+yOffset)) {
      return true;
    } else {
      return false;
    }
  }
  
  
  //--Client Stuff--------
  String getPosition() {
    String position = "";
    position += globalCords.x + ";" + globalCords.y;
    return(position);
  }
  
  void changePosition(float x, float y) {
    globalCords.x = x;
    globalCords.y = y;
  }

}
