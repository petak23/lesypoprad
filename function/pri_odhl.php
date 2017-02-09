<?php
/* Tento súbor slúži na spracovanie údajov pri prihlásení
   Stavové premenné:
    $id_clena=-1 - Chybne zadané meno alebo heslo
    $id_clena=0  - Dobre zadané meno a heslo ale nedokončená registrácia
    $id_clena>0  - Dobre zadané meno a heslo a hodnota je id_clena z DB
    -----------------
    $chyba_pr=1  - Správne prihlásený člen
    inak $chyba_pr=$id_clena
   Zmena: 12.06.2011 - PV
*/
if ($bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
/* ----- Prihlasenie člena ----- */
if (@$_REQUEST["prihlas_tlac"]=="Prihlás"){  
 $vysledok=prikaz_sql("SELECT id_clena, id_reg FROM clenovia WHERE prezyvka='".$_REQUEST["prihlas_meno"]."' and heslo='".md5($_REQUEST["prihlas_heslo"])."'",
                      "Prihlásenie člena (".__FILE__ ." on line ".__LINE__ .")","");
 if (@mysql_num_rows($vysledok)==0) $id_clena=-1; // !!! Chybné meno alebo heslo $id_clena=-1
 else {                                           // K zadaným údajom sa našiel člen v DB
   $riadok = mysql_fetch_array($vysledok);        // Načítanie údajov
   if ($riadok["id_reg"]<1) $id_clena=0;          // Neregistrovaný $id_clena=0;
   else $id_clena=$riadok["id_clena"];            // V poriadku
 }
 if ($id_clena>0) {                               // Ak je všetko v poriadku $id_clena>0(id_clana z DB);
  $_SESSION["id"]=$id_clena;
  $_SESSION["prezyvka"]=$_POST["prihlas_meno"];
  $chyba_pr=1;                                    // Ak je všetko v poriadku $chyba_pr=1 
  $posledne_prihlasenie=prikaz_sql("SELECT prihlas_teraz FROM clenovia WHERE id_clena=$id_clena LIMIT 1",
                                   "Posledné prihlásenie a počet (".__FILE__ ." on line ".__LINE__ .")", "");
  if ($posledne_prihlasenie>0) { //Nájdenie posledného prihlásenia
    $zaz_posl = mysql_fetch_array($posledne_prihlasenie);
    $_SESSION["dat_pr"]=$zaz_posl["prihlas_teraz"]; //Predchádzajúce prihlásenie
    $datum = StrFTime("%Y-%m-%d %H:%M:%S", Time());
    $vysl=prikaz_sql("INSERT INTO prihlasenie VALUES ($id_clena, '$datum')","Zápis času do prihlasenia (function|prihlasenie.php)","");
    $update_prihlasenie=prikaz_sql("UPDATE clenovia SET pocet_pr=pocet_pr+1, prihlas_teraz='$datum', prihlas_predtym='$zaz_posl[prihlas_teraz]' WHERE id_clena=$id_clena",
                                   "Aktualizacia údajov o prihlásení(".__FILE__ ." on line ".__LINE__ .")","");
  }
  $_REQUEST["prihlas_meno"]="";
  $_REQUEST["prihlas_heslo"]="";
 }
 elseif ($id_clena<1) $chyba_pr=$id_clena;
}
/* ------ Odhlásenie registrovaného uživateľa ------ */
if (@$_REQUEST["odhlas"]=="odhlas"){  
 $_SESSION["id"]="";
 $_SESSION["prezyvka"]="";
 $chyba_pr=1;
 $_SESSION["dat_pr"]="";
 unset($_SESSION["id"]);
 unset($_SESSION["prezyvka"]);
 unset($_SESSION["dat_pr"]);
}