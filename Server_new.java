// Java implementation of Server side
// It contains two classes : Server and ClientHandler
// Save file as Server.java

import java.io.*;
import java.text.*;
import java.util.*;
import java.net.*;

// Server class
public class Server_new
{
	public static void main(String[] args) throws IOException
	{
		// server is listening on port 5056
		ServerSocket ss = new ServerSocket(5056);
		DataObject dob = new DataObject();
		int threadIndex = 0;		// 0, but 1 for leaving the first client positions of dob open
		// running infinite loop for getting
		// client request
		while (true)
		{
			Socket s = null;
			System.out.println("Server_new running on Port: 5056");
			try
			{
				// socket object to receive incoming client requests
				s = ss.accept();

				System.out.println("A new client is connected : " + s);

				// obtaining input and out streams
				DataInputStream dis = new DataInputStream(s.getInputStream());
				DataOutputStream dos = new DataOutputStream(s.getOutputStream());

				System.out.println("Assigning new thread for this client");

				// create a new thread object
				Thread t = new ClientHandler(s, dis, dos, dob, threadIndex++);
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

class DataObject{
	float[][] data;
	DataObject(){
		data = new float[10][2];	// [max player count] [data per player]
		data[0][0] = 215;
		data[0][0] = 110;
	}

	synchronized void update(int index, float x, float y){
		data[index][0] = x;
		data[index][1] = y;
	}
	synchronized String getData(int index){
		return data[index][0] + ";" + data[index][1];
	}
	synchronized void move(int index, int counter){
		data[index][0] = (float)(java.lang.Math.sin(counter/20) * 100 + 100);
		data[index][1] = (float)(java.lang.Math.cos(counter/20) * 100 + 100);
		System.out.println("move: " + data[index][0] + " " + data[index][0]);
	}
}
// ClientHandler class
class ClientHandler extends Thread
{
	final DataInputStream dis;
	final DataOutputStream dos;
	final Socket s;
	DataObject dob;
	int threadIndex;
	int counter = 0;

	// Constructor
	public ClientHandler(Socket s, DataInputStream dis, DataOutputStream dos, DataObject dob, int threadIndex)
	{
		this.s = s;
		this.dis = dis;
		this.dos = dos;
		this.dob = dob;
		this.threadIndex = threadIndex;
		System.out.println(this.threadIndex);
	}

	@Override
	public void run()
	{
		String received;
		String toreturn;
		while (true)
		{
			try {

				int exitstatement = readData();
				//dob.move(0, counter++);


				if(exitstatement == -1)
				{
					System.out.println("Client " + threadIndex + " : " + this.s + " sends exit...");
					System.out.println("Closing this connection.");
					this.s.close();
					System.out.println("Connection closed");
					break;
				}
				if(exitstatement != 0){
					sendData();
				}
			} catch (IOException e) {
			//	e.printStackTrace();
			}
		}

		try
		{
			// closing resources
			this.dis.close();
			this.dos.close();

		}catch(IOException e){
			e.printStackTrace();
		}
	}

	int readData() throws IOException{
		String received = dis.readUTF();
		System.out.println("recieved: " + received);
		if(received.equals("Exit"))
		{
			return -1;
		}
		if(received.equals("Get Playercount")){
			try{
				System.out.println("sending Playercount: " + dob.data.length);
				sendData(dob.data.length);
			}catch(IOException e){
				System.out.println("Failed to send Playercount");
				e.printStackTrace();
			}
			return 0;
		}
		if(received.equals("Get ID")){
			try{
				System.out.println("sending ID: " + threadIndex);
				sendData(threadIndex);
			}catch(IOException e){
				System.out.println("Failed to send ID");
				e.printStackTrace();
			}
			return 0;
		}
		String[] split = received.split(";");		// id;x-pos;y-pos
		dob.update(Integer.parseInt(split[0]),Float.parseFloat(split[1]),Float.parseFloat(split[2]));
//		for(int i = 0; i < split.length/3; i ++){
//			dob.update(Integer.parseInt(split[i]),Float.parseFloat(split[i+1]),Float.parseFloat(split[i+2]));
//		}
		return 1;
	}

	void sendData() throws IOException{
		sendData(-1);
	}

	void sendData(int data) throws IOException{
		String sending = "";//"0;0;" + dob.data[0][0] + ";" + dob.data[0][1];
		if(data == -1){
			for(int i =  0; i < dob.data.length; i++){
				sending += dob.getData(i);
				if(i < dob.data.length -1){
					sending += ";";
				}
			}
		}else{
			sending += data;
		}
		System.out.println("Sending: " + sending);
		dos.flush();
		dos.writeUTF(sending);//0;0;0;1;150;200");
	}
}
