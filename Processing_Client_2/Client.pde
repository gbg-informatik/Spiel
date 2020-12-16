public class Client 
{ 
  Scanner scn;
  InetAddress ip;
  Socket s;
  DataInputStream dis;
  DataOutputStream dos;

  void startClient() throws IOException {
    try {
      scn = new Scanner(System.in);

      // getting localhost ip 
      ip = InetAddress.getByName("localhost"); 

      // establish the connection with server port 5056 
      println("establishing connection");
      s = new Socket(ip, 5056); 

      // obtaining input and out streams 
      println("get OutputStream");
      dos = new DataOutputStream(s.getOutputStream());
      println("get InputStream");
      dis = new DataInputStream(s.getInputStream()); 
    }
    catch(Exception e) { 
      e.printStackTrace();
    }
  }


  void send() throws IOException {
    try {
      //System.out.println(dis.readUTF()); 
      String tosend = "Time"; 
      dos.writeUTF(tosend);

      // If client sends exit,close this connection 
      // and then break from the while loop 
      if (tosend.equals("Exit")) 
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
  }

  void endStream() throws IOException {
    try {
      // closing resources 
      scn.close(); 
      dis.close(); 
      dos.close();
    }    
    catch(Exception e) { 
      e.printStackTrace();
    }
  }
}
