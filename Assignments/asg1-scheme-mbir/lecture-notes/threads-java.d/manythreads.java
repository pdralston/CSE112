// $Id: manythreads.java,v 1.6 2018-05-17 16:21:50-07 - - $

// Create many threads which loop for a while.

import static java.lang.System.*;

class manythreads {
   static final long CYCLES = 1L<<20;

   static void print (String status, long result) {
      Thread self = Thread.currentThread();
      out.printf ("(%2d)%-8s: %s, result = %d%n",
                  self.getId(), self.getName(), status, result);
   }

   static class printmsg implements Runnable {
      String threadname;
      long loops;
      long result = 0;
      printmsg (String threadname_, long loops_) {
         threadname = threadname_;
         loops = loops_;
      }
      public void run() {
         Thread self = Thread.currentThread();
         self.setName (threadname);
         print ("starting", result);
         for (long count = 0; count < loops; ++count) {
            ++result;
         }
         print ("finished", result);
      }
   }

   static String[] names = {"Hello", "World", "Foo", "Bar", "Baz",
                            "Penguin", "Dæmon", "Racoon"};

   public static void main (String[] args) {
      Thread self = Thread.currentThread();
      print ("starting", 0);
      for (int index = 0; index < names.length; ++index) {
         Thread thread = new Thread (new printmsg (names[index],
                         index * 1L<<20));
         thread.start();
      }
      print ("finished", 0);
   }
}

//TEST// ./manythreads >manythreads.out
//TEST// mkpspdf manythreads.ps manythreads.java* manythreads.out

