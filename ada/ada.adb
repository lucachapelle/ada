with Ada.Text_IO, Ada.Integer_Text_IO ;
use Ada.Text_IO, Ada.Integer_Text_IO ;

procedure exemple is
   n : integer ;
begin
   loop
      Put("Saisir un nombre : ") ;
      Get(n) ; Skip_line ;
      if n mod 2 = 0
         then Put("Ce nombre est pair ! Tres bien !") ; exit ;
         else Put("Ce nombre est impair ! Recommencez. ") ;
      end if ;
   end loop ;
end exemple ;
