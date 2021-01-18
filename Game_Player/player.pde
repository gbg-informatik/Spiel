class Player{
  //Button Press
  int aMov=0;
  int dMov=0;
  int sMov=0;
  int wMov=0;
  //Move Int
  int xMov=0;
  int yMov=0;

  //Cords n Movement Length
  float xCord = 0;
  float yCord = 0;
  float diagonalMove = sqrt(12.5);
  
  //Box OffSet from Cord
  int xOffset = 50;
  int yOffset = 50;

  int pressed;
  int released;  
  
  void drawMyself(){
    rect((width/2)-(xOffset/2),(height/2)-(yOffset/2),xOffset,yOffset);
    //rect(xCord, yCord, 50, 50); //- WATCH ME MOVE
  }
  
  void pseudoCords(){
    text(xCord, 20, 20);
    text(yCord, 20, 40);
  }
  
  void press(int _input){
    pressed = _input;
    switch(pressed){
      case 97:
        aMov = -1;
        break;
        
      case 100:
        dMov = 1;
        break;
        
      case 115:
        sMov = 1;
        break;
        
      case 119:
        wMov = -1;
        break;
      
      default:
        println("UNKNOWN PRESS");
    }
  }
  
  void release(int _input){
    released = _input;
    switch(released){
      case 97:
        aMov = 0;
        break;
        
      case 100:
        dMov = 0;
        break;
        
      case 115:
        sMov = 0;
        break;
        
      case 119:
        wMov = 0;
        break;
      
      default:
        println("Release");
    }
  }
  
  void move(){
    yMov = wMov+sMov;
    xMov = aMov+dMov;
    if(xMov != 0 && yMov == 0){
      xCord += 5*xMov;
    }
    
    if(xMov == 0 && yMov != 0){
      yCord += 5*yMov;
    }
    
    if(xMov != 0 && yMov != 0){
      yCord += diagonalMove*yMov;
      xCord += diagonalMove*xMov;
    }
  }
  
  void showPlayer(int _x, int _y){
    if(xCordCheck(_x)&&yCordCheck(_y)){
      rect(_x-xCord+935, _y-yCord+515, 50, 50);
    }
  }
  
  boolean xCordCheck(int _x){
    if(_x>(xCord-1000) && _x<(xCord+1000)){
      return true;
    }
    else{
      return false;
    }
  }
  
  boolean yCordCheck(int _y){
    if(_y>(yCord-580) && _y<(yCord+580)){
      return true;
    }
    else{
      return false;
    }
  }
}
