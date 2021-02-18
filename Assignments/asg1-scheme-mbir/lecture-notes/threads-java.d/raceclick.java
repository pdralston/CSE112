// $Id: raceclick.java,v 1.2 2018-05-17 16:00:46-07 - - $

//
// Show race conditions between two threads that click an int.
// Unsynchronized clicking the count many times each.
//

import java.text.DecimalFormat;
import static java.lang.System.*;

class raceclick {
   static final long CYCLES = (long) 1e8;
   static DecimalFormat formatter = new DecimalFormat ("#,###");

   static long count = 0;

   static class racer implements Runnable {
      int ident;
      racer (int idinit) {
         ident = idinit;
      }
      public void run() {
         out.printf ("racer %d starting, count = %12s%n",
                     ident, formatter.format (count));
         out.flush();
         for (int itor = 0; itor < CYCLES; ++itor) ++count;
         out.printf ("racer %d finished, count = %12s%n",
                     ident, formatter.format (count));
         out.flush();
      }
   }

   public static void main (String[] args) {
      out.printf ("main starting, count =    %12s, CYCLES = %s%n",
                  formatter.format (count), 
                  formatter.format (CYCLES));
      out.flush();
      Thread[] threads = new Thread[4];
      for (int index = 0; index < threads.length; ++index) {
         threads[index] = new Thread (new racer (index));
         threads[index].start();
      }
      out.printf ("main finished, count =    %12s%n",
                  formatter.format (count));
      out.flush();
   }

}

//TEST// alias TIME='/usr/bin/time -f "%E elapsed, %S kernel, %U user"'
//TEST// for i in 1 2 3 4
//TEST// do
//TEST//    TIME raceclick >raceclick.out$i 2>&1
//TEST// done
//TEST// more raceclick.out? >raceclick.out </dev/null
//TEST// rm raceclick.out?
//TEST// mkpspdf raceclick.ps raceclick.java* raceclick.out

