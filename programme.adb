with Ada.Text_IO, Ada.Integer_Text_IO ;
use Ada.Text_IO, Ada.Integer_Text_IO ;

procedure tp2 is
   n:integer;
   type noeud;
   type ptliste is access noeud;
   type noeud is record
		info : integer;
		suiv : ptliste;
		end record;	
  type Tab is array (0..9) of ptliste ;
  liste_vide : CONSTANT ptliste :=NULL;	

  PROCEDURE  remplir_tab (montab : OUT Tab) is
  BEGIN
	FOR i IN 0..9 LOOP	
		montab(i) := liste_vide ;
	END LOOP;
  END remplir_tab;	

  function  est_vide (maliste : in ptliste) return boolean is
  BEGIN
	return maliste = NULL;
  END est_vide;

  PROCEDURE insereenfin(maliste : in out ptliste;n);
  PROCEDURE  traiter (montab : IN OUT Tab ; n : integer) is
  indice : integer;
  BEGIN
	indice := n mod 10;
	if est_vide(tab(indice)) then
		tab(i) := new noeud (n ,liste_vide)
	else
		insereenfin(tab(i),n);	
	end if;
  END traiter;

montab : Tab;
fini : boolean := FALSE;		
begin
   remplir_tab(montab);
   Put("Saisir un nombre : ") ;
        Get(n) ;
	fini := n = -1;
   while not fini loop	
        put(n mod 10);
        Get(n) ;
	fini := n = -1;
   end loop ;
       --	affiche(montab);
end tp2 ;
