WITH Ada.Integer_Text_IO;
WITH Ada.Text_IO;

USE Ada.Integer_Text_IO;
USE Ada.Text_IO;



PACKAGE BODY ChapelleKerichePile IS




   PROCEDURE Empiler(PF: IN OUT Pile; Elt: IN Integer ) iS
   -- Cette proc�dure ajoute un element � la pile.
   
      -- IN OUT
         -- PF: La pile o� l'element sera ajout�.
		 
      -- IN
         -- Elt: L'�l�ment � ajout�.
		 
   BEGIN
      PF := NEW Noeud'(Elt,PF);
   END Empiler;

   Function Est_Vide(PF: IN Pile) return boolean is
   -- Nous informe si la pile est vide ou non.
   
      --IN
         --PF: La pile qui sera test�e.
		 
   BEGIN
      RETURN PF = NULL;
   END Est_Vide;

   
   
   
   PROCEDURE Depiler( PF: IN OUT Pile ; Elt_Stocke: out integer) is
   -- Cette proc�dure stocke l'�l�ment et le retire de la pile.
   
      -- IN OUT
         -- PF: La pile o� sera retir� l'�l�ment.
	  
	  -- OUT
		-- Elt_Stocke : L'element stock�.
		
   BEGIN
      IF NOT Est_Vide(PF) THEN
         Elt_Stocke := PF.info;
         PF:=PF.Suiv;
      END IF;
   END Depiler;

   
   
   
   PROCEDURE Affiche_Pile(PF: IN Pile) IS
   -- Permet d'afficher les �l�ments d'une pile.
   
      --IN
         --PF: Les �l�ments de cette pile seront affich�s.
		 
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


