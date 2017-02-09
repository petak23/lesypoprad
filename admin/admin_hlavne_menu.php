<?php
/* Tento súbor slúži na obsluhu pridania/opravy Hlavného menu
   Zmena: 02.09.2011 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Pridanie/Oprava Hlavného menu a výpis položiek</h2><br />");

//Inicializácia premených
$min_idd=prikaz_sql("SELECT id_hlavne_menu FROM hlavne_menu ORDER BY id_hlavne_menu","Id hl. menu (".__FILE__ ." on line ".__LINE__ .")","");
if ($min_idd){
 $rob=true;
 $id_hlavne_menu=0; //id položky - určuje poradie
 while($min_id=mysql_fetch_array($min_idd) AND $rob){//Pre nájedenie min hodnoty id_hlavne_menu , ktorá ešte nie je použitá
  if ($id_hlavne_menu==$min_id["id_hlavne_menu"] AND $rob) $id_hlavne_menu++;
  else $rob=false;
 }
} 
 $nazov="";     //Zobrazený názov
 $title="";     //Zobrazený titulok
 $kl_skratka="";//Klávesová skratka
 $clanok="";    //Priradený článok alebo základná položka ak je sub. menu
 $id_reg=0;     //Úroveň registrácie
 $id_blok=1;    //Usporiadanie stránky
 $zvyrazni=0;   //Sledovanie zmien a zvyraznenie
 $id_hlavicka=0;//Aká hlavička sa má zobraziť pre danú položku
 $clanky=0;     //Či je možné k danej položke priradiť články
 $description="";//Širší popis danej stránky
 $vysledok="";  //Výsledok zápisu do DB 

  /*-------- Časť zápisu do databázy    ---------- */ 
function pridaj_hlavne_menu()
 /* Funkcia zapíše položku hlavného menu do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 13.06.2011 - PV
  */
{
if (@(int)$_REQUEST["pr_zvyrazni"]>0) $zvyrazni=(int)$_REQUEST["pr_zvyrazni"]; else $zvyrazni=0;
if (@(int)$_REQUEST["id_hlavicka"]>0) $id_hlavicka=(int)$_REQUEST["id_hlavicka"]; else $id_hlavicka=0;
if (@(int)$_REQUEST["clanky_f"]>0) $clanky=(int)$_REQUEST["clanky_f"]; else $clanky=0;            
$pridanie_hlavne_menu=mysql_query("INSERT INTO hlavne_menu (id_hlavne_menu, nazov, title, kl_skratka, clanok, id_reg, id_blok, zvyrazni, id_hlavicka, clanky, description) 
                                   VALUES(".$_REQUEST["id_hlavne_menu_f"].", '".$_REQUEST["nazov_f"]."', '".$_REQUEST["title_f"]."', '".$_REQUEST["kl_skratka_f"]."', '".$_REQUEST["clanok_f"]."',
								   ".$_REQUEST["id_reg"].", ".$_REQUEST["pr_id_blok"].", $zvyrazni, $id_hlavicka, $clanky, '".$_REQUEST["description_f"]."')");
if (!$pridanie_hlavne_menu) return mysql_error();
return "ok";
}

function oprav_hlavne_menu()
 /* Funkcia aktualizuje položku hlavného menu v databáze.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 02.09.2011 - PV
  */
{
$id_hlavne_menu=(int)$_REQUEST["id_hlavne_menu_f"];
if (@(int)$_REQUEST["pr_zvyrazni"]>0) $zvyrazni=(int)$_REQUEST["pr_zvyrazni"]; else $zvyrazni=0;
if (@(int)$_REQUEST["id_hlavicka"]>0) $id_hlavicka=(int)$_REQUEST["id_hlavicka"]; else $id_hlavicka=0;
if (@(int)$_REQUEST["clanky_f"]>0) $clanky=(int)$_REQUEST["clanky_f"]; else $clanky=0;
$oprava_hlavne_menu=mysql_query("UPDATE hlavne_menu SET id_hlavne_menu=$id_hlavne_menu, nazov='".$_REQUEST["nazov_f"]."',
														title='".$_REQUEST["title_f"]."', kl_skratka='".$_REQUEST["kl_skratka_f"]."',
                                                        clanok='".$_REQUEST["clanok_f"]."', 
                                                        id_reg=".$_REQUEST["id_reg"].", id_blok=".$_REQUEST["pr_id_blok"].",
														zvyrazni=$zvyrazni, id_hlavicka=$id_hlavicka, clanky=$clanky, description='".$_REQUEST["description_f"]."'
					             WHERE id_hlavne_menu=".$_REQUEST["id_hlavne_menu_old"]." LIMIT 1"); 
if (!$oprava_hlavne_menu) return mysql_error();
return "ok";
}
  /* --- Pridanie/Oprava položky hlavného menu ak bola daná požiadavka --- */
if (@$_REQUEST["hlavne_menu_rob"]=="Pridaj")    $vysledok=pridaj_hlavne_menu();
elseif (@$_REQUEST["hlavne_menu_rob"]=="Oprav") $vysledok=oprav_hlavne_menu();

  /* ----------- Časť spracovania formulára ---------- */
if ($vysledok<>"") { // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!:<BR>$vysledok");
    $id_hlavne_menu=$_POST["id_hlavne_menu_f"];  // Opätovné načítanie údajou ak došlo k chybe
    $nazov=$_POST["nazov_f"];
	$title=$_POST["title_f"];
	$kl_skratka=$_POST["kl_skratka_f"];
    $clanok=$_POST["clanok_f"];
	$id_reg=$_POST["id_reg"];
	$id_blok=$_POST["pr_id_blok"];
	if (@(int)$_REQUEST["pr_zvyrazni"]>0) $zvyrazni=(int)$_REQUEST["pr_zvyrazni"]; else $zvyrazni=0;
    if (@(int)$_REQUEST["id_hlavicka_f"]>0) $id_hlavicka=(int)$_REQUEST["id_hlavicka_f"]; else $id_hlavicka=0;
    if (@(int)$_REQUEST["clanky_f"]>0) $clanky=(int)$_REQUEST["clanky_f"]; else $clanky=0;
	$description=$_REQUEST["description_f"];
  }
  else {                // Správny zápis aktualizácie do DB
    echo("<div class=st_dobre>Položka hlavného menu bola ");  //Vypísanie info o operácii
    if (@$_REQUEST["hlavne_menu_rob"]=="Pridaj") echo("pridaná!");   
    elseif(@$_REQUEST["hlavne_menu_rob"]=="Oprav") echo("opravená!");
    else echo("zmenená!");
    echo("</div>");
  }
}  
echo("<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>"); // Začiatok formulára pre zadanie údajov
if (@$_REQUEST["operacia"]=="adm_edit_hlavne_menu"){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených
  $navrat_e=prikaz_sql("SELECT * FROM hlavne_menu WHERE id_hlavne_menu=".$_REQUEST["id"]." LIMIT 1",
                       "Načítanie položky hl. menu (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");
  if ($navrat_e) { //Ak bola požiadavka do DB úspečná
   $zaz_e = mysql_fetch_array($navrat_e);
   $id_hlavne_menu=$zaz_e["id_hlavne_menu"];
   $nazov=$zaz_e["nazov"];
   $title=$zaz_e["title"];
   $kl_skratka=$zaz_e["kl_skratka"];
   $clanok=$zaz_e["clanok"];
   $id_reg=$zaz_e["id_reg"];
   $id_blok=$zaz_e["id_blok"];
   $zvyrazni=$zaz_e["zvyrazni"];
   $id_hlavicka=$zaz_e["id_hlavicka"];
   $clanky=$zaz_e["clanky"];
   $description=$zaz_e["description"];
   echo("<input type=\"hidden\" name=\"id_hlavne_menu_old\" value=$id_hlavne_menu>"); 
  }
}  
echo("<div id=admin><fieldset>"); //Samotny formular na zadanie
form_pole("id_hlavne_menu_f","ID položky",$id_hlavne_menu,"POZOR! táto položka určuje poradie ale NESMIE sa opakovať!!!", 5);
form_pole("nazov_f","Zobrazený názov",$nazov,"", 40);
form_pole("title_f","Titulok",$title,"", 50);
form_pole("description_f","Popis",$description,"", 255, 80);
form_pole("kl_skratka_f","Klávesová skratka",$kl_skratka,"", 5);
form_pole("clanok_f","Názov priradeného článku",$clanok,"Potrebné ak je navigácia cez súbor *_info.php, alebo číslo článku ako základná položka.", 30);
form_registr("id_reg", $id_reg, 5);
echo("<input type=\"hidden\" name=\"pr_id_blok\" value=0>"); //Typ rozdelenia stránky 0 - Ľavá+Stred
echo("<input type=\"hidden\" name=\"id_hlavicka\" value=0>"); //Ak požiadavka nebola úspešná veľká hlavička
form_zaskrt("pr_zvyrazni", "Zvyraznenie pri zmene", $zvyrazni);
form_zaskrt("clanky_f", "Je možné priradiť články", $clanky);
echo("<input name=\"hlavne_menu_rob\" id=\"hlavne_menu_rob\" type=\"submit\" value=\"");
echo(@$_REQUEST["id"]<>"" ? "Oprav" : "Pridaj");
echo("\"></fieldset></form></div>");

  /* ----- Výpis všetkých položiek hl. menu ----- */
$navrat=prikaz_sql("SELECT id_hlavne_menu, hlavne_menu.nazov as hnazov, title, kl_skratka, clanok, registracia.nazov as rnazov, registracia.id as id_reg, zvyrazni,
                    clanky, description, pocitadlo
                    FROM hlavne_menu, registracia 
                    WHERE hlavne_menu.id_reg=registracia.id 
                    ORDER BY id_hlavne_menu", 
                   "Výpis položiek hl. menu (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr."); 
if ($navrat) { //Ak bola požiadavka do DB úspečná
  echo("<table id=vyp_adm cellpadding=2 cellspacing=0><tr><th>Id</th><th>Názov</th><th>Titulka</th><th>Kl.s.</th>
        <th>Článok</th><th>Registrácia</th>");
  echo("<th>Zvýr.?</th>");
  echo("<th>Prir.čl.</th><th>Descr.</th><th>Pocit.</th><th></th></tr>\n");
  $pom=true;  
  while ($polozka = mysql_fetch_array($navrat)){ 
   echo($pom ? "<tr class=\"r1\">" : "<tr class=\"r2\">");
   if ($pom) $pom=false; else $pom=true;
   echo("<td>$polozka[id_hlavne_menu]</td><td><b>$polozka[hnazov]</b></td><td>$polozka[title]</td><td>$polozka[kl_skratka]</td><td>$polozka[clanok]</td><td>");
   echo($polozka["id_reg"]==0 ? "$polozka[id_reg]-$polozka[rnazov]" : "<div style=\"display: inline;\" class=st_zeleno>$polozka[id_reg]-$polozka[rnazov]</div>");
   echo("</td><td>");
   echo(@$polozka["zvyrazni"]==1 ? "<div style=\"display: inline;\" class=st_zeleno>Áno</div>" : "Nie");
   echo("</td><td>$polozka[clanky]</td><td>$polozka[description]</td><td>$polozka[pocitadlo]");
   echo("</td><td>
         <a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;operacia=adm_edit_hlavne_menu&amp;id=$polozka[id_hlavne_menu]\" class=edit title=\"Editácia položky $polozka[hnazov]\">
		 &nbsp;&nbsp;&nbsp;&nbsp;</a></td>");
   echo("</tr>\n");
  }
  echo("</table>");
}