<?php
/* Tento súbor slúži na obsluhu pridania/opravy/vymazania člena
   Zmena: 06.09.2011 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Editácia / Vymazanie členov</h2>"); 

//Inicializácia premených
 $meno="";              //Meno a priezvisko áäčďéíľĺňóôřŕšťúžý
 $telefon="";           //Telefónne číslo
 $e_mail=" @ .sk";      //e-mail
 $prezyvka="";          //Prihlasovacie meno
 $id_reg=0;             //Úroveň registrácie
 $jeblokovany=0;        //Je člen blokovaný? Ak 1 tak áno.
 $vysledok="";          //Výsledok zápisu do DB

  /*-------- Časť zápisu do databázy    ---------- */

function pridaj_clena()
  /* Funkcia skontroluje vstupy a zapíše údaje člena do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 06.09.2011 - PV
  */
{
$meno=strip_tags($_POST["pr_meno"]); // odstranenie HTML tagov 
$prezyvka=strip_tags($_POST["pr_prezyvka"]);

$co="INSERT INTO clenovia (meno, telefon, e_mail, prezyvka, id_reg, jeblokovany";
$co1="'$meno', ".$_POST["pr_telefon"]."', '".$_POST["pr_mail"]."', '$prezyvka', ".(int)$_POST["pr_id_reg"].", ".@(int)$_POST["pr_jeblokovany"];
if ($_POST["pr_heslo"]==$_POST["pr_heslo"]) {
   $co=$co.", heslo";
   $co1=$co1.", '".md5(strip_tags($_POST["pr_heslo"]))."'";  //Kontrola hesla
}
else return "Chybne zadané heslo!";
$co=$co.") VALUES(".$co1.")";
$pridaj_clen=prikaz_sql($co, "Pridanie člena(".__FILE__ ." on line ".__LINE__ .")","");
if (!$pridaj_clen) return mysql_error();
return "ok";
}
  
function edituj_clena()
  /* Funkcia skontroluje vstupy a zapíše upravené údaje člena do databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 06.09.2011 - PV
  */
{
$meno=strip_tags($_POST["pr_meno"]); // odstranenie HTML tagov 
$prezyvka=strip_tags($_POST["pr_prezyvka"]);
$co="UPDATE clenovia SET meno='".$_POST["pr_meno"]."',
						 telefon='".$_POST["pr_telefon"]."',
  						 e_mail='".$_POST["pr_mail"]."',
	  					 prezyvka='".$_POST["pr_prezyvka"]."',
		  				 id_reg=".(int)$_POST["pr_id_reg"].",
						 jeblokovany=".@(int)$_POST["pr_jeblokovany"];
if (@(int)$_POST["zmena_hesla"]==1) {  // Ak je požadovaná zmena hesla
  if ($_POST["pr_heslo"]==$_POST["pr_heslo"]) $co=$co.", heslo='".md5(strip_tags($_POST["pr_heslo"]))."'";  //Kontrola hesla
  else return "Chybne zadané heslo!";
}
$oprav_clen=mysql_query($co." WHERE id_clena=".$_REQUEST["id_clena"]." LIMIT 1");
if (!$oprav_clen) {echo($co);return mysql_error();}
return "ok";
}

function vymaz_clena()
  /* Funkcia vymaže člena z databázy.
     Vstupy: - hodnoty prichádzajú cez $_POST z formulára
	 Výstupy: ok-ak všetko prebehlo správne inak chybová hláška
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 06.09.2011 - PV
  */
 {
$vymaz_clen=prikaz_sql("DELETE FROM clenovia WHERE id_clena=".$_REQUEST["id_clena"],
                     "Zmazanie člena(".__FILE__ ." on line ".__LINE__ .")","");
if (!$vymaz_clen) return mysql_error();
return "ok";
}

  /* --- Oprava/Vymazanie člena ak bola daná požiadavka --- */
if (@$_REQUEST["pr_clena"]=="Pridaj")   $vysledok=pridaj_clena();
if (@$_REQUEST["pr_clena"]=="Oprav")   $vysledok=edituj_clena();
elseif (@$_REQUEST["vymaz_clena"]=="Áno")   $vysledok=vymaz_clena();

  /* ----------- Časť spracovania formulára ---------- */
if ($vysledok<>"") {     // Zapisovalo sa do databázy
  if ($vysledok<>"ok") {  // Načítanie údajov po chybnom zápise do databázy
    stav_zle("Zmena nebola uskutočnená! Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!<BR>$vysledok");
    $meno=$_POST["pr_meno"];     // Opätovné načítanie údajou ak došlo k chybe
    $telefon=$_POST["pr_telefon"];
    $e_mail=$_POST["pr_mail"];
    $prezyvka=$_POST["pr_prezyvka"];
    $id_reg=(int)$_POST["pr_id_reg"];
    $jeblokovany=@(int)$_POST["pr_jeblokovany"];
  }
  else {   // Správny zápis oznamu do databázy
    echo("<div class=st_dobre>Člen bol ");  //Vypísanie info o operácii
	if(@$_REQUEST["pr_clena"]=="Pridaj") echo("pridaný!");
    if(@$_REQUEST["pr_clena"]=="Oprav") echo("opravený!");
	elseif(@$_REQUEST["vymaz_clena"]=="Áno") echo("zmazaný!");
    else echo("zmenený!");
    echo("</div>");
  }
}
if ($zobr_co=="adm_del_clen") { /* vymazanie clena */
 $vys_clen=prikaz_sql("SELECT meno FROM clenovia WHERE id_clena=$zobr_cast LIMIT 1", //".$_REQUEST["id"]." LIMIT 1",
                      "Nájdenie člena(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť tohoto člena! Skúste neskôr.");
 if (@$vys_clen) {
  $zaz_clen=mysql_fetch_array($vys_clen);
  echo("<div class=st_zle>Vymazanie člena !!!<br />");
  echo("Naozaj chceš vymazať člena <b><u>$zaz_clen[meno]</u></b>!!!");
  echo("<form action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post>");
  echo("<input name=\"id_clena\" type=\"hidden\" value=\"$zobr_cast\">");
  echo("<input name=\"vymaz_clena\" type=\"submit\" value=\"Áno\">");
  echo("<input name=\"vymaz_clena\" type=\"submit\" value=\"Nie\"></div></form>");
 }
}
elseif ($zobr_co=="adm_edit_clen" OR $zobr_co=="adm_new_clen" AND $vysledok<>"ok") {  /* Editácia/Pridanie člena */
  echo("<form action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=$zobr_cast&amp;co=$zobr_co\" method=post>");
  if ($zobr_co=="adm_edit_clen") { 
   $vys_clen=prikaz_sql("SELECT * FROM clenovia WHERE id_clena=$zobr_cast LIMIT 1",
                        "Údaje o členovy(".__FILE__ ." on line ".__LINE__ .")",
						"Žiaľ sa momentálne nepodarilo nájsť tohoto člena! Skúste neskôr.");
   if ($vys_clen) {  // Ak bola požiadavka v DB úspešná
    $zaz_clen=mysql_fetch_array($vys_clen);
    echo("<input name=\"id_clena\" type=\"hidden\" VALUE=\"$zobr_cast\">");
	$meno=$zaz_clen["meno"];
    $telefon=$zaz_clen["telefon"];
    $e_mail=$zaz_clen["e_mail"];
    $prezyvka=$zaz_clen["prezyvka"];
    $id_reg=$zaz_clen["id_reg"];
	$jeblokovany=$zaz_clen["jeblokovany"];
   }
 }
 echo("<div id=admin><fieldset>"); //Samotny formular na zadanie
 form_pole("pr_meno","Meno PRIEZVISKO",$meno,"Meno v tvare Janko MRKVIČKA.", 50);
 form_pole("pr_telefon","Telefón",$telefon,"", 15);
 form_pole("pr_mail","E-mail",$e_mail,"POZOR !!! Musí to byť platný e-mail. Inak sa účet zablokuje!", 30);
 if (jeadmin()>3) { //Platí len pre LesyPP
  if ($zobr_co=="adm_edit_clen") { //Zadanie úrovne registrácie pri editacií
   $jeadmin=jeadmin(); // Zistenie úrovne registrácie prihláseného člena
   if ($jeadmin>2 AND $jeadmin>=$id_reg) {
    echo("<label for=\"pr_id_reg\">Úroveň registrácie:</label>");
    $ur_reg=prikaz_sql("SELECT * FROM registracia WHERE id_reg<=$jeadmin ORDER BY id_reg", 
                       "Úroveň registracie (".__FILE__ ." on line ".__LINE__ .")", "Momentálne sa nepodarilo vypísať!");
    if ($ur_reg) {  // Ak bola požiadavka v DB úspešná
      echo("<select name=\"pr_id_reg\" id=\"pr_id_reg\">");
      while($uroven=mysql_fetch_array($ur_reg)) {
        echo("<option value=\"$uroven[id_reg]\"");
        if ($id_reg==$uroven["id_reg"]) echo(" selected");  
        echo("> $uroven[id_reg] - $uroven[nazov]</option>\n");
      }
      echo("</select>");
    }
    else echo("<input type=\"hidden\" name=\"pr_id_reg\" value=$id_reg>"); //Ak edituje úroveň 0 alebo 1
   }
   else echo("<input type=\"hidden\" name=\"pr_id_reg\" value=$id_reg>"); //Ak nie je oprávnenie na zmenu úrovne
  }
  else echo("<input type=\"hidden\" name=\"pr_id_reg\" value=0>"); //Pri novom zadaní je úroveň registrácie 0
 }
 else echo("<input type=\"hidden\" name=\"pr_id_reg\" value=3>"); //Pri zadávani z úrovne 3 Platí len pre LesyPP
 echo("<br />Prihlasovacie údaje:<br />");
 form_pole("pr_prezyvka","Prezývka",$prezyvka,"", 15);
 form_zaskrt("pr_jeblokovany", "Blokovanie člena?", $jeblokovany);
 if ($zobr_co=="adm_edit_clen") form_zaskrt("zmena_hesla", "Zmeniť Heslo?");
 echo("<label for=\"pr_heslo\">&nbsp;Zadaj heslo: </label><input type=\"password\" name=\"pr_heslo\" id=\"pr_heslo\" SIZE=15 MAXLENGTH=15><br />");
 echo("<label for=\"pr_heslo1\">Opakuj heslo: </label><input type=\"password\" name=\"pr_heslo1\" id=\"pr_heslo1\" SIZE=15 MAXLENGTH=15><br />");
 echo("<INPUT NAME=\"pr_clena\" type=\"submit\" VALUE=\"");
 if (@$_REQUEST["co"]=="adm_edit_clen") echo("Oprav");
 else echo("Pridaj");
 echo("\"></fieldset></form></div>");

}
  /* ----- Vypísanie členou ----- */
if ($zobr_co=="") {
 echo("<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;co=adm_new_clen\" title=\"Pridanie člena\">Pridanie nového člena</a><br />");
 $vys_clen=prikaz_sql("SELECT id_clena, meno, telefon, e_mail, prezyvka, heslo, registracia.id_reg as idreg, registracia.nazov as rnazov,  
							  jeblokovany, pocet_pr, news, prihlas_teraz, prihlas_predtym, reg_od
                       FROM clenovia, registracia WHERE clenovia.id_reg=registracia.id_reg ORDER BY id_clena",
                      "Zoznam členov(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr.");


					  
 if ($vys_clen) {
  while ($zaz_clen = mysql_fetch_array($vys_clen)){
   echo("<table id=vyp_adm cellpadding=2 cellspacing=0 style=\"width: 95%\">\n");
   echo("<tr><th colspan=4>[ $zaz_clen[id_clena] ] ");
   if ($zaz_clen["jeblokovany"]>0) {
    echo("<img src=\"./Obr/upozornenie_c.png\" alt=\"Blokovaný člen\" style=\"border: 0;\">
	      <span class=st_cerveno>$zaz_clen[meno] - blokovaný");
	echo("!</span>");
   }
   else echo("<b>$zaz_clen[meno]</b>");
   if ($zaz_clen["idreg"]<=jeadmin()) { //Odkazy na editáciu a vymazanie
    echo("&nbsp;&nbsp;&nbsp;<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=$zaz_clen[id_clena]&amp;co=adm_edit_clen\"title=\"Editácia člena $zaz_clen[meno]\">");
    echo("Editácia</a>&nbsp;|&nbsp;");
    echo("<a href=\"index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=$zaz_clen[id_clena]&amp;co=adm_del_clen\"title=\"Vymazanie člena $zaz_clen[meno]\">");
    echo("Vymazanie</a>");
   }
   echo("</th></tr>\n<tr class=r1><td>Prezývka:</td><td colspan=3><B><I>$zaz_clen[prezyvka]</I></B></td></tr>");
   echo("\n<tr class=r2><td style=\"width: 20%;\">telefón:</td><td style=\"width: 30%;\">$zaz_clen[telefon]</td>");
   echo("<td style=\"width: 20%;\">e-mail:</td><td style=\"width: 30%;\">$zaz_clen[e_mail]</td></tr>");
   echo("\n<tr class=r1><td");
   if (@$zaz_clen["idreg"]>0){
     $napo=StrFTime("%d.%m.%Y %H:%M:%S", strtotime($zaz_clen["prihlas_teraz"]));
     echo(">Registrovaný od</td><td><span class=st_zeleno>$zaz_clen[reg_od]</span></td>");
     echo("<td>Úroveň registrácie:</td><td><span class=st_cerveno>$zaz_clen[idreg] - $zaz_clen[rnazov]</span></td></tr>");
	 echo("<tr class=r2><td>Prihlásený počet:</td><td>$zaz_clen[pocet_pr] x</td><td>Naposledy</td><td>$napo</td>");
	 
   }
   else echo(" colspan=4><img src=\"./images/upozornenie_c.png\" alt=\"Neukončená registr.\">
               <span class=st_cerveno>Registrácia NEUKONČENÁ!</span></td></tr>\n<tr class=r1><td colspan=4>Bez prihlásenia.</td></tr>");
   echo("</td></tr><tr><td colspan=5 style=\"height: 10px; border: 0;\"></td></tr></table>");
  }
 }
}
?>