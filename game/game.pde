import java.io.*; 
import java.net.*; 
import java.util.Scanner; 
import java.lang.Integer;

Player players[];
Client c;
Map map;
int id, playercount = 1;

void setup() {
  size(1280, 720, P2D);  //1920,1080
  surface.setResizable(true);
  //frameRate(60);

  
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
    players[i] = new Player(new PVector(width/2, height/2), color(noise(i)*360,noise(i)*10+90,noise(i+5)*10+90),i, 50);
    colorMode(RGB, 255,255,255);
  }

  map = new Map("test.json", 50);
  
  println("Setup done");
}

void draw() {
  clear();
  background(255);
  
  // Map zseichnen anhand der Spielerposition, spieler in der Mitte
  map.drawMap(players[id].getPos());
  
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
      players[i].show();
    }
  }  
  players[id].move();
  players[id].showCords();
  players[id].show();
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
