/*
import java.io.*; 
import java.net.*; 
import java.util.Scanner; 

Player players[];
Client c;
int id, playercount = 1;

void setup() { 
  size(300, 300); 
  background(0);
  frameRate(30);
  c = new Client();
  try {
    c.startClient();
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  players = new Player[playercount];
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255))));
  }

  println("Setup done");
} 

void draw() { 
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
    players[i].show();
  }
}

void keyPressed() {
  if(key != 'x'){
    players[id].update(key);
  }else{
    try{
      c.send("Exit");
    } catch(Exception e) { 
      e.printStackTrace();
    }

  }
}
*/
