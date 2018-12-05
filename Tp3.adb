WITH File_Attente;


WITH Ada.Integer_Text_Io;
USE Ada.Integer_Text_Io;
WITH Ada.Text_IO;
USE Ada.Text_IO;
WITH Ada.Strings.Unbounded;
USE Ada.Strings.Unbounded;
WITH Ada.Strings.Unbounded.Text_IO;
USE Ada.Strings.Unbounded.Text_IO;
----------------------------------------------------------------------------------
PROCEDURE Tp3 IS

   TYPE Produit IS
         (A,  B,  C);
   PACKAGE ProduitIO IS NEW Enumeration_Io(Produit);
   USE Produitio;


   TYPE Clients IS
      RECORD
         Nom  : Unbounded_String;
         Prod : Produit;
         Qte  : Integer;
      END RECORD;

   PACKAGE File_Attente_Cl IS NEW File_Attente(Clients);
   USE File_Attente_Cl;


   TYPE Tab_Stock IS ARRAY (Produit) OF Integer;

   TYPE Tab_Client IS ARRAY (Produit) OF File;



   ----------------------------------------------------------------------------------
   PROCEDURE RecupinfoStock (
         TasF :    OUT Produit;
         NbF  :    OUT Integer) IS
   BEGIN
      Put("Quel est le produit en livraison ? ");
      New_Line;
      Get(TasF);
      Put("Quelle quantité avez vous de ce produit ? ");
      New_Line;
      Get(Nbf);
   END RecupinfoStock;
   ----------------------------------------------------------------------------------
   PROCEDURE TraiterStock (
         Tas    : IN     Produit;
         Nb     : IN     Integer;
         StockF : IN OUT Tab_Stock) IS
   BEGIN
      StockF(TAS) := StockF(TAS) + Nb;
   END TraiterStock;

   ----------------------------------------------------------------------------------
   PROCEDURE Afficheclientservi (
         ClientServiF : IN     Clients) IS
   BEGIN
      Put("Le client ");
      Put(ClientServiF.Nom);
      Put(" a été servi de ");
      Put(Integer'Image(ClientServiF.Qte));
      Put(" ");
      Put(ClientServiF.Prod);
      New_Line;
   END Afficheclientservi;
   ----------------------------------------------------------------------------------
   PROCEDURE Afficheattente (
         Client : IN     Clients;
         Servi  : IN     Integer) IS
   BEGIN
      IF Servi /= 0 THEN
         Put("Le client ");
         Put(Client.Nom);
         Put(" a été partiellement servi de ");
         Put(Integer'Image(Servi));
         Put(" ");
         Put(Client.Prod);
         Put(" en attente de ");
         Put(Integer'Image(Client.Qte));
         Put(" ");
         Put(Client.Prod);
         New_Line;
      ELSE
         Put("Le client ");
         Put(Client.Nom);
         Put(" est en attente de ");
         Put(Integer'Image(Client.Qte));
         Put(" ");
         Put(Client.Prod);
         New_Line;
      END IF;

   END Afficheattente;
   ----------------------------------------------------------------------------------
   PROCEDURE TraiterClientPrio (
         InfoClient : IN     Clients;
         AttenteF   : IN OUT Tab_Client;
         Stock      : IN OUT Tab_Stock) IS
      Client : Clients := InfoClient;

   BEGIN
      IF Client.Qte <= Stock(Client.Prod) THEN
         Stock(Client.Prod) := Stock(Client.Prod) - Client.Qte;
         Afficheclientservi(Client);
      ELSE
         Client.Qte := Client.Qte - Stock(Client.Prod);
         Afficheattente(Client,Stock(Client.Prod));
         Stock(Client.Prod) := 0;

         Insere_Debut(AttenteF(Client.Prod),Client);

      END IF;

   END TraiterClientPrio;

   ----------------------------------------------------------------------------------
   PROCEDURE Teststock (
         Stock   : IN OUT Tab_Stock;
         Stockde : IN     Produit;
         ATTENTE : IN OUT Tab_Client) IS
      Client : Clients;
   BEGIN
      WHILE Stock(Stockde) > 0 AND NOT(Est_Vide(Attente(Stockde))) LOOP
         Retirer(Attente(Stockde),Client);
         TraiterClientPrio(Client,Attente,Stock);
      END LOOP;
   END Teststock;

   ----------------------------------------------------------------------------------
   PROCEDURE RecupInfo (
         InfoClientF :    OUT Clients) IS
   BEGIN
      Put("Quelle est le nom du client ?");
      New_Line;
      Skip_Line;
      InfoClientF.Nom := Get_Line;
      Put("Quel est le produit desiré ?");
      New_Line;
      Get(InfoClientF.Prod);
      Put("Quelle est la quantité du produit?");
      New_Line;
      Get(InfoClientF.QTE);
   END RecupInfo;
   ----------------------------------------------------------------------------------
   PROCEDURE Affiche (
         Stockde : IN     Produit;
         StockF   : IN     Tab_Stock) IS

   BEGIN
      Put("Stock restant du produit ");
      Put(Stockde);
      Put(" : ");
      Put(Integer'Image(StockF(Stockde)));
      New_Line;
   END Affiche;

   --------------------------------------------------------------------------------
   PROCEDURE TraiterClient (
         InfoClient : IN     Clients;
         AttenteF   : IN OUT Tab_Client;
         Stock      : IN OUT Tab_Stock) IS
      Client : Clients := InfoClient;

   BEGIN
      IF Client.Qte <= Stock(Client.Prod) THEN
         Stock(Client.Prod) := Stock(Client.Prod) - Client.Qte;
         Afficheclientservi(Client);
         Affiche (Client.Prod,Stock);

         ELSE
         Client.Qte := Client.Qte - Stock(Client.Prod);
         Afficheattente(Client,Stock(Client.Prod));
         Stock(Client.Prod) := 0;

         Insere_Fin(AttenteF(Client.Prod),Client);

      END IF;

   END TraiterClient;

   ----------------------------------------------------------------------------------
   PROCEDURE Traiter (
         ChoixF   : IN     Integer;
         AttenteF : IN OUT Tab_Client;
         StockF   : IN OUT Tab_Stock;
         Fini     : IN OUT Boolean) IS

      InfoClient : Clients;
      Tas        : Produit;
      Nb         : Integer;
   BEGIN
      CASE ChoixF IS
         WHEN 1 =>
            RecupinfoStock(Tas,Nb);
            TraiterStock(Tas,Nb,StockF);
            Teststock(StockF,Tas, Attentef);
         WHEN 2 =>
            RecupInfo(InfoClient);
            TraiterClient(InfoClient,AttenteF,StockF);
         WHEN 3 =>
            Fini := True;
         WHEN OTHERS =>
            Put("Erreur : Action non valide.");
            New_Line;

      END CASE;
   END Traiter;
   ----------------------------------------------------------------------------------
   Choix   : Integer;
   Attente : Tab_Client := (OTHERS => File_Vide);
   Stock   : Tab_Stock  := (OTHERS => 0);
   Fini    : Boolean    := False;
BEGIN

   LOOP
      Put ("Appuyer sur 1 pour une livraison");
      New_Line;
      Put("Appuyer sur 2 pour servir un client");
      New_Line;
      Put("Appuyer sur 3 pour quitter." );
      New_Line;
      Get(Choix);
      New_Line;
      Traiter (Choix,Attente,Stock,Fini);
      EXIT WHEN Fini;
   END LOOP;
END Tp3;