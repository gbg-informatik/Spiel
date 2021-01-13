import java.io.*; 
import java.net.*; 
import java.util.Scanner; 

Player players[];
Client c;

void setup() { 
  size(300, 300); 
  background(0);
  frameRate(30);
  c = new Client();
  players = new Player[2];
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))));
  }
  try {
    c.startClient();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  println("Setup done");
} 

void draw() { 
  clear();
  try {
    println("sending");
    c.sendString();
    c.reciveString();
  }
  catch(Exception e) { 
    e.printStackTrace();
  }
  for (int i = 0; i < players.length; i++) {
    players[i].show();
  }
}

void keyPressed() {
  players[0].update(key);
}
