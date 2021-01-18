Player myPlayer = new Player();

void setup(){
  surface.setResizable(true);
  size(1920,1080);
  background(255,255,255);
  fill(0);
}

void draw(){
  clear();
  background(255,255,255);

  myPlayer.drawMyself();
  myPlayer.pseudoCords();
  myPlayer.move();
  myPlayer.showPlayer(250, 250);
}

void keyPressed(){
  myPlayer.press(int(key));
}

void keyReleased(){
  myPlayer.release(int(key));
}
