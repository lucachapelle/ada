WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;
WITH Ada.Strings;
USE Ada.Strings;
WITH Ada.Strings.Unbounded;
USE Ada.Strings.Unbounded;
WITH Ada.Strings.Unbounded.Text_IO;
USE Ada.Strings.Unbounded.Text_IO;
WITH Ada.Text_IO;
USE Ada.Text_IO;
WITH ChapelleKerichePile;
USE ChapelleKerichePile;


--********************************************* Chapelle luca ___ Keriche Kevin ***************************************


PROCEDURE PolonaiseInversee IS

   -- ***********************************************************************************

   FUNCTION GetTerme RETURN Unbounded_String IS
      -- BUT : Procedure qui permet d'obtenir le terme suivant dans la ligne de commande terminee par =
      -- Attention : cette fonction suppose que chaque terme est separe du suivant par au moins un espace
      -- VALEUR RETOURNEE  ********************************************
      -- une chaine qui represente le terme

      Terme : Unbounded_String := Null_Unbounded_String;
      -- le terme que je construis caractère par caractère et qui sera le resultat de ma fonction
      Cc : Character;
      -- le caractere courant
   BEGIN
      -- obtenir un caractère
      Get(Cc);
      -- sauter tous les espaces
      WHILE Cc = ' ' LOOP
         Get(Cc);
      END LOOP;
      -- prendre les caracteres de l'usager tantque l'on n'est pas sur un espace
      -- les concatener (operateur &) pour creer le terme
      -- le cas du terme = est particulier car il n'est pas suivi d'un espace

      WHILE Cc/= ' ' AND Cc/='=' LOOP
         Terme:= Terme & Cc;
         Get(Cc);
      END LOOP;
      -- cas particulier du = : c'est un  terme a part entiere a creer
      IF Cc = '='
            THEN
         Terme := Terme & Cc;
      END IF;

      RETURN Terme;
   END GetTerme;
   --------------------------------------------------------------------------------------------------------------------------------

   -- ********************************************** PROGRAMME PRINCIPALE **************************************************

   PROCEDURE Traiter (  TermeF       : 	 IN     Unbounded_String;
						PileF         : 	 IN OUT Pile;
						Divise_zero 	:    OUT Boolean;
						Resultat        :    OUT Integer ) IS
	
	
	-- BUT : Empile les termes d'une expression et selon l'operateur les calcule puis les dépile. 
	
		-- IN
			-- TermeF : Le terme de l'expression qui sera traité.
			
		-- IN OUT
			-- PileF : C'est ici où les termes seront empilés et dépilés.
			
		-- OUT
			-- Divise_zero : Booléen qui indique si une division par 0 est effectuée.
			
			-- Resultat : Contiendra le résultat de l'expression.
		

      X              : Integer;                   -- Premier entier rencontré dans l'expression.
      Y              : Integer;                   -- Second entier rencontré dans l'expression.
      Res            : Integer          := 0;     -- Resultat de l'expression.
      Estdiviserzero : Boolean          := False; -- Indique si une division par 0 est éxecutée.
      MonTerme       : Unbounded_String;		  -- Le terme de l'expression.
  
  
  BEGIN
  
      MonTerme := TermeF; -- Terme de l'expression.
	  
      WHILE MonTerme /= "=" LOOP
	  
         IF MonTerme /= "+" AND MonTerme /= "-" AND MonTerme /= "*" AND MonTerme /= "/" THEN
            Empiler(PileF,Integer'Value(To_String(MonTerme)));
         ELSE
            Depiler(PileF,X);
            Depiler(PileF,Y);

            IF MonTerme = "+" THEN
               Res := X+Y;
            ELSIF MonTerme ="-" THEN
               Res := Y-X;
            ELSIF MonTerme ="*" THEN
               Res := X*Y;
            ELSIF MonTerme ="/" THEN

               IF X = 0 THEN
                  Estdiviserzero := True;
                  -- Test si le denominateur de la division est 0.
               ELSE

                  Res := Y/X;
               END IF;
            END IF;

            Empiler(PileF, Res);

         END IF;
         MonTerme:=GetTerme;

      END LOOP;
	  
      Divise_zero := Estdiviserzero;
      Resultat := Res;
	  
   END Traiter;
   
   

   PROCEDURE Affiche (  Estdiviserzero : IN     Boolean;
						Fini           : IN     Boolean;
						PileF          : IN OUT Pile     ) IS
	
	-- BUT : Affichera le resultat de l'expression ou une erreur commise.
	
		-- IN
			-- -Divise_zero : Booléen qui indique si une division par 0 est effectuée.
			
			-- Fini : Booléen qui indique si le programme est terminé.
			
		-- IN OUT
			-- PileF : La pile où est stocké l'expression.  			
		
	
	Res : Integer; -- contiendra le resultat de l'expression.
   BEGIN
   
      IF Estdiviserzero THEN
         Put ("la division par 0 est impossible");
         New_Line;
		 
		 -- Test si la division par 0  a été effectué .. 

      ELSIF NOT Estdiviserzero AND NOT Fini THEN
         Depiler(PileF,Res);
         Put("le resultat est : ");
         Put(Res);
         New_Line;
			
		--	.. et si le programme est fini.        

      END IF;

   END Affiche;


   MonTerme       : Unbounded_String;          -- contiendra les termes successifs
   Mapile         : Pile;                      -- contiendra les entiers de l'expression.
   Fini           : Boolean          := False; -- Indique si le programme est fini.
   Res            : Integer          := 0;     -- Resultat de l'expression.
   Estdiviserzero : Boolean          := False; -- Indique si la division par 0 est effectué.
BEGIN

   
   WHILE NOT Fini LOOP
      Mapile := Pile_Vide; 				-- initialisation de la pile à vide.
      Put("rentrez votre chaine : ");
      MonTerme := GetTerme;
      Fini := MonTerme = "="; 			-- Test si l'expression commence par "=".

      Traiter (Monterme, MaPile, Estdiviserzero, Res);

      Affiche (Estdiviserzero,Fini,MaPile);

      Estdiviserzero := False;
   END LOOP;
   Put("c est fini");
   New_Line;
   

END PolonaiseInversee;









