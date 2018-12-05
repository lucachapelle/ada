WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;
WITH Ada.Text_IO;
USE Ada.Text_IO;
PROCEDURE Tp2 IS
   N : CONSTANT Integer := 10;
   -- Constante qui représente le nombre de nombre rentrés. Peut être changé sans toucher au programme.

   TYPE Tablo IS ARRAY (1 .. N) OF Integer;
   -- Tableau qui contiendra la suite de nombres entrés.

   TYPE Tablo2 IS ARRAY (0 .. 9) OF Integer;
   -- Tableau qui contiendra les indices qui serviront à re-trier le tableau de la suite de nombres (il contient les chiffres donc de 0 à 9).

   TYPE Matrice IS ARRAY (0..9 , 1..N) OF Integer;
   -- Matrice qui contiendra les nombres triés.
   -- Largeur (0..9) qui correspond à la taille du tableau d'indice.
   -- Longueur (1..N) qui correspond à la taille du tableau des nombres à traiter.


   PROCEDURE Remplir_Tab (TabF1 : OUT Tablo) is
      -- Remplissage du tableau contenant la suite de nombres entré par l'utilisateur.
      -- OUT
      	-- TabF1 : Tableau contenant la suite de nombres.
      Nb : Integer;
      -- Le nombre rentré par l'utilisateur.
   BEGIN
      FOR I IN 1..N LOOP
         -- On connaît le nombre d'element à traiter.
         Put("veuillez rentrer votre nombre : ");
         Get(Nb);
         TabF1(I) := Nb;
      END LOOP;
   END Remplir_Tab;

   PROCEDURE Affiche_Tab (TabF2 : IN Tablo) is
      -- Affichage des nombres contenu dans un tableau.
      -- IN
      	-- TabF2: On affiche les elements du tableau.
   BEGIN
      Put("Voila votre tableau dans l'ordre : ");
      FOR I IN 1..N LOOP
         new_line;
         Put(TabF2(I));
      END LOOP;
   END Affiche_Tab;


   PROCEDURE Remplir_MonTab(Tablo_Indice : IN Tablo2 ;MatriceF : IN Matrice;  TabFin : OUT tablo) IS
      -- Remplissage d'un tableau à partir d'une matrice et d'un tableau d'indince.
      -- IN
      	-- MatriceF : On récupere les éléments de cette matrice.
        -- Tablo_Indice : Ce tableau nous sert à savoir combien il y'a d'elements dans les colonnes de la matrice ( une case du "Tablo_Indice" = une colonne de "MatriceF")
      -- OUT
       	-- TabFin : Le tableau qui contiendra les élements de la matrice.
      k : Integer :=1;
      -- La variable K nous sert d'indice pour remplir le tableau (TabFin).
      -- On decide d'utiliser un indice qu'on incrémente nous même car on ne peut pas utiliser de boucle FOR.
      -- La variable j qui parcourt les colonnes prend plusieurs fois la même valeur donc inutilisable.

      BEGIN
         FOR I IN 0 .. 9 LOOP
         IF Tablo_Indice(I) /= 1 THEN
            -- Si la case du tableau contient un 1 cela veut dire qu'il n'y a pas d'élements dans la colonne de la matrice
            	-- donc pas besoin d'entrer dans la boucle FOR qui gére les colonnes.
            FOR J IN 1 .. Tablo_Indice(I)-1 LOOP
               -- La boucle s'arrête a Tablo_indice(I)-1 car le tablo_indice contient des 1 si il n'y a pas d'élements dans la colonne de la matrice.
                  TabFin(K):= MatriceF(I,J);
                  k:=k+1;
               END LOOP;
            END IF;
         END LOOP;
    END Remplir_MonTab;


   PROCEDURE range_matrice(TabF : IN Tablo; Indice : IN Integer; MatF : OUT matrice; Tab_IndF : OUT tablo2)IS
      -- Le but est de trier les elements d'un tableau et de les ranger dans une matrice. ( Tri par base )
      -- IN
      	-- TabF : Il contient les nombres à trier.
        -- Indice : Il nous sert à savoir si on tri les unites ou les dizaines, etc .
      -- OUT
       -- MatF : La matrice qui contiendra les élements triés. ( Nombres de même unité, ou dizaines ... sont sur la même colonne )
       -- Tab_IndF : Ce tableau nous sert à stocker le nombre d'elements qu'il y a dans les colonnes de la matrice ( une case du "Tab_IndF_Indice" = une colonne de "MatriceF")
      Element : Integer;
      -- Il contiendra les unités ou les dizaines etc... du nombre à trier en fonction de l'indice.
      -- Il nous servira à place le nombre à trier dans la matrice.
   BEGIN

      FOR I IN 0 .. 9 LOOP
         Tab_IndF(I) :=1;
         -- On choisit de l'initialiser à 1 car la variable qui gére les colonnes de la matrice commence à 1.
      END LOOP;

      FOR I IN 1 .. N LOOP
         Element := (TabF(I)/ (10**Indice)) mod 10 ;
         -- Calcul qui nous sert à recuperer les unités ou les dizaines etc du nombre à trier, en fonction de l'indice(0: unité, 1:dizaines etc).
         MatF(Element, Tab_IndF(Element)):=TabF(I);
         Tab_IndF(Element) := Tab_IndF(Element) + 1;
     END LOOP;
  END range_matrice;



   PROCEDURE Tri_Tableau(MonTabF : IN OUT Tablo) IS
      -- Le but est de trier un tableau de nombres entiers.
      -- IN OUT
      	--MonTabF : On recupère les valeurs du tableau et on stock les valeurs triées dans ce même tableau.
      MaMatrice : Matrice;
      --MaMatrice nous servira a trier les éléments du tableau.
      MonTablo_Indice : Tablo2;
      --MonTablo_Indice nous servira pour le tri des elements.
   BEGIN
      FOR I IN 0 .. 3 LOOP
         -- on va jusqu'a 3 car on traite les nombres de 0 a 9999(4 tour de boucles)
         -- I nous servira d'indice pour savoir si on traite les unités ou les dizaines ect .
         Range_Matrice(MonTabF,I,MaMatrice,MonTablo_Indice);
         Remplir_MonTab(MonTablo_Indice,MaMatrice, MonTabF);
   END LOOP;
   end Tri_Tableau;


   MonTab : Tablo;
   --MonTab est le tableau de nombres qu'on veut trier.
   BEGIN
   Remplir_Tab(MonTab);
   Tri_Tableau(MonTab);
   Affiche_Tab(MonTab);

END Tp2;

