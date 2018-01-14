with Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Discrete_Random;
use Ada.Text_IO,Ada.Float_Text_IO;

procedure crane3 is

  package RandomPack is new Ada.Numerics.Discrete_Random(Boolean);
  use RandomPack;

-------------------
protected type ControlerHeight(MHigh : Natural) is
	procedure Higher;
	procedure Lower;
	private
		HowHigh : Natural := MHigh/2;
		MaxHigh : Natural := MHigh;
		
end ControlerHeight;

protected type ControlerBoom(MFront : Natural) is
	procedure Front;
	procedure Back;
	private
		HowFront : Natural := MFront/2;
		MaxFront : Natural := MFront;
		
end ControlerBoom;

protected type ControlerRotation is
	procedure Left;
	procedure Right;
	private
		Horizontal : Natural := 180;
		
end ControlerRotation;

protected type ControlDisplay is
	procedure ShowGui;
	
end ControlDisplay;

--------------------------

protected body ControlerHeight is
	procedure Higher is
    begin
      if HowHigh<MaxHigh then
        HowHigh := HowHigh + 1;
        Put_line("Up: " & HowHigh'Img);
      else
        Put_line("Blocked");
      end if;
    end Higher;
    
	procedure Lower is
    begin
      if HowHigh>0 then
        HowHigh := HowHigh - 1;
        Put_Line("Down: " & HowHigh'Img);
      else
        Put_line("Blocked");
      end if;
    end Lower;
end ControlerHeight;

protected body ControlerBoom is
	procedure Front is
    begin
      if HowFront<MaxFront then
        HowFront := HowFront + 1;
        Put_line("Front: " & HowFront'Img);
      else
        Put_line("Blocked");
      end if;
    end Front;
    
	procedure Back is
    begin
      if HowFront>0 then
        HowFront := HowFront - 1;
        Put_Line("Back: " & HowFront'Img);
      else
        Put_line("Blocked");
      end if;
    end Back;
end ControlerBoom;

protected body ControlerRotation is
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
end ControlerRotation;

protected body ControlDisplay is
	procedure ShowGui is
	begin
		Put_line("W -> higher | D -> Front | Q -> Left");
		Put_line("S -> lower  | A -> Back  | E -> Right");
		Put_line("SPACE = WRY | O -> Help  | * -> EXIT");
	end ShowGui;
	
end ControlDisplay;

--------------------------

MH : Constant Integer := 10;
MF : Constant Integer := 15;

HControl : ControlerHeight(MH);
BControl : ControlerBoom(MF);
RControl : ControlerRotation;
DControl : ControlDisplay;

task HeightControl;
task BoomControl;
task RotationControl;
task DisplayControl;

task body HeightControl is
Answer : Character;
begin
	loop
		Ada.Text_IO.Get_Immediate (Answer);
		case Answer is
			when 'W'|'w' => HControl.higher;
			when 'S'|'s' => HControl.lower;
			when others => null;
		end case;
	end loop;
end HeightControl;

task body BoomControl is
Answer : Character;
begin
	loop
		Ada.Text_IO.Get_Immediate (Answer);
		case Answer is
			when 'D'|'d' => BControl.Front;
			when 'A'|'a' => BControl.Back;
			when others => null;
		end case;
	end loop;
end BoomControl;

task body RotationControl is
Answer : Character;
begin
	loop
		Ada.Text_IO.Get_Immediate (Answer);
		case Answer is
			when 'Q'|'q' => RControl.Left;
			when 'E'|'e' => RControl.Right;
			when others => null;
		end case;
	end loop;
end RotationControl;

task body DisplayControl is
Answer : Character;
begin
	loop
		Ada.Text_IO.Get_Immediate (Answer);
		case Answer is
			when 'O'|'o' => DControl.ShowGui;
			when '*' => exit;
			when others => null;
		end case;
	end loop;
end DisplayControl;

begin
  null;
end crane3;