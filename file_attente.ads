GENERIC
   TYPE Elt IS PRIVATE;

PACKAGE File_Attente IS

   TYPE File IS PRIVATE;
   File_Vide : CONSTANT File;

  FUNCTION Est_Vide (FileF : IN File) RETURN Boolean;
   -- Indique si la Liste est vide ou non.
      --IN
         --FileF: La Liste qui est testée.

   PROCEDURE Insere_Debut ( FileF : IN OUT File; Elmt   : IN  elt);
   -- Cette procédure ajoute un élément en debut de Liste.
      -- IN OUT
         -- FileF: La Liste où sera retiré l'élément.
      --IN
         --Elmt : L'élément à retirer.


   PROCEDURE Insere_Fin (FileF : IN OUT File; Elmt   : IN  elt);

   -- Cette procédure ajoute un element en fin de liste.
      -- IN OUT
         -- FileF: La Liste où l'element sera ajouté.
      -- IN
         -- Elt: L'élément à ajouter.

   PROCEDURE Retirer (FileF : IN OUT File; Elmt: OUT elt);
   -- Cette fonction retire un element d'une Liste et stock l'element supprimé.
      -- IN OUT
         --FileF: La Liste où l'on supprime l'element.
      --OUT
         --Elmt: L'élément supprimé sera stocké ici.


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




