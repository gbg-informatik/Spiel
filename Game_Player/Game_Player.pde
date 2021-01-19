import java.io.*; 
import java.net.*; 
import java.util.Scanner; 

Player players[];
Client c;
int id, playercount = 1;

void setup(){
  surface.setResizable(true);
  //fullScreen();
  size(300,300);  //1920,1080
  //--Set up Client-------------
  c = new Client();
  try {
    c.startClient();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  //--Initialise Players--------
  players = new Player[playercount];
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))));
  }

  background(255);
  fill(0);

  println("Setup done");
}

void draw(){
  clear();
  background(255,255,255);

  clear();
  try {
    println("sending");
    c.sendPosition();
    c.reciveData();
  }
  catch(Exception e) { 
    e.printStackTrace();
  }
  for (int i = 0; i < players.length; i++) {
    players[i].drawMyself();
  }
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
