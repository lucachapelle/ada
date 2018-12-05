
PACKAGE BODY File_Attente IS

  FUNCTION Est_Vide(FileF: IN File) RETURN Boolean IS
    -- Indique si la Liste est vide ou non.
      --IN
         --FileF: La Liste qui est test�e.

  BEGIN
     RETURN FileF.First = NULL AND FileF.Last = NULL ;
  END Est_Vide;




   PROCEDURE Insere_Debut(FileF: IN OUT File; Elmt: IN elt) IS
   -- Cette proc�dure ajoute un �l�ment en debut de Liste.
      -- IN OUT
         -- FileF: La Liste o� sera retir� l'�l�ment.
      --IN
         --Elmt : L'�l�ment � retirer.

      Pt_Int: Acc_noeud;

   BEGIN
      IF Est_Vide(FileF) THEN
         FileF.First := NEW Noeud'(Elmt,NULL);
         FileF.Last := FileF.First;

      ELSE
         Pt_Int := FileF.First;
         FileF.first := NEW Noeud'(Elmt,PT_Int);
      END IF;

    END Insere_Debut;




   PROCEDURE Insere_Fin(FileF: IN OUT File;
                        Elmt : in elt)  IS
  -- Cette proc�dure ajoute un element en fin de liste.
      -- IN OUT
         -- FileF: La Liste o� l'element sera ajout�.
      -- IN
         -- Elt: L'�l�ment � ajouter.

   BEGIN
      IF Est_Vide(FileF) THEN
         FileF.First := NEW Noeud'(Elmt,NULL);
         FileF.Last := FileF.First;

      ELSE
         FileF.Last.suiv := NEW Noeud'(Elmt,NULL);
         FileF.Last := FileF.Last.Suiv;
      END IF;

   END Insere_Fin;




   PROCEDURE Retirer(FileF: IN OUT File; Elmt : OUT elt) IS
   -- Cette fonction retire un element d'une Liste et stock l'element supprim�.
      -- IN OUT
         --FileF: La Liste o� l'on supprime l'element.
      --OUT
         --Elmt: L'�l�ment supprim� sera stock� ici.

   BEGIN
      IF NOT Est_Vide(FileF) THEN
         Elmt := FileF.first.info;
         FileF.First := FileF.First.suiv;
         IF FileF.First = NULL THEN
            FileF.Last := NULL;
         END IF;
      END IF;
   END Retirer;

END File_Attente;

