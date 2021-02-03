class Player {
  //Button Press
  int aMov=0;
  int dMov=0;
  int sMov=0;
  int wMov=0;

  //Cords n Movement Length
  PVector globalCords;
  PVector localCords;  

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
    int collisions = map.collisionDetection(globalCords,tileSize);
    //println("Collisions: " + binary(collisions,8));
    
    PVector finMove = new PVector(aMov+dMov,wMov+sMov);
    
    if(getBit(collisions,0) == 0 && finMove.x < 0){  //a
      finMove.x += 1;
    }
    if(getBit(collisions,2) == 0 && finMove.y < 0){  //w
      finMove.y += 1;
    }
    if(getBit(collisions,4) == 0 && finMove.x > 0){  //d
      finMove.x += -1;
    }
    if(getBit(collisions,6) == 0 && finMove.y > 0){  //s
      finMove.y += -1;
    }
    
    // Wenn das Fenster nicht mehr angewählt ist die Bewegung reseten, da sich der Spieler sonst dauerhaft bewegt
    if(!focused) {
      finMove = new PVector(0,0);
      wMov = 0;
      aMov = 0;
      sMov = 0;
      dMov = 0;
    }
    
    globalCords.add(finMove.setMag(5));
  }

  void show() {
    fill(col);
    //rect(localCords.x+width/2-tileSize, localCords.y+height/2-tileSize, 50, 50);
    //image(body,localCords.x+width/2 - tileSize/2, localCords.y+height/2 - tileSize/2, tileSize, tileSize);
    ellipse(localCords.x + width/2,localCords.y +height/2,tileSize,tileSize);
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
  
  byte getBit(int input, int pos){
    return byte((input >> pos) & 1);
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
