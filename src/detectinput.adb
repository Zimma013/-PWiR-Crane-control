package body DetectInput is
   
   protected body Ekran is
    procedure Pisz(S : String) is
    begin
      Put_Line(S);
    end Pisz;
   end Ekran;
   
   function DetectKey (Prompt : String := "Your answer (Y/N): ") return Boolean is
      Answer : Character;
   begin
      Ada.Text_IO.Put (Prompt);
      loop
         Ada.Text_IO.Get_Immediate (Answer);
         case Answer is
            when 'Y'|'y' => return True;
            when 'N'|'n' => return False;
            when others  => null;
         end case;
      end loop;
   end DetectKey;

  task body T1 is
    Nastepny : Ada.Real_Time.Time;
    Okres : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(1200);
    Przesuniecie : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(10);
  begin
    Nastepny := Ada.Real_Time.Clock + Przesuniecie;
    loop
      delay until Nastepny;
      Ekran.Pisz("Zadanie 1");
      Nastepny := Nastepny + Okres;
    end loop;
  exception
      when others => null;
  end T1;

  task body T2 is
    Nastepny : Ada.Real_Time.Time;
    Okres : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(800);
    Przesuniecie : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(40);
  begin
    Nastepny := Clock + Przesuniecie;
    loop
      delay until Nastepny;
      Ekran.Pisz("Zadanie 2");
      Nastepny := Nastepny + Okres;
    end loop;
   end T2;   
   
end DetectInput;
