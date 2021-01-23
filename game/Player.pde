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
  int tileSize;

  //Display
  color col = color(0);
  PImage body;

  Player(PVector p, color c, int id, int tileSize_){
    globalCords = new PVector(p.x,p.y);
    localCords = new PVector(0,0);
    col = c;
    body = getBody(id);
    tileSize = tileSize_;
  }
  
  void globalToLocal(PVector pPos){
    localCords = new PVector(-pPos.x+globalCords.x,-pPos.y+globalCords.y);      // globale Koordinaten werden zu lokalen umgerechnet
  }

  void showPlayer() {
    //fill(col);
    //rect((width/2)-(tileSize/2), (height/2)-(tileSize/2), tileSize, tileSize);
    image(body,(width/2)-(tileSize/2), (height/2)-(tileSize/2), tileSize, tileSize);
  }

  void showCords() {
    fill(0);
    text("global", 10, 20);
    text(globalCords.x, 10, 40);
    text(globalCords.y, 10, 60);
    text("local", 10, 80);
    text(localCords.x, 10, 100);
    text(localCords.y, 10, 120);
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
    //fill(col);
    //rect(localCords.x+width/2-tileSize, localCords.y+height/2-tileSize, 50, 50);
    image(body,localCords.x+width/2 - tileSize/2, localCords.y+height/2 - tileSize/2, tileSize, tileSize);
  }
  
  PImage getBody(int id){
    String dir = "graphics/player/";
    switch(id){
      case 0:   dir += "Blau-A.png";   break;
      case 1:   dir += "Blau-B.png";   break;
      case 2:   dir += "Gruen-A.png";  break;
      case 3:   dir += "Gruen-B.png";  break;
      case 4:   dir += "Mocha-A.png";  break;
      case 5:   dir += "Mocha-B.png";  break;
      case 6:   dir += "Lila-A.png";   break;
      case 7:   dir += "Lila-B.png";   break;
      case 8:   dir += "Orange-A.png"; break;
      case 9:   dir += "Orange-B.png"; break;
      case 10:  dir += "Ersatz-A.png"; break;
      default:  dir += "Ersatz-B.png"; break;
    }
    println("dir: " + dir);
    return loadImage(dir);
  }
  
  PVector getPos(){
    return globalCords;
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
