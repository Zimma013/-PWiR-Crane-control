with Ada.Text_IO,Ada.Float_Text_IO;
use Ada.Text_IO,Ada.Float_Text_IO;

procedure crane4 is
  
  is_higher: Natural := 1;
  is_front: Natural := 1;
  is_right: Natural := 1;
  end_task: boolean := False with Atomic;

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
        Put_line("Moving up: " & HowHigh'Img);
      else
        Put_line("Blocked");
      end if;
    end Higher;
    
	procedure Lower is
    begin
      if HowHigh>0 then
        HowHigh := HowHigh - 1;
        Put_Line("Moving down: " & HowHigh'Img);
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
        Put_line("               Moving front: " & HowFront'Img);
      else
        Put_line("               Blocked");
      end if;
    end Front;
    
	procedure Back is
    begin
      if HowFront>0 then
        HowFront := HowFront - 1;
        Put_Line("               Moving back: " & HowFront'Img);
      else
        Put_line("               Blocked");
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
	  Put_line("                              Moving left: " & Horizontal'Img);
	end Left;

	procedure Right is
	begin
		Horizontal := Horizontal+1;
	  if Horizontal >= 360 then
			Horizontal := 0;
	  end if;
	  Put_line("                              Moving right: " & Horizontal'Img);
	end Right;
end ControlerRotation;

protected body ControlDisplay is
	procedure ShowGui is
	begin
		Put_line("Q -> higher | W -> Front | E -> Right | O -> Help");
		Put_line("A -> stay   | S -> Stay  | D -> Stay  | P -> Exit");
		Put_line("Z -> lower  | X -> Back  | C -> Left");
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

task body HeightControl is
begin
	loop
		case is_higher is
			when 2 => HControl.higher; delay 0.5;
			when 0 => HControl.lower; delay 0.5;
			when others => null;
		end case;
		exit when end_task;
	end loop;
end HeightControl;

task body BoomControl is
begin
	loop
		case is_front is
			when 2 => BControl.Front; delay 0.5;
			when 0 => BControl.Back; delay 0.5;
			when others => null;
		end case;
		exit when end_task;
	end loop;
end BoomControl;

task body RotationControl is
begin
	loop
		case is_right is
			when 2 => RControl.Left; delay 0.5;
			when 0 => RControl.Right; delay 0.5;
			when others => null;
		end case;
		exit when end_task;
	end loop;
end RotationControl;


---------------------------------------------------------
task Controll;
task body Controll is
  Answer : character;
  begin
    Put_line("Q -> higher | W -> Front | E -> Right | O -> Help");
		Put_line("A -> stay   | S -> Stay  | D -> Stay  | P -> Exit");
		Put_line("Z -> lower  | X -> Back  | C -> Left");
    loop
      Ada.Text_IO.Get_Immediate (Answer);
      case Answer is
        when 'Q'|'q' => is_higher := 2;
        when 'A'|'a' => is_higher := 1;
				when 'Z'|'z' => is_higher := 0;
        
        when 'W'|'w' => is_front := 2;
        when 'S'|'s' => is_front := 1;
				when 'X'|'x' => is_front := 0;
        
				when 'E'|'e' => is_right := 2;
				when 'D'|'d' => is_right := 1;
				when 'C'|'c' => is_right := 0;
        
        when 'O'|'o' => DControl.ShowGui;     
        when 'P'|'p' => end_task := True; exit;
        when others => null;
      end case;
    end loop;
end Controll;


begin
  null;
end crane4;
