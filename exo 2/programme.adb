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
  
Function compte( lsite : ptnoeud
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

   PROCEDURE Traiter (
         ChoixF   : IN     Integer;
         maliste : IN OUT File;
	fini : IN OUT boolean) IS
  elem : integer;
	res : integer;
	compteur : integer := 0 ;
   BEGIN
      CASE ChoixF IS
         WHEN 1 =>
		afficheliste(maliste);
         WHEN 2 =>
		res = compte(maliste.first,compteur);
		Put("il y a " );Put(res);Put(" nombre(s) dans ma liste" )
		New_Line
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
		put(1);
		--ajoutrang(maliste);
         WHEN 6 =>
		put(1);
		--supoccu(maliste);
         WHEN 7 =>
		put(1);
		--ordonne(maliste);
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
