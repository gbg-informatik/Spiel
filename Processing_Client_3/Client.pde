public class Client 
{ 
  Scanner scn;
  InetAddress ip;
  Socket s;
  //DataInputStream dis;  
  //DataOutputStream dos;
  ObjectInputStream ois;
  ObjectOutputStream oos;

  void startClient() throws IOException {
    try {
      scn = new Scanner(System.in);

      // getting localhost ip 
      ip = InetAddress.getByName("localhost"); 

      // establish the connection with server port 5056 
      s = new Socket(ip, 5056); 
      println("Connected");
      
      // obtaining input and out streams 
      println("Establishing Streams");
      oos = new ObjectOutputStream(s.getOutputStream());
      println("OOS Established");
      ois = new ObjectInputStream(s.getInputStream()); 
      println("OIS Established");
    }
    catch(Exception e) { 
      e.printStackTrace();
    }
  }


  void send() throws IOException {
    try {
      println("Sending");
      println(oos);
      //println((TransmissionObject)ois.readObject()); 
      println("MOIN");
      String a = "MNNNW";
      TransmissionObject tosend = new TransmissionObject(); 
      oos.writeObject(tosend);
      oos.flush();

    }    
    catch(Exception e) { 
      e.printStackTrace();
    }
  }

  void endStream() throws IOException {
    try {
      // closing resources 
      System.out.println("Closing this connection : " + s); 
      s.close(); 
      System.out.println("Connection closed"); 
      scn.close(); 
      ois.close(); 
      oos.close();
    }    
    catch(Exception e) { 
      e.printStackTrace();
    }
  }
}
