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


  void send(String data) throws IOException {
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
