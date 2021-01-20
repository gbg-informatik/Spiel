class Client{
  void test() throws IOException{
    String ip = "127.0.0.1";
    int port = 11111;
    java.net.Socket socket = new java.net.Socket(ip,port); // verbindet sich mit Server
    String zuSendendeNachricht = "Hello, world!";
    schreibeNachricht(socket, zuSendendeNachricht);
    String empfangeneNachricht = leseNachricht(socket);
    println(empfangeneNachricht);
  }
  
  void schreibeNachricht(java.net.Socket socket, String nachricht) throws IOException {
    PrintWriter printWriter =  new PrintWriter(
                                   new OutputStreamWriter(
                                       socket.getOutputStream()));
    printWriter.print(nachricht);
    printWriter.flush();
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
}