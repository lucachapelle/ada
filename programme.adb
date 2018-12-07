
with Ada.Text_IO, Ada.Integer_Text_IO ;
use Ada.Text_IO, Ada.Integer_Text_IO ;

procedure exo2 is
TYPE Noeud;
TYPE ptNoeud IS ACCESS Noeud;
TYPE Noeud IS
RECORD
 info : integer;
 suiv : ptNoeud;
END RECORD;

TYPE File IS
RECORD
 first : ptNoeud;
 last  : ptNoeud;
END RECORD;

File_Vide : CONSTANT File := (NULL, NULL);

  FUNCTION Est_Vide(FileF: IN File) RETURN Boolean IS

  BEGIN
     RETURN FileF.First = NULL AND FileF.Last = NULL ;
  END Est_Vide;

PROCEDURE  afficheliste (maliste : IN file) is	
	ptint : ptNoeud;
begin
        IF NOT Est_Vide(maliste) THEN
		ptint := maliste.First;
		Put("voila ma liste :");
         WHILE NOT (ptint = NUll) LOOP
            Put(Integer'Image(ptint.info));
            ptint := ptint.Suiv;
         END LOOP;
	else 
 		put("ma liste est vide");
	end if;	
END afficheliste;
  
Function compte( liste : ptnoeud; cpt : integer) return integer is
Begin
	if (liste = null) then 
		return cpt;
	else 
		return compte(liste.suiv,cpt+1);
	end if;
end compte;

PROCEDURE ajouttete(FileF: IN OUT File; Elmt: IN integer) IS
      Pt_Int: ptNoeud;

   BEGIN
      IF Est_Vide(FileF) THEN
         FileF.First := NEW Noeud'(Elmt,NULL);
         FileF.Last := FileF.First;

      ELSE
         Pt_Int := FileF.First;
         FileF.first := NEW Noeud'(Elmt,PT_Int);
      END IF;

    END ajouttete;

 PROCEDURE ajoutfin(FileF: IN OUT File;
                        Elmt : in integer)  IS
   BEGIN
      IF Est_Vide(FileF) THEN
         FileF.First := NEW Noeud'(Elmt,NULL);
         FileF.Last := FileF.First;

      ELSE
         FileF.Last.suiv := NEW Noeud'(Elmt,NULL);
         FileF.Last := FileF.Last.Suiv;
      END IF;

   END ajoutfin;

PROCEDURE ajoutrang( mafile : IN OUT File; rang : IN Integer; Elt : IN Integer) IS
	maliste : ptNoeud := mafile.first;
	ptint : ptNoeud;
Begin
	if rang = 1 then
		ajouttete(mafile,elt);
	else 
		FOR i IN 1..rang-2 LOOP	
			maliste := maliste.suiv;
		end loop;
	ptint := maliste.suiv;
	maliste.suiv := new Noeud'(elt,ptint);
	end if;
end ajoutrang;

PROCEDURE supoccu( mafile : IN OUT File; Elt : IN Integer) IS
maliste : ptNoeud := mafile.first;
ptprec : ptNoeud := mafile.first;
trouve : boolean := False;


Begin
		
	while not (maliste = NUll) loop			
		mafile.last :=maliste;	
		if maliste.info = ELT   then
			ptprec.suiv := maliste.suiv;
			maliste := maliste.suiv;
			trouve := true;
		else
			maliste := maliste.suiv;
			ptprec := ptprec.suiv;
		end if;

	end loop;

	if not trouve then 
		put ("pas d element dans la liste");
	end if;
end supoccu;

PROCEDURE Ordonner(mafile : IN OUT File) IS
	nouvF : File ;
	nouvF_int : ptNoeud;
	ptint : ptNoeud := mafile.first;
	cpt_loop : integer := 1 ;
BEGIN
	
	IF Est_Vide(mafile) THEN
		Put("Liste Vide");
	ELSE
		nouvF.first := new Noeud'(mafile.first.info, null);
		ptint := ptint.suiv;
	
		FOR i IN 1..compte(ptint,0)-1 LOOP
			nouvF_int := nouvF.first;
			WHILE (nouvF_int /= null) AND THEN (ptint.info > nouvF_int.info) LOOP
				cpt_loop := cpt_loop + 1;
				nouvF_int := nouvF_int.suiv;
			END LOOP;				
			ajoutrang(nouvF,cpt_loop,ptint.info);
			ptint := ptint.suiv;
			cpt_loop := 1 ;
		END LOOP;
		mafile.first := nouvF.first;
		mafile.last := nouvF.last;
	END IF;
END Ordonner;

   PROCEDURE Traiter (
         ChoixF   : IN     Integer;
         maliste : IN OUT File;
	fini : IN OUT boolean) IS
  elem , rang: integer;
	res : integer;
   BEGIN
      CASE ChoixF IS
         WHEN 1 =>
		afficheliste(maliste);
         WHEN 2 =>
		res := compte(maliste.first,0);
		Put("il y a " );Put(Integer'Image(res));Put(" nombres dans ma liste" );
		New_Line;
         WHEN 3 =>
		Put("veuillez entrer un nombre" );
		New_Line;
		Get(elem);
      		New_Line;
		ajouttete(maliste,elem);
         WHEN 4 =>
		Put("veuillez entrer un nombre" );
		New_Line;
		Get(elem);
      		New_Line;
		ajoutfin(maliste,elem);
         WHEN 5 =>
		Put("veuillez entrer un rang" );
		New_Line;
		Get(rang);
      		New_Line;
		if ((rang > compte(maliste.first,0) + 2) or (rang < 1)) then 
			Put("rang invalide" );
			New_Line;
		else
			Put("veuillez entrer un element" );
			New_Line;
			Get(elem);
      			New_Line;
			ajoutrang(maliste,rang,elem);
		end if;
         WHEN 6 =>
		Put("veuillez entrer un nombre" );
		New_Line;
		Get(elem);
      		New_Line;
		supoccu(maliste,elem);
         WHEN 7 =>
		ordonner(maliste);
         WHEN 8 =>
            Fini := True;
         WHEN OTHERS =>
            Put("Erreur : Action non valide.");
            New_Line;

      END CASE;
   END Traiter;
maliste : File;
choix : integer;
fini : boolean := False;
begin
   LOOP
      New_Line;
      Put ("Appuyer sur 1 pour afficher la liste");
      New_Line;
      Put("Appuyer sur 2 pour compter le nombre d élements");
      New_Line;
      Put("Appuyer sur 3 pour ajouter en tete" );
      New_Line;
      Put ("Appuyer sur 4 pour ajouter en fin");
      New_Line;
      Put("Appuyer sur 5 pour ajouter au rang i");
      New_Line;
      Put("Appuyer sur 6 pour detruire les occurences" );
      New_Line;
      Put ("Appuyer sur 7 pour reordonner la liste");
      New_Line;
      Put("Appuyer sur 8 pour quitter");
      New_Line;
      Get(Choix);
      New_Line;
      Traiter (choix,maliste,fini);	
      New_Line;
      EXIT WHEN fini;
   END LOOP;
end exo2 ;
