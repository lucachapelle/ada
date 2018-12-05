WITH Ada.Integer_Text_IO;
WITH Ada.Text_IO;

USE Ada.Integer_Text_IO;
USE Ada.Text_IO;



PACKAGE BODY ChapelleKerichePile IS




   PROCEDURE Empiler(PF: IN OUT Pile; Elt: IN Integer ) iS
   -- Cette procédure ajoute un element à la pile.
   
      -- IN OUT
         -- PF: La pile où l'element sera ajouté.
		 
      -- IN
         -- Elt: L'élément à ajouté.
		 
   BEGIN
      PF := NEW Noeud'(Elt,PF);
   END Empiler;

   Function Est_Vide(PF: IN Pile) return boolean is
   -- Nous informe si la pile est vide ou non.
   
      --IN
         --PF: La pile qui sera testée.
		 
   BEGIN
      RETURN PF = NULL;
   END Est_Vide;

   
   
   
   PROCEDURE Depiler( PF: IN OUT Pile ; Elt_Stocke: out integer) is
   -- Cette procédure stocke l'élément et le retire de la pile.
   
      -- IN OUT
         -- PF: La pile où sera retiré l'élément.
	  
	  -- OUT
		-- Elt_Stocke : L'element stocké.
		
   BEGIN
      IF NOT Est_Vide(PF) THEN
         Elt_Stocke := PF.info;
         PF:=PF.Suiv;
      END IF;
   END Depiler;

   
   
   
   PROCEDURE Affiche_Pile(PF: IN Pile) IS
   -- Permet d'afficher les éléments d'une pile.
   
      --IN
         --PF: Les éléments de cette pile seront affichés.
		 
   P_Int: Pile;

   BEGIN
      IF NOT Est_Vide(PF) THEN
         P_Int := PF;
         WHILE NOT Est_Vide(PF) LOOP
            Put(P_Int.Info);New_Line;
            P_Int := P_Int.Suiv;
         END LOOP;
      ELSE
         Put("La pile est vide.");
      END IF;

   END Affiche_Pile;
   
   
   

END ChapelleKerichePile;


