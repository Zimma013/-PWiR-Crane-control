with System;

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Real_Time;
use Ada.Real_Time;

--with Conf;

package DetectInput is

  protected Ekran is
    procedure Pisz(S : String);
    pragma Priority (System.Default_Priority+4);
   end Ekran;

   function DetectKey return Boolean is
      pragma Priority (System.Default_Priority+3);
   end DetectKey

  task T1 is
    pragma Priority (System.Default_Priority+2);
  end T1;

  task T2 is
    pragma Priority (System.Default_Priority+1);
  end T2;

end DetectInput;
