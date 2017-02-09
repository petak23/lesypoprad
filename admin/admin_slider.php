<h2>Pridanie/Oprava položiek slider-u</h2>
<?php
/* Tento súbor slúži na obsluhu pridania/opravy položiek slider-u   
 * Zmena: 09.02.2017 - PV*/
// Hlavička stránky
if (@$bzpkod<>1934572) { exit("Neoprávnený prístup!!!"); } // Bezpečnostný kód
//Inicializácia premených 
$id=0;   $popis="";     //Popis obrázku 
$subor=0;      //Názov súboru aj s relatívnou cestou 
$zobrazenie="";//Kde sa zobrazuje obrázok 
$vysledok="";  //Výsledok zápisu do DB   

/* Funkcia zapíše položku slideru do databázy.     
 * Vstupy: - hodnoty prichádzajú cez $_POST z formulára	 
 * Výstupy: ok-ak všetko prebehlo správne inak chybová hláška	 
 * Obmedzenie: Zatiaľ neznáme.	 
 * Zmena: 09.02.2017 - PV  */
function pridaj_slider() {
  $zobrazenie = ($_REQUEST["zobrazenie"]=="") ? NULL : $_REQUEST["zobrazenie"]; 
  $pridanie_slideru=mysql_query("INSERT INTO slider (popis, subor, zobrazenie) VALUES('".$_REQUEST["popis"]."', '".$_REQUEST["subor"]."', '$zobrazenie')");
  return (!$pridanie_slideru) ? mysql_error() : "ok";
}

/* Funkcia aktualizuje položku slideru v databáze.     
 * Vstupy: - hodnoty prichádzajú cez $_POST z formulára	 
 * Výstupy: ok-ak všetko prebehlo správne inak chybová hláška	 
 * Obmedzenie: Zatiaľ neznáme.	 
 * Zmena: 09.02.2017 - PV  */
function oprav_slider() {
  $zobrazenie = ($_REQUEST["zobrazenie"]=="") ? NULL : $_REQUEST["zobrazenie"];
  $oprava_slideru=mysql_query("UPDATE slider SET id=".$_REQUEST["id"].", popis='".$_REQUEST["popis"]."', subor='".$_REQUEST["subor"]."', zobrazenie='$zobrazenie'".
                              "WHERE id=".$_REQUEST["id"]." LIMIT 1");
  return (!$oprava_slideru) ? mysql_error() : "ok";
}

/* Funkcia vymaže položku slideru z databázy.     
 * Vstupy: - hodnoty prichádzajú cez $_REQUEST z formulára	 
 * Výstupy: ok-ak všetko prebehlo správne inak chybová hláška	 
 * Obmedzenie: Zatiaľ neznáme.	 
 * Zmena: 09.02.2017 - PV  */
function vymaz_slider() {
  $vymaz_slideru=prikaz_sql("DELETE FROM slider WHERE id=".$_REQUEST["id_slider"],                          
                            "Zmazanie položky (".__FILE__ ." on line ".__LINE__ .")",
                            "Záznam nebol vymazaný! Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!");
  return (!$vymaz_slideru) ? mysql_error() : "ok";
}  

/* --- Pridanie/Oprava položky menu akcie ak bola daná požiadavka --- */
if (@$_REQUEST["slider"]=="Pridaj") { $vysledok=pridaj_slider(); } 
elseif (@$_REQUEST["slider"]=="Oprav") { $vysledok=oprav_slider(); } 
elseif (@$_REQUEST["slider"]=="Áno")  { $vysledok=vymaz_slider(); }

if (@$zobr_co=="adm_del_slider" AND @$vysledok<>"ok") { // vymazanie položky sub. menu 
  $vys_sub=prikaz_sql("SELECT * FROM slider WHERE id=".$_REQUEST["id"]." LIMIT 1", "Nájdenie položky(".__FILE__ ." on line ".__LINE__ .")",
                      "Žiaľ sa momentálne nepodarilo nájsť položku a teda ani vymazať! Skúste neskôr."); 
  if (@$vys_sub) {  
    $zaz_sub=mysql_fetch_array($vys_sub);  
    echo("\n<div class=st_zle>Vymazanie položky slideru !!!<br />");  
    echo("Naozaj chceš vymazať položku <B><U>$zaz_sub[popis]</U></B>!!!"); 
    echo("\n<form action=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>");  
    echo("\n<input name=\"id_slider\" type=\"hidden\" value=\"$zaz_sub[id]\">");  
    echo("\n<input name=\"slider\" type=\"submit\" value=\"Áno\">");  
    echo("\n<input name=\"slider\" type=\"submit\" value=\"Nie\"></form></div>\n"); 
  }
} else {
  /* ----------- Časť spracovania formulára ---------- */
  if ($vysledok<>"") { // Zapisovalo sa do databázy  
    if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy    
      stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!:<br>$vysledok");    
      $id=$_REQUEST["id"];  // Opätovné načítanie údajou ak došlo k chybe    
      $popis=$_REQUEST["popis"];	$subor=$_REQUEST["subor"];	$zobrazenie=$_REQUEST["zobrazenie"];  
    }  else {                // Správny zápis aktualizácie do DB    
      echo("<div class=st_dobre>Položka slideru bola ");  //Vypísanie info o operácii    
      if (@$_REQUEST['menu_akcia']=="Pridaj") { echo("pridaná!");       
      } elseif(@$_REQUEST['menu_akcia']=="Oprav") { echo("opravená!");    
      } else { echo("zmenená!"); }
      echo("&nbsp;Zmena sa prejaví až po kliknutí na položku v hlavnom menu.</div>");  
    }
  }  
      
  echo("<form name=\"zadanie\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>"); // Začiatok formulára pre zadanie údajov
  if (@(int)$_REQUEST["id"]>0){ //Ak prišiel údaj o požiadavke na editáciu položky tak sa položka nájde v databáze a načíta do premených  
    $navrat_e=prikaz_sql("SELECT * FROM slider WHERE id=".$_REQUEST["id"]." LIMIT 1", "Načítanie položky slideru (".__FILE__ ." on line ".__LINE__ .")",
                         "Žiaľ sa momentálne nepodarilo položku nájsť! Skúste neskôr.");  
    if ($navrat_e) { //Ak bola požiadavka do DB úspešná   
      $zaz_e = mysql_fetch_array($navrat_e);   
      $id=$zaz_e["id"];   $popis=$zaz_e["popis"];   $subor=$zaz_e["subor"];   $zobrazenie=$zaz_e["zobrazenie"];  
    }
  }
  echo("<div id=admin><fieldset>");  //Samotny formular na zadanie
  form_pole("id", "Index", $id, "POZOR! táto položka určuje poradie ale NESMIE sa opakovať!!!", 5);
  form_pole("popis","Popis obrázku",$popis,"", 80,50);
  form_pole("subor","Názov obrázku",$subor,"Názov súboru sa zadáva aj s relatívnou cestou. napr. slider/obrazok.jpg", 50);
  form_pole("zobrazenie","Zobrazenie",$zobrazenie,"V ktorých častiach hlavného menu sa má daný obrázok zobraziť. Jednotlivé časti sa píšu ako čísla(v odkaze číslo za clanok=) oddelené medzerami.", 20);
  echo("<input name=slider type=\"submit\" value=\"");
  echo(@$_REQUEST["id"]<>"" ? "Oprav" : "Pridaj");
  echo("\"></fieldset></form></div>");  

  /* ----- Výpis všetkých položiek hl. menu ----- */
  $navrat=prikaz_sql("SELECT * FROM slider ORDER BY id", "Výpis položiek slideru (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr."); 

  if ($navrat) { //Ak bola požiadavka do DB úspečná  
    echo("<table id=vyp_adm cellpadding=2 cellspacing=0>"); //Výpis položiek menu  
    echo("<tr><th>Id</th><th>Popis</th><th>Súbor</th><th>Zobrazenie</th><th colspan=2></th></tr>");  
    $pom = true;  
    while ($polozka = mysql_fetch_array($navrat)){     
      echo($pom ? "<tr class=r1>" : "<tr class=r2>");    
      $pom = ($pom) ? false :true;     
      echo("<td>$polozka[id]</td><td>$polozka[popis]</td><td>$polozka[subor]</td><td>");	
      echo(($polozka["zobrazenie"]=="" OR $polozka["zobrazenie"]==NULL) ? "Všade" : "$polozka[zobrazenie]");    
      echo("</td><td><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;id=$polozka[id]&amp;co=adm_edit_slider\" class=edit title=\"Editácia položky $polozka[popis]\">"); //Odkaz na editáciu    
      echo("&nbsp;&nbsp;&nbsp;&nbsp;</a></td><td><a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;id=$polozka[id]&amp;co=adm_del_slider\" class=vymaz title=\"Vymazanie položky $polozka[popis]\">&nbsp;&nbsp;&nbsp;&nbsp;</a>");
      echo("</td></tr>");  
    }  
    echo("</table>");
  }        
}