// Server.java

// import java.net.ServerSocket;
// import java.net.Socket;
import java.io.*;

public class Server {
  public static void main(String[] args) {
    Server server = new Server();
    try {
      server.test();
    } catch (IOException e) {
      e.printStackTrace();
    }
   }

   void test() throws IOException {
     int port = 5056;
     java.net.ServerSocket serverSocket = new java.net.ServerSocket(port);
     System.out.println("Server running on Port: 5056");
     java.net.Socket client = warteAufAnmeldung(serverSocket);
     run(client);
   }

   java.net.Socket warteAufAnmeldung(java.net.ServerSocket serverSocket) throws IOException {
     java.net.Socket socket = serverSocket.accept(); // blockiert, bis sich ein Client angemeldet hat
     return socket;
   }

   void run(java.net.Socket client) throws IOException{
      while(true){
        System.out.println("sending");
        schreibeNachricht(client, "0;5;10;1;10;20");
        String nachricht = leseNachricht(client);
        System.out.println(System.currentTimeMillis());
        System.out.println(nachricht);
      }
   }

   String leseNachricht(java.net.Socket socket) throws IOException {
     BufferedReader bufferedReader =
      new BufferedReader(
        new InputStreamReader(
          socket.getInputStream()));
     char[] buffer = new char[200];
     int anzahlZeichen = bufferedReader.read(buffer, 0, 200); // blockiert bis Nachricht empfangen
     String nachricht = new String(buffer, 0, anzahlZeichen);
     return nachricht;
   }

   void schreibeNachricht(java.net.Socket socket, String nachricht) throws IOException {
     PrintWriter printWriter =
      new PrintWriter(
        new OutputStreamWriter(
          socket.getOutputStream()));
     printWriter.print(nachricht);
     printWriter.flush();
   }
}