// $Id: observereport.java,v 1.2 2018-05-23 15:05:02-07 - - $

//
// Observers/ reporters problem.
// Observer waits for intervals and counts events happening.
// Reporter periodically reports these events
//

import java.util.*;
import static java.lang.Math.*;
import static java.lang.String.*;
import static java.lang.System.*;

class observereport {
   static long nanostart = nanoTime();

   static void print (String fmt, Object... args) { 
      Thread self = Thread.currentThread();
      double millisec = (nanoTime() - nanostart) / 1e6;
      String ident = format ("%10.3f: %s(%d): ",
                             millisec, self.getName(), self.getId());
      String message = format (fmt, args);
      out.println (ident + message);
      out.flush();
   }

   static class counter {
      private long count = 0;
      public boolean stop = false;
      synchronized void click () {
         ++count;
      }
      synchronized long reset () {
         long result = count;
         count = 0;
         return result;
      }
   }

   public static void main (String[] args) {
      print ("starting");
      counter counted = new counter ();
      Thread obs = new Thread (new observer (counted, 10));
      Thread rep = new Thread (new reporter (counted, 1000, 10));
      obs.start ();
      rep.start ();
      print ("finished");
   }


   static class observer implements Runnable {
      counter counted;
      long delay_msec;
      Random random = new Random ();
      observer (counter _counted, long _delay_msec) {
         counted = _counted;
         delay_msec = _delay_msec;
      }
      public void run () {
         Thread self = Thread.currentThread();
         self.setName ("observer");
         print ("starting");
         while (! counted.stop) {
            try {
               long delay = abs ((long) (delay_msec
                          + delay_msec * random.nextGaussian ()));
               Thread.sleep (delay);
            }catch (InterruptedException exn) {
               print ("observer interrupted: %s", exn);
            }
            counted.click ();
         }
         print ("finished");
      }
   }

   static class reporter implements Runnable {
      counter counted;
      long delay_msec;
      int cycles;
      reporter (counter countinit, long _delay_msec, int _cycles) {
         counted = countinit;
         delay_msec = _delay_msec;
         cycles = _cycles;
      }
      public void run () {
         Thread self = Thread.currentThread();
         self.setName ("reporter");
         print ("starting");
         for (int count = 0; count < cycles; ++count) {
            try {
               Thread.sleep (delay_msec);
            }catch (InterruptedException exn) {
               print ("reporter interrupted: %s", exn);
            }
            long events = counted.reset ();
            print ("report %3d: events: %5d", count, events);
         }
         counted.stop = true;
         print ("finished");
      }
   }
}

//TEST// ./observereport >observereport.out
//TEST// mkpspdf observereport.ps observereport.java* observereport.out

