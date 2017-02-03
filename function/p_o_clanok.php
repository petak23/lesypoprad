<?php
/* Tento súbor slúži na obsluhu pridania/opravy článku
   Zmena: 05.11.2011 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

  /*-------- Časť zápisu do databázy    ---------- */
function pridaj_clanok()
  /* Funkcia skontroluje vstupy a zapíše clanok do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 02.09.2011 - PV
  */
{
$datum=StrFTime("%Y-%m-%d %H:%M:%S", Time()); //Aby sa mi to prenieslo do funkcie; 
$nazov=ltrim(strip_tags($_POST["nazov"])); // Odstránenie HTML tagov z názvu a medzier na začiatku
if (strlen($nazov)<2) return "Nadpis musí mať aspoň 2 písmená!";
$ucast=@(int)$_POST["ucast_t"];
$mazanie=@(int)$_POST["mazanie"];
if(@(int)$_POST["id_ikonka1"]==1) $id_ikonka=-1;
else $id_ikonka=@(int)$_POST["id_ikonka"];
if (@(int)$_POST["id_typ"]==1) {
 $typ=1;
 if (!kontrola_datumu($_POST["datum_platnosti"])) return "Chybný dátum platnosti!"; //Kontrola na RRRR-MM-DD a existenciu datumu 
 else {$dat_pl1="datum_platnosti,"; $dat_pl2="'".$_POST["datum_platnosti"]."',";}
}
else { $typ=0; $dat_pl1=""; $dat_pl2="";};
if (@(int)$_POST["id_hlavne_menu"]<>0) $id_hlavne_menu=(int)$_POST["id_hlavne_menu"]; else return "Položka hlavného menu musí byť vybraná";
if (@(int)$_POST["podclanok"]>-1) $podclanok=(int)$_POST["podclanok"]; else return "Položka podčlánku musí byť vybraná";
$text=stripslashes( $_POST["CKeditor01"] );
$pridanie_clanku=mysql_query("INSERT INTO clanok (datum, $dat_pl1 nazov, text, id_clena, id_typ, id_reg, id_ikonka, id_hlavne_menu, podclanok, mazanie)
                              VALUES('$datum', $dat_pl2 '$nazov','$text', ".$_POST["id_clena"].", $typ, ".$_POST["id_reg"].", '$id_ikonka', $id_hlavne_menu, $podclanok, $mazanie)");
if (!$pridanie_clanku) return mysql_error();
if (@(int)$_POST["hlavny_clanok"]>0){ //Idem nastavovať hlavný článok pre danú časť menu
  $hl_id_clanku=mysql_query("SELECT id_clanok FROM clanok WHERE nazov='$nazov' AND datum='$datum' LIMIT 1");//Nájdenie id pridaného článku
  if (!$hl_id_clanku) return mysql_error();
  $id_clan = mysql_fetch_array($hl_id_clanku);
  $oprava_hl_clanku=mysql_query("UPDATE hlavne_menu SET clanok = $id_clan[id_clanok] WHERE id_hlavne_menu=".$_POST["id_hlavne_menu"]." LIMIT 1");
  if (!$oprava_hl_clanku) return mysql_error();
}
return "ok";
}

function oprav_clanok()
  /* Funkcia skontroluje vstupy a aktualizuje clanok v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 02.09.2010 - PV
  */
{

$nazov=ltrim(strip_tags($_POST["nazov"])); // Odstránenie HTML tagov z názvu a medzier na začiatku
if (strlen($nazov)<2) return "Nadpis musí mať aspoň 2 písmená!";
$ucast=@(int)$_POST["ucast_t"];
$mazanie=@(int)$_POST["mazanie"];
if(@(int)$_POST["id_ikonka1"]==1) $id_ikonka=-1;
else $id_ikonka=@(int)$_POST["id_ikonka"];
if (@(int)$_POST["id_typ"]==1) {
 $typ=1;
 if (!kontrola_datumu($_POST["datum_platnosti"])) return "Chybný dátum platnosti!"; //Kontrola na RRRR-MM-DD a existenciu datumu 
 else $dat_pl="datum_platnosti = '".$_POST["datum_platnosti"]."',";
}
else { $typ=0; $dat_pl="";}
if (@(int)$_POST["id_hlavne_menu"]<>0) $id_hlavne_menu=@(int)$_POST["id_hlavne_menu"]; else return "Položka hlavného menu musí byť vybraná";
if (@(int)$_POST["podclanok"]>-1) $podclanok=(int)$_POST["podclanok"]; else return "Položka podčlánku musí byť vybraná";
$text=stripslashes( $_POST["CKeditor01"] );
$oprava_clanku=mysql_query("UPDATE clanok SET $dat_pl nazov = '$nazov',
                                        text = '$text', id_clena = ".$_POST["id_clena"].", id_typ=$typ,
										id_reg = ".$_POST["id_reg"].", id_ikonka = $id_ikonka,
										id_hlavne_menu=$id_hlavne_menu, podclanok=$podclanok, mazanie = $mazanie
										WHERE id_clanok = ".$_POST["id_clanok"]." LIMIT 1 ");
if (!$oprava_clanku) return mysql_error();
if (@(int)$_POST["hlavny_clanok"]>0){ //Idem nastavovať hlavný článok pre danú časť menu
  $oprava_hl_clanku=mysql_query("UPDATE hlavne_menu SET clanok = ".$_POST["id_clanok"]." WHERE id_hlavne_menu=".$_POST["id_hlavne_menu"]." LIMIT 1");
  if (!$oprava_hl_clanku) return mysql_error();
}
return "ok";
}

function vymaz_clanok()
  /* Funkcia vymaže článok z databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 05.11.2011 - PV
  */
 {
/*$vymaz_clanku=prikaz_sql("DELETE FROM clanok WHERE id_clanok=".$_REQUEST["id_clanok"],
                         "Zmazanie článku(".__FILE__ ." on line ".__LINE__ .")","");*/
$hl_id_clanku=mysql_query("SELECT clanok FROM hlavne_menu WHERE id_hlavne_menu=".$_POST["id_hlavne_menu"]." LIMIT 1");//Nájdenie id hlavne menu článku
if (!$hl_id_clanku) return mysql_error();
$id_hlm = mysql_fetch_array($hl_id_clanku);
if ($id_hlm["clanok"]==$_POST["id_clanok"]) { //Zisti či to je hlavný článok pre danú časť
 $vymaz_id_clanku=mysql_query("UPDATE hlavne_menu SET clanok = NULL WHERE id_hlavne_menu=".$_POST["id_hlavne_menu"]." LIMIT 1 ");						 
 if (!$vymaz_id_clanku) return mysql_error(); 
 $vymaz_clanku=mysql_query("UPDATE clanok SET zmazane = 1 WHERE id_clanok = ".$_POST["id_clanok"]." LIMIT 1 ");						 
 if (!$vymaz_clanku) return mysql_error();
 $vys_podclanok=mysql_query("UPDATE clanok SET zmazane = 1 WHERE id_hlavne_menu = ".$_POST["id_clanok"]." AND podclanok>0");
 if (!$vys_podclanok) return mysql_error();
}
return "ok";
}

  /* --- Pridanie/Oprava článku ak bola daná požiadavka --- */
if ($operacia=="Pridaj")   $vysledok=pridaj_clanok();   
elseif($operacia=="Oprav") $vysledok=oprav_clanok();
  /* --- Vymazanie článku ak bola daná požiadavka --- */
elseif ($operacia=="Áno")  {
 $vysledok=vymaz_clanok(); 
 $co=" ";
 $operacia="vymazane";
}
?>
