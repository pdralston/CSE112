// $Id: webserver.java,v 1.25 2018-05-29 18:28:09-07 - - $

//
// Web server.  Responds with README.html when queried.
//

import java.io.*;
import java.net.*;
import java.util.*;
import static java.lang.String.*;
import static java.lang.System.*;

class webserver {

   static String progname() {
      String jarpath = getProperty ("java.class.path");
      int lastslash = jarpath.lastIndexOf ('/');
      if (lastslash < 0) return jarpath;
      return jarpath.substring (lastslash + 1);
   }

   static String timenow() {
      return format ("%1$tY %1$tb %1$td %1$ta %1$tT.%1$tL",
                     Calendar.getInstance());
   }


   static void sendline (PrintWriter writer, String line) {
      out.printf ("SENT: %s%n", line);
      writer.printf ("%s\n", line);
   }

   static void sendfile (Socket client, String filename)
               throws IOException {
      List<String> lines = new LinkedList<String>();
      PrintWriter writer = new PrintWriter (client.getOutputStream());
      lines.add ("<PRE>");
      try {
         InetAddress addr = InetAddress.getLocalHost();
         lines.add ("From HostName: " + addr.getHostName());
         lines.add ("From HostAddress: " + addr.getHostAddress());
      }catch (UnknownHostException exn) {
         lines.add ("UnknownHostException: " + exn.getMessage());
      }
      lines.add ("Page sent: " + timenow());
      lines.add ("");
      try {
         Scanner file = new Scanner (new File (filename));
         while (file.hasNextLine()) {
            String line = file.nextLine();
            lines.add (line);
         }
      }catch (IOException exn) {
         out.printf ("%s%n", exn);
         lines.add ("IOException: " + exn.getMessage());
      }
      int length = 0;
      for (String line: lines) length += line.length() + 1;
      sendline (writer, "HTTP/1.1 200 OK");
      sendline (writer, "Content-Type: text/html");
      sendline (writer, "Content-Length: " + length);
      sendline (writer, "");
      for (String line: lines) sendline (writer, line);
      writer.flush();
   }


   static List<String> getrequest (Socket client) throws IOException {
      List<String> lines = new LinkedList<String>();
      Scanner input = new Scanner (client.getInputStream());
      while (input.hasNextLine()) {
         String line = input.nextLine();
         out.printf ("RECD: %s%n", line);
         lines.add (line);
         if (line.length() == 0) break;
      }
      return lines;
   }

   static class worker implements Runnable {
      static int worker_count = 0;
      Socket client;
      int id = ++worker_count;
      worker (Socket client) {
         this.client = client;
      }
      public void run() {
         Thread.currentThread().setName ("Worker " + id);
         out.printf ("%s: worker %d: starting%n", progname(), id);
         String filename = null;
         try {
            List<String> request = getrequest (client);
            filename = request.get(0).split("\\s+")[1];
            sendfile (client, filename.substring(1));
            client.close();
            out.printf ("%s: worker %d: finished%n", progname(), id);
         }catch (IOException exn) {
            out.printf ("%s: %s: %s%n", progname(), filename, exn);
         }
      }
   }


   public static void main (String[] args) {
      int port_number = Integer.parseInt (args[0]);
      try {
         ServerSocket socket = new ServerSocket (port_number);
         out.printf ("%s: waiting for client%n", progname());
         for (;;) {
            Socket client = socket.accept();
            out.printf ("%s: socket.accept OK%n", progname());
            Thread worker = new Thread (new worker (client));
            worker.start();
         }
      }catch (IOException exn) {
         out.printf ("%s: %s%n", progname(), exn);
      }catch (IllegalArgumentException exn) {
         out.printf ("%s: %s%n", progname(), exn);
      }
   }

}

//TEST// pkill webserver
//TEST// sleep 5
//TEST// DUMP="lynx -dump localhost:6000"
//TEST// ./webserver 6000 >webserver.out.1server &
//TEST// sleep 5
//TEST// $DUMP/README.txt >webserver.out.2txt.client
//TEST// $DUMP/README.html >webserver.out.3html.client
//TEST// sleep 5
//TEST// pkill webserver
//TEST// mkpspdf webserver.ps webserver.java* webserver.out.*

