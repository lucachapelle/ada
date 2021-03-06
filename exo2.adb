
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
	-- Indique si la Liste est vide ou non.
	      --IN
		--FileF: La Liste qui est testée.

  BEGIN
     RETURN FileF.First = NULL AND FileF.Last = NULL ;
  END Est_Vide;

PROCEDURE  afficheliste (maliste : IN file) is	
	-- Cette procédure affiche tous les elements de la liste.
      		-- IN
      		   -- maliste: La Liste qui sera affiché.
		  
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
  
Function compte( liste : IN ptnoeud; cpt : IN integer) return integer is
	-- Cette focntion compte le nombre d'element dans la liste.
     		 -- IN
      		   -- liste: La Liste contenant les elements à compter.
      		   -- cpt: Le compteur de recursivité.
Begin
	if (liste = null) then 
		return cpt;
	else 
		return compte(liste.suiv,cpt+1);
	end if;
end compte;

PROCEDURE ajouttete(FileF: IN OUT File; Elmt: IN integer) IS
	-- Cette procédure ajoute un élément en debut de Liste.
	      -- IN OUT
	         -- FileF: La Liste où sera retiré l'élément.
	      --IN
		--Elmt : L'élément à retirer.
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

 PROCEDURE ajoutfin(FileF: IN OUT File; Elmt : in integer)  IS
	-- Cette procédure ajoute un element en fin de liste.
	      -- IN OUT
	         -- FileF: La Liste où l'element sera ajouté.
	      -- IN
		-- Elmt: L'élément à ajouter.
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
	-- Cette procédure ajoute un element au rang donné.
	      -- IN OUT
	         -- mafile: La Liste où l'element sera ajouté.
	      -- IN
		-- Elt: L'élément à ajouter.
		-- rang: Le rang où l'élément sera ajouté
	
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
	-- Cette procédure supprime les occurences d'un element dans la liste.
      		-- IN OUT
        	 	-- ma file : La Liste où l'element sera supprimé.
      		-- IN
			-- Elt: L'élément à supprimé.	


--Déclarations et initialisations
maliste : ptNoeud := mafile.first;
ptprec : ptNoeud := mafile.first;
trouve : boolean := False;


Begin

	-- Gestion du premier élément
	While (not Est_Vide(mafile)) and then maliste.info = elt loop
		if compte(mafile.first,0) > 1 then
			maliste := maliste.suiv;
			mafile.first := maliste;
		else
			mafile := File_Vide;
		end if;
	end loop;
	
	-- Suppression des occurences
	if (not Est_Vide(mafile)) then		
		ptprec := maliste;		
		while not (maliste = NUll) loop			
				
			if maliste.info = ELT   then
				ptprec.suiv := maliste.suiv;
				trouve := true;
			else
				ptprec := maliste;

			end if;	
			maliste := maliste.suiv;
		end loop;
	end if;

	if not trouve then 
		put ("Plus d'element dans la liste");
	end if;
end supoccu;



PROCEDURE Ordonner(mafile : IN OUT File) IS
	-- Cette procédure ordonne de manière croissante les elements de la liste.
	      -- IN OUT
	         -- mafile: La Liste des elements.
	      
	nouvF : File ;
	nouvF_int, pt_last, pt_before_last : ptNoeud;
	ptint : ptNoeud := mafile.first;
	cpt_loop : integer := 1 ;
BEGIN
	
	IF Est_Vide(mafile) THEN
		Put("Liste Vide");
	ELSE
		nouvF.first := new Noeud'(mafile.first.info, null);
		nouvF.last := nouvF.first;
		ptint := ptint.suiv;
		
	
		FOR i IN 1..compte(ptint,0)-1 LOOP
			
			nouvF_int := nouvF.first;
		
			WHILE (nouvF_int /= null) AND THEN (ptint.info > nouvF_int.info) LOOP
				cpt_loop := cpt_loop + 1;
				pt_before_last := nouvF_int;
				nouvF_int := nouvF_int.suiv;
			END LOOP;			

			IF (nouvF_int /= null) THEN	
				ajoutrang(nouvF,cpt_loop,ptint.info);
				ptint := ptint.suiv;
				cpt_loop := 1 ;
			ElSE
				ajoutrang(nouvF,cpt_loop,ptint.info);			
				pt_last := pt_before_last.suiv;
				ptint := ptint.suiv;
				cpt_loop := 1 ;
			END IF;	
						
			
		END LOOP;
		mafile.first := nouvF.first;
		mafile.last := pt_last;
	END IF;
END Ordonner;

   PROCEDURE Traiter (ChoixF : IN Integer; maliste : IN OUT File; fini : IN OUT boolean) IS
	-- Cette procédure permet de traiter le choix dans le menu.
      		-- IN OUT
        		 -- maliste: La Liste à traité.
		 	-- fini : booléen qui met fin au menu.
      		-- IN
			-- ChoixF: Le choix de l'utilisateur.
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
	-- Le Menu
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
