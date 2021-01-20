import java.io.*; 
import java.net.*; 
import java.util.Scanner; 

Player players[];
Client c;
int id, playercount = 1;

void setup() {
  surface.setResizable(true);
  fullScreen();
  //xsize(300, 300);  //1920,1080
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
    colorMode(HSB, 360,100,100);
    players[i] = new Player(new PVector(width/2, height/2), color(noise(i)*360,noise(i)*10+90,noise(i+5)*10+90));
    colorMode(RGB, 255,255,255);
  }

  background(255);
  fill(0);

  println("Setup done");
}

void draw() {
  clear();
  background(255);
  try {
    println("sending");
    c.sendPosition();
    c.reciveData();
  }
  catch(Exception e) { 
    e.printStackTrace();
  }
  for (int i = 0; i < players.length; i++) {
    if (i != id) {
      players[i].globalToLocal(players[id].globalCords);
      players[i].move();
      players[i].show();
    }
  }  
  players[id].move();
  players[id].pseudoCords();
  players[id].showPlayer();
}

void keyPressed() {
  if (key != 'x' && key != 'X') {
    players[id].press(key);
  } else {
    try {
      c.send("Exit");
    } 
    catch(Exception e) { 
      e.printStackTrace();
    }
  }
}

void keyReleased() {
  if (key != 'x' && key != 'X') {
    players[id].release(key);
  } else {
    try {
      println("EXIT");
      c.send("Exit");
    } 
    catch(Exception e) { 
      e.printStackTrace();
    }
  }
}
