public class Client 
{ 
  Scanner scn;
  InetAddress ip;
  Socket s;
  DataInputStream dis;
  DataOutputStream dos;
  boolean enabled = false;

  void startClient() throws IOException {
    try {
      scn = new Scanner(System.in);

      // getting localhost ip 
      ip = InetAddress.getByName("cyberwehr.eu");//"localhost"); 

      // establish the connection with server port 5056 
      println("establishing connection");
      s = new Socket(ip, 5056); 

      // obtaining input and out streams 
      println("get OutputStream");
      dos = new DataOutputStream(s.getOutputStream());
      println("get InputStream");
      dis = new DataInputStream(s.getInputStream());

      // seperate variables
      enabled = true;
      playercount = getIntFromServer("Playercount");
      id = getIntFromServer("ID");
      println("id : " + id);
      if(id == -1){
        exit();
      }
    }
    catch(Exception e) { 
      e.printStackTrace();
    }
  }

  int getIntFromServer(String S) {
    try {
      send("Get " + S);
      return int(trim(recieve()));  // trim NECESSARY because there are blank characters before the id that have to be removed
    }      
    catch(Exception e) { 
      e.printStackTrace();
      println(S + " error");
      return -1;
    }
  }

  void sendPosition() {
    if (enabled) {
      println("sending: " + id); 
      String data = id + ";" + players[id].getPosition();
      try {
        send(data);
        println("data send");
      }
      catch(Exception e) { 
        e.printStackTrace();
        println("data sending error");
      }
    } else {
      println("Connection disabled");
    }
  }

  void reciveData() {
    if (enabled) {
      try {
        println("reciving");
        String data = recieve();
        println(data);
        data = data.replaceAll("[^0-9+;+.]+", "");  //remove all characters in ASCII range except 0-9 ; .  --> cleans up recieved string
        println(data);
        String[] split = data.split(";");
        for (int i = 0; i < players.length; i++) {
          if (i != id) {
            players[i].changePosition(Float.valueOf(split[i*2]), Float.valueOf(split[i*2+1]));            
          }
        }
      }    
      catch(Exception e) { 
        e.printStackTrace();
      }
    } else {
      println("Connection disabled");
    }
  }


  void send(String data) throws IOException {
    if (enabled) {
      try {
        //System.out.println(dis.readUTF()); 
        println(data);
        dos.writeUTF(data);

        // If client sends exit,close this connection 
        // and then break from the while loop 
        if (data.equals("Exit")) 
        { 
          System.out.println("Closing this connection : " + s); 
          s.close(); 
          System.out.println("Connection closed"); 
          endStream();
        }
        println("sent");
      }    
      catch(Exception e) { 
        e.printStackTrace();
      }
    } else {
      println("Connection disabled");
    }
  }

  String recieve() throws IOException {
    BufferedReader bufferedReader =
      new BufferedReader(
      new InputStreamReader(
      s.getInputStream()));
    char[] buffer = new char[200];
    int anzahlZeichen = bufferedReader.read(buffer, 0, 200); // blockiert bis Nachricht empfangen
    String nachricht = new String(buffer, 0, anzahlZeichen);
    return nachricht;
  }


  void endStream() throws IOException {
    if (enabled) {
      try {
        // closing resources 
        scn.close(); 
        dis.close(); 
        dos.close();
        enabled = false;
      }    
      catch(Exception e) { 
        e.printStackTrace();
      }
    } else {
      println("Connection disabled");
    }
  }
}
