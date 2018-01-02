with Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Discrete_Random;
use Ada.Text_IO,Ada.Float_Text_IO;

procedure crane is

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

task HighLow;
task FrontBack;
task LeftRight;

task body HighLow is
  Wart : Boolean;
  Gen: Generator;
begin
  Reset(Gen);
  for I in 1..100 loop
    Wart := Random(Gen);
    if Wart then
      S.Higher;
    else
      S.Lower;
    end if;
    delay 0.1;
  end loop;
end HighLow;

task body FrontBack is
  Wart : Boolean;
  Gen: Generator;
begin
  Reset(Gen);
  for I in 1..100 loop
    Wart := Random(Gen);
    if Wart then
      S.Front;
    else
      S.Back;
    end if;
    delay 0.1;
  end loop;
end FrontBack;

task body LeftRight is
  Wart : Boolean;
  Gen: Generator;
begin
  Reset(Gen);
  for I in 1..100 loop
    Wart := Random(Gen);
    if Wart then
      S.Left;
    else
      S.Right;
    end if;
    delay 0.1;
  end loop;
end LeftRight;

begin
  null;
end crane;

