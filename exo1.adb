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

  PROCEDURE Insere_tete(liste: IN OUT ptliste;
                        n : in integer)  IS
	ptint : ptliste;
   BEGIN
      IF est_vide(liste) THEN
         liste := NEW noeud'(n,NULL);
      ELSE
	ptint := liste;
	 liste := new noeud'(n,ptint);	
	
      END IF;
   END Insere_tete;

  PROCEDURE  traiter (montab : IN OUT Tab ; n : integer) is
  indice : integer;
  BEGIN
	indice := n mod 10;
	if est_vide(montab(indice)) then
		montab(indice) := new noeud'(n ,liste_vide);
	else
		Insere_tete(montab(indice),n);	
	end if;
  END traiter;

 PROCEDURE  afficheliste (maliste : IN ptliste) is
		ptint : ptliste;
	begin
        IF NOT Est_Vide(maliste) THEN
		ptint := maliste;
         WHILE NOT Est_Vide(ptint) LOOP
            Put(Integer'Image(ptint.info));
            ptint := ptint.Suiv;
         END LOOP;
	end if;	
  END afficheliste;

  PROCEDURE  affiche (montab : IN Tab) is
  BEGIN
	FOR i IN 0..9 LOOP	
		if montab(i) = liste_vide then
			put("---");put(Integer'Image(i));put("---");
			New_line;
		else
			put("---");put(Integer'Image(i));put("---");
			New_line;
			afficheliste(montab(i));
			New_line;
		end if; 	
	END LOOP;
  END affiche;



montab : Tab;
fini : boolean := FALSE;		
begin
   remplir_tab(montab);
   Put("Saisir un nombre : ") ;
        Get(n) ;
	fini := n = -1;
   while not fini loop	
	if n > 0 then 
        	traiter(montab,n);
	end if;
        Get(n) ;
	fini := n = -1;
   end loop ;
	affiche(montab);
end tp2 ;

