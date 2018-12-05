with Ada.Text_IO, Ada.Integer_Text_IO ;
use Ada.Text_IO, Ada.Integer_Text_IO ;

procedure exo2 is
TYPE Noeud;
TYPE ptNoeud IS ACCESS Noeud;
TYPE Noeud IS
RECORD
 Info : elt;
 Suiv : ptNoeud;
END RECORD;

TYPE File IS
RECORD
 First : ptNoeud;
 Last  : ptNoeud;
END RECORD;

File_Vide : CONSTANT File := (NULL, NULL);

   PROCEDURE Traiter (
         ChoixF   : IN     Integer;
         maliste : IN OUT File) IS
   BEGIN
      CASE ChoixF IS
         WHEN 1 =>
		put(1);
		--affiche(maliste);
         WHEN 2 =>
		put(1);
		--compte(maliste);
         WHEN 3 =>
		put(1);
		--ajouttete(maliste);
         WHEN 4 =>
		put(1);
		--ajoutfin(maliste);
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
      Put ("Appuyer sur 1 pour lister la liste");
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
      EXIT WHEN fini;
   END LOOP;
end exo2 ;
