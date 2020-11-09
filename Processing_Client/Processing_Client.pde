import java.io.*;

Client c = new Client();

void setup(){
  try{
    c.test();
  }catch (IOException e){
    e.printStackTrace();
  }
}

void draw(){
}
