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
    JSONObject a = new JSONObject();
    a.put("x","5");
    a.put("y","20");
    println(a.getInt("x"));
    c.send("Hello World!");
    println(c.recieve());
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
 /*
 void sendString(){
   try {
     println("sending");
     String data = players[0].getPosition();
     //send position
     println("data send");
   }
 }
 
 void reciveString() {
   try {
     println("reciving");
     String data = "";
     //data = recived data
     String[] split = data.split(";");
     players[Integer.valueOf(split[3])].changePosition(Float.valueOf(split[4]),Float.valueOf(split[5]));
     
   }
 }*/
