// Java implementation of Server side
// It contains two classes : Server and ClientHandler
// Save file as Server.java

package server;
import server.*;

import java.io.*;
import java.text.*;
import java.util.*;
import java.net.*;

// Server class
public class Server
{
	public static void main(String[] args) throws IOException
	{
		// server is listening on port 5056
		ServerSocket ss = new ServerSocket(5056);

		// running infinite loop for getting
		// client request
		while (true)
		{
			Socket s = null;

			try
			{
				// socket object to receive incoming client requests
				s = ss.accept();

				System.out.println("A new client is connected : " + s);

				// obtaining input and out streams
				ObjectInputStream ois = new ObjectInputStream(s.getInputStream());
				ObjectOutputStream oos = new ObjectOutputStream(s.getOutputStream());

				System.out.println("Assigning new thread for this client");

				TransmissionObject to = null;
				// create a new thread object
				Thread t = new ClientHandler(s, ois, oos);

				// Invoking the start() method
				t.start();

			}
			catch (Exception e){
				s.close();
				e.printStackTrace();
			}
		}
	}
}

class TransmissionObject implements Serializable{
	int[] data = {4,5,6,7};
}

// ClientHandler class
class ClientHandler extends Thread
{
	DateFormat fordate = new SimpleDateFormat("yyyy/MM/dd");
	DateFormat fortime = new SimpleDateFormat("hh:mm:ss");
	final ObjectInputStream ois;
	final ObjectOutputStream oos;
	final Socket s;

	// Constructor
	public ClientHandler(Socket s, ObjectInputStream ois, ObjectOutputStream oos)
	{
		this.s = s;
		this.ois = ois;
		this.oos = oos;
	}

	@Override
	public void run()
	{
		TransmissionObject received = null;
		TransmissionObject toreturn = null;
		while (true)
		{
			try {
				TransmissionObject to = new TransmissionObject();
				System.out.println(to.data[0]);

				// Ask user what he wants
				oos.writeObject(new TransmissionObject());
				oos.flush();

				// receive the answer from client
				//received = (TransmissionObject) ois.readObject();

				// write on output stream based on the
				// answer from the client
				for(int i: received.data){
					System.out.println(i);
				}

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	void endStream(){
		try{
			// closing resources
			this.ois.close();
			this.oos.close();
			System.out.println("Client " + this.s + " sends exit...");
			System.out.println("Closing this connection.");
			this.s.close();
			System.out.println("Connection closed");
		}
		catch(IOException e){
			e.printStackTrace();
		}
	}
}
