// $Id: synchclick.java,v 1.1 2018-05-17 16:01:36-07 - - $

//
// Synchronized clicking of a counter.
// When one thread enters counter, the other must wait.
//

import java.text.DecimalFormat;
import static java.lang.System.*;

class synchclick {

   static final long CYCLES = (long) 1e8;
   static DecimalFormat formatter = new DecimalFormat ("#,###");

   static class counter {
      int count = 0;
      synchronized void click() {
         ++count;
      }
   }
   static counter count = new counter();
   

   static class synchr implements Runnable {
      int ident;
      synchr (int idinit) {
         ident = idinit;
      }
      public void run() {
         out.printf ("racer %d starting, count = %12s%n",
                     ident, formatter.format (count.count));
         out.flush();
         for (int itor = 0; itor < CYCLES; ++itor) count.click();
         out.printf ("racer %d finished, count = %12s%n",
                     ident, formatter.format (count.count));
         out.flush();
      }
   }

   public static void main (String[] args) {
      out.printf ("main starting, count =    %12s, CYCLES = %s%n",
                  formatter.format (count.count),
                  formatter.format (CYCLES));
      out.flush();
      Thread[] threads = new Thread[4];
      for (int index = 0; index < threads.length; ++index) {
         threads[index] = new Thread (new synchr (index));
         threads[index].start();
      }
      out.printf ("main finished, count =    %12s%n",
                  formatter.format (count.count));
      out.flush();
   }

}


//TEST// alias TIME='/usr/bin/time -f "%E elapsed, %S kernel, %U user"'
//TEST// for i in 1 2 3 4 
//TEST// do
//TEST//    TIME synchclick >synchclick.out$i 2>&1
//TEST// done
//TEST// more synchclick.out? >synchclick.out </dev/null
//TEST// rm synchclick.out?
//TEST// mkpspdf synchclick.ps synchclick.java* synchclick.out

