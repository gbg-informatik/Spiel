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
    println("Client Started");
    println(c.scn);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
  println("Setup done");
} 

void draw() { 
  clear();
  try {
    c.send();
  }
  catch(Exception e) { 
    e.printStackTrace();
  }

  //  sendData();
  //  reciveData();
  for (int i = 0; i < players.length; i++) {
    players[i].show();
  }
}

void keyPressed() {
  players[0].update(key);
}

/*
void reciveData() {
 if (c.available() > 0) { 
 input = c.readString(); 
 input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
 data = int(split(input, ' '));  // Split values into an array
 posX2 = data[0];
 posY2 = data[1];
 }
 }
 
 void sendData() {
 c.write(posX1 + " " + posY1 + "\n");
 }
 */
