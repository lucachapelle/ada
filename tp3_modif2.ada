WITH Ada.Integer_Text_IO;
WITH Ada.Text_IO;
WITH Ada.Strings.Unbounded;
WITH Ada.Strings.Unbounded.Text_Io;

USE Ada.Integer_Text_IO;
USE Ada.Text_IO;
USE Ada.Strings.Unbounded;
USE Ada.Strings.Unbounded.Text_Io;


PROCEDURE TP3 IS
   Nbmax : CONSTANT Integer := 20;

   TYPE Color IS (Rouge,Rose,Blanc);
   PACKAGE ColorIO IS NEW Enumeration_Io(Color);
   use colorio;
   -- On definit un type énumeré pour la couleur des vins.

   TYPE Vin IS RECORD Nom : Unbounded_String;
                      Couleur : Color;
                      Annee, Qte : Integer;
   END RECORD;
   -- On définit ici notre bouteille de vin qui contiendra toutes ses informations.


   TYPE Tablo IS ARRAY (1 .. Nbmax) OF Vin;
   -- Ce sera le tableau où seront rangés les vin de notre cave.

   TYPE Cave IS RECORD TabVin : Tablo;
                        Nbeff : Integer :=0;
   END RECORD;
   -- Ce sera notre cave où on trouvera notre tableau de vin ainsi que le nombre de vin contenu dans notre cave.

   PROCEDURE  Afficher_Menu is
   -- Cette procédure nous servira à afficher le menu de commande à executer.
   BEGIN
      Put("Choisissez une opération a effectuer : ");
      New_line;
      Put("1- Ajouter une ou plusieurs bouteilles");
      New_line;
      Put("2- Supprimer une ou plusieurs bouteilles");
      New_line;
      Put("3- Afficher la liste des bouteilles");
      New_line;
      Put("4- Quitter");
      New_line;
   END Afficher_Menu ;


   PROCEDURE Cherche (IndiceF : OUT Integer; TrouveF : OUT Boolean; CaveF: IN Cave; Nom : IN Unbounded_String)IS
   
   -- Cette procédure est une recherche séquentielle, qui nous permettra à retrouver un vin dans notre tableau de vin
   -- si il existe ou trouver l'endroit où il devrait être si il existait.
   
		-- OUT
			--IndiceF : Il contiendra la valeur de l'emplacement du vin recherché.
			--TrouveF : Le booléen qui nous indiquera si le vin est trouvé ou non.
			
		-- In
			--CaveF : C'est ici où l'on recherchera notre vin.
			--Nom : C'est le vin qu'on recherchera.
				
      Trouve : Boolean := False;
      Indice : Integer := 1;
   BEGIN
   
      WHILE (NOT Trouve) AND ( Nom >= CaveF.TabVin(Indice).Nom ) AND (Indice <= CaveF.Nbeff)  LOOP
	  -- Recherche optimisé qui s'arrête si le vin est trouvé ou si le vin rencontre un vin plus grand que lui. 
	  -- La comparaison se fera avec le nom du vin.
	  
		  IF Trouve := Nom = CaveF.TabVin(Indice).Nom; THEN
			 indiceF := indice - 1;
		  ELSE
			 IndiceF := Indice;
		  END IF;
			 Indice := Indice + 1;
      END LOOP;
        TrouveF := Trouve;

   END Cherche;


   PROCEDURE Recup_Info (InfoF : OUT Vin; CaveF : IN Cave) IS
   --  Cette procédure nous servira à recuperer toutes les informations d'un vin et
		--à savoir si ce dernier est dans notre cave ou pas.   
		
		-- OUT
			--InfoF : Contiendra les informations d'un vin.
		--IN
			--CaveF : C'est ici où l'on cherhera le vin pour savoir si il exitse déjà dans la cave. 
			
      Trouve : Boolean;
			-- Booléen qui nous indiquera si le vin est dans notre cave.
      Indice : Integer;
      Qte_non_nulle : Boolean := false;
			--Booléen qui nous verfiera si la quantité est positive.
   BEGIN
      Put("Veuillez rentrer les informations de votre bouteille");
      New_Line;
      Skip_Line;

      Put("Veuillez rentrer le nom de votre vin : ");
      InfoF.Nom := Get_Line;
      New_Line;

      Cherche(Indice, Trouve, CaveF, InfoF.Nom);

      IF not(Trouve) THEN
         Put("Veuillez rentrer la couleur de votre vin : ");
         Get(InfoF.Couleur);
         New_Line;

         Put("Veuillez rentrer l'année de votre vin : ");
         Get(InfoF.Annee);
         New_Line;
      ELSE
         InfoF.Couleur := CaveF.TabVin(Indice).Couleur;
         InfoF.Annee := CaveF.TabVin(Indice).Annee;
      END IF;

      WHILE not(Qte_non_nulle) LOOP
		-- Boucle qui demandera la quantité tant que la quantité ne sera pas positive.
         Put("Veuillez rentrer la quantité de bouteille que vous voulez déposer : ");
         Get(InfoF.Qte);
         New_Line;
		 
         IF InfoF.Qte > 0 THEN
			Qte_non_nulle := True;
         ELSE
			Put("Veuillez rentrer un nombre de bouteille valable Mr Marty");
         END IF;
		 
         New_Line;

      END LOOP;


   END Recup_Info;



   PROCEDURE Affiche(CaveAff : in cave) IS
   -- Cette procédure affichera tous les vins de la cave ainsi que leurs informations.
		--IN
			--CaveAff: C'est la cave qu'on affichera.	   
   BEGIN
   
      IF CaveAff.Nbeff = 0 THEN
			Put("il n'y a pas de bouteille dans votre cave");
            New_Line;
      ELSE  
	  
         FOR I in 1 .. CaveAff.Nbeff LOOP
            Put("le nom de la bouteille numéro");Put(integer'image(I));Put(" est : ");Put(CaveAff.TabVin(I).Nom);new_line;
            Put("la couleur de la bouteille numéro");Put(integer'image(I));Put(" est : ");Put(CaveAff.TabVin(I).Couleur);New_Line;
            Put("le millésime de la bouteille numéro");Put(integer'image(I));Put(" est : ");Put(integer'image(CaveAff.TabVin(I).Annee));New_Line;
            Put("Il y a ");Put(integer'image(CaveAff.TabVin(I).qte));Put(" exemplaire de cette bouteille");
            New_Line;
            New_line;
         END LOOP;
		 
      END IF;
	 
   END Affiche ;



   PROCEDURE Ajouter(CaveF: IN OUT Cave; MonInfo : IN vin) IS
   
   -- Cette procédure servira à inserer un vin dans notre tableau de vin.
		--IN OUT
			--CaveF: C'est ici qu'on inserera notre vin.
		--IN
			--MonInfo: C'est notre vin qui sera inséré.
			
      Indice : Integer;
      Trouve : Boolean;

   BEGIN
   
      Cherche(Indice, Trouve, CaveF, MonInfo.Nom);

      IF Trouve THEN
			CaveF.Tabvin(Indice).Qte := CaveF.Tabvin(Indice).Qte + MonInfo.Qte;
      -- Si le vin existe déjà, on ne demandera que la quantité.
	  ELSE	  
	  
         FOR I IN REVERSE Indice..CaveF.Nbeff LOOP
            CaveF.Tabvin(I+1) := CaveF.Tabvin(I);
         END LOOP;
		 -- Ici on libére l'emplacement pour le nouveau vin. En decalant les autres vins d'un case.
		 
         CaveF.Tabvin(Indice) := MonInfo;
         CaveF.Nbeff := CaveF.Nbeff + 1;
		 
      END IF;
	  
   END Ajouter;
   

   PROCEDURE Supprimer (CaveF: IN OUT Cave) IS
      IndiceF : Integer;
      TrouveF : Boolean;
      NomVin : Unbounded_String;
      NbVin : integer;
   BEGIN
      IF CaveF.Nbeff = 0
            THEN Put("il n'y a pas de bouteille dans votre cave");New_line;
      else
         skip_line;
         Put("Veuillez rentrer le nom de votre vin : ");
         NomVin := Get_Line;
         New_Line;

         Cherche(IndiceF, TrouveF, CaveF, NomVin);
         IF NOT TrouveF
               THEN Put("Déjà supprimée !");New_Line;
         ELSE
            Put("Veuillez rentrer la quantité de bouteille que vous voulez supprimer : ");
            Get(NbVin);
            New_Line;

            IF CaveF.TabVin(IndiceF).Qte < NbVin
               THEN Put("Il n'y a pas la quantité demandée");New_Line;
            ELSE
               IF CaveF.TabVin(IndiceF).Qte > NbVin
                  THEN CaveF.TabVin(IndiceF).Qte := CaveF.TabVin(IndiceF).Qte - NbVin;
               --END IF;
               Else
               --iF CaveF.TabVin(IndiceF).Qte = NbVin
                 -- THEN
                  FOR I IN IndiceF .. CaveF.Nbeff LOOP
                     CaveF.Tabvin(I) := CaveF.Tabvin(I+1);
               END LOOP;
               put("la bouteille ");put(NomVin);put(" a ete suprimé");New_Line;
               CaveF.Nbeff := CaveF.Nbeff - 1;
               END IF;

            end if;
         END IF;
      END IF;

   END Supprimer;

   PROCEDURE Traiter(Choix : IN Integer;FinF : IN OUT Boolean ;CaveF : IN OUT Cave) IS
      MonInfo : vin;
   BEGIN
      CASE Choix IS
         WHEN 1 => Recup_Info(MonInfo,CaveF);
                   Ajouter(CaveF,MonInfo);
         WHEN 2 =>Supprimer(CaveF);
         WHEN 3 => Affiche(CaveF);
         WHEN OTHERS => Put("La demande n'existe pas, veuillez faire une demande existante.");
            New_Line;
            New_Line;
            NULL;      
      END CASE;
   END Traiter;

      Macave : Cave;
      MonChoix : Integer;
      Fin : Boolean := False;

BEGIN
   LOOP
      Afficher_Menu;
	  Put("Veuillez entrer votre choix de commande :");
      Get(MonChoix);
      Traiter(MonChoix,Fin,Macave);
      EXIT WHEN Fin;
   END LOOP;




END TP3;
