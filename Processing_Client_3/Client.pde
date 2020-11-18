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

      // obtaining input and out streams 
      ois = new ObjectInputStream(s.getInputStream()); 
      oos = new ObjectOutputStream(s.getOutputStream());
    }
    catch(Exception e) { 
      e.printStackTrace();
    }
  }


  void send() throws IOException {
    try {
      System.out.println((TransmissionObject)ois.readObject()); 
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
