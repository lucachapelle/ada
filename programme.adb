with Ada.Text_IO, Ada.Integer_Text_IO ;
use Ada.Text_IO, Ada.Integer_Text_IO ;

procedure tp2 is
   type Tab is array (0..9) of INTEGER ;
   n:integer;

begin

   loop	
      Put("Saisir un nombre : ") ;
      Get(n) ; Skip_line ;
      Put(n);
   end loop ;
end tp2 ;
