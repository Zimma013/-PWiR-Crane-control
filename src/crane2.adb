with Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Discrete_Random;
use Ada.Text_IO,Ada.Float_Text_IO;

procedure crane2 is

  package RandomPack is new Ada.Numerics.Discrete_Random(Boolean);
  use RandomPack;

protected type Controller(MHigh : Natural; MFront : Natural) is
  procedure Higher;
  procedure Lower;
  procedure Front;
  procedure Back;
  procedure Left;
  procedure Right;
  private
    HowHigh: Natural :=MHigh/2;
    MaxHigh: Natural :=MHigh;
    HowFront: Natural := MFront/2;
    MaxFront: Natural := MFront;
    Horizontal: Natural := 180;
    
end Controller;

protected body Controller is
  procedure Higher is
    begin
      if HowHigh<MaxHigh then
        HowHigh := HowHigh + 1;
        Put_line("UP: " & HowHigh'Img);
      else
        Put_line("Zgrzyt");
      end if;
    end Higher;
    
  procedure Lower is
    begin
      if HowHigh>0 then
        HowHigh := HowHigh - 1;
        Put_Line("Down: " & HowHigh'Img);
      else
        Put_line("Zgrzyt");
      end if;
    end Lower;
    
   procedure Front is
    begin
      if HowFront<MaxFront then
        HowFront := HowFront + 1;
        Put_line("Front: " & HowFront'Img);
      else
        Put_line("Zgrzyt");
      end if;
    end Front;
    
  procedure Back is
    begin
      if HowFront>0 then
        HowFront := HowFront - 1;
        Put_Line("Back: " & HowFront'Img);
      else
        Put_line("Zgrzyt");
      end if;
    end Back;
    
  procedure Left is
    begin
      Horizontal := Horizontal-1;
      if Horizontal <= 0 then
        Horizontal := 359;
      end if;
      Put_line("Left: " & Horizontal'Img);
    end Left;
    
  procedure Right is
    begin
    Horizontal := Horizontal+1;
      if Horizontal >= 360 then
        Horizontal := 0;
      end if;
      Put_line("Right: " & Horizontal'Img);
   end Right;
end Controller;

--------------------------
MH : Constant Integer := 10;
MF : Constant Integer := 15;
S : Controller(MH,MF);

task Controll;
task body Controll is
  Answer : character;
  begin
    Put_line("W -> higher | E = (WR) | R -> Front | T = (RY) | Y -> Left");
    Put_line("S -> lower  | D = (SF) | F -> Back  | G = (FH) | H -> Right");
    Put_line("SPACE = WRY | C = (SFH)| O -> Help  | P -> EXIT");
    loop
      Ada.Text_IO.Get_Immediate (Answer);
      case Answer is
        when 'W'|'w' => S.higher;
        when 'S'|'s' => S.lower;
        
        when 'E'|'e' => S.Higher; S.Front;
        when 'D'|'d' => S.Lower; S.Back;
        
        when 'R'|'r' => S.Front;
        when 'F'|'f' => S.Back;
        
        when 'T'|'t' => S.Front; S.Left;
        when 'G'|'g' => S.Back; S.Right;
        
        when 'Y'|'y' => S.Left;
        when 'H'|'h' => S.Right;
        
        when ' ' => S.Higher; S.Front; S.Left;
        when 'C'|'c' => S.Lower; S.Back; S.Right;
        
        when 'O'|'o' => 
Put_line("W -> higher | E = (WR) | R -> Front | T = (RY) | Y -> Left");
Put_line("S -> lower  | D = (SF) | F -> Back  | G = (FH) | H -> Right");
Put_line("SPACE = WRY | C = (SFH)| O -> Help  | P -> EXIT");       
        when 'P'|'p' => exit;
        when others => null;
      end case;
    end loop;
end Controll;

begin
  null;
end crane2;
























