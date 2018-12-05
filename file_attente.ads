GENERIC
   TYPE Elt IS PRIVATE;

PACKAGE File_Attente IS

   TYPE File IS PRIVATE;
   File_Vide : CONSTANT File;

  FUNCTION Est_Vide (FileF : IN File) RETURN Boolean;
   -- Indique si la Liste est vide ou non.
      --IN
         --FileF: La Liste qui est test�e.

   PROCEDURE Insere_Debut ( FileF : IN OUT File; Elmt   : IN  elt);
   -- Cette proc�dure ajoute un �l�ment en debut de Liste.
      -- IN OUT
         -- FileF: La Liste o� sera retir� l'�l�ment.
      --IN
         --Elmt : L'�l�ment � retirer.


   PROCEDURE Insere_Fin (FileF : IN OUT File; Elmt   : IN  elt);

   -- Cette proc�dure ajoute un element en fin de liste.
      -- IN OUT
         -- FileF: La Liste o� l'element sera ajout�.
      -- IN
         -- Elt: L'�l�ment � ajouter.

   PROCEDURE Retirer (FileF : IN OUT File; Elmt: OUT elt);
   -- Cette fonction retire un element d'une Liste et stock l'element supprim�.
      -- IN OUT
         --FileF: La Liste o� l'on supprime l'element.
      --OUT
         --Elmt: L'�l�ment supprim� sera stock� ici.


PRIVATE
   TYPE Noeud;
   TYPE Acc_Noeud IS ACCESS Noeud;
   TYPE Noeud IS
      RECORD
         Info : elt;
         Suiv : Acc_Noeud;
      END RECORD;

   TYPE File IS
      RECORD
         First : Acc_Noeud;
         Last  : Acc_Noeud;
      END RECORD;

   File_Vide : CONSTANT File := (NULL, NULL);

END File_Attente;




