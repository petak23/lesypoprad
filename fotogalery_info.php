<?php
/* Tento súbor slúži na obsluhu fotogalérie výpis jej menu
   Zmena: 21.09.2011 - PV
   
   !!! POZOR !!!
   Zakomentované časti sú len kôli webu LesyPP lebo tie využívajú len podgalérie
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
//if ((string)$zobr_pol<>"historia") {     //Nejdem vypisovať fotogalériu
/* if ($zobr_pol>0) $vyber_casti=$zobr_pol; //Ktorá skupina/založka sa vyberie 
 elseif ($zobr_co=="new_menu_galery" OR $zobr_co=="foto_upload") $vyber_casti=0; 
 else*/ $vyber_casti=1;
/* if ($vysledok_menu_galery<>"") { //Zapisovalo sa do DB
  if ($vysledok_menu_galery=="ok") {                // Správny zápis aktualizácie do DB
   echo("<div class=st_dobre>Položka menu galérie bola ");  //Vypísanie info o operácii
   if (@$_REQUEST["menu_galery"]=="Pridaj") echo("pridaná!");   
   elseif(@$_REQUEST["menu_galery"]=="Oprav") echo("opravená!");
   elseif (@$_REQUEST["menu_galery"]=="Áno") echo("zmazaná!");
   else echo("zmenená!");
   echo("</div>");
  }
  else {
   stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!.");
   if (jeadmin()>4) stav_zle("<br /><b>$vysledok_menu_galery</b>");
  }
 }*/
 if ($vysledok_podgalery<>"") { //Zapisovalo sa do DB
  if ($vysledok_podgalery=="ok") {                // Správny zápis aktualizácie do DB
   echo("<div class=st_dobre>Položka podgalérie bola ");  //Vypísanie info o operácii
   if (@$_REQUEST["podgalery"]=="Pridaj") echo("pridaná!");   
   elseif(@$_REQUEST["podgalery"]=="Oprav") echo("opravená!");
   elseif (@$_REQUEST["podgalery"]=="Áno") echo("zmazaná!");
   else echo("zmenená!");
   if (@$_REQUEST["title_podgalery_tl"]=="Vyber") echo("<br />Opravená titulná fotka!");
   if (@$_REQUEST["add_podgalery_tl"]=="Vyber") echo("<br />Fotky pridané!");
   if (@$_REQUEST["odstr_podgalery_tl"]=="Vyber") echo("<br />Fotky odobraté!");
   echo("</div>");
  }
  else {
   stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!.");
   if (jeadmin()>4) stav_zle("<br /><b>$vysledok_podgalery</b>");
  }
 }
 //Najdenie poloziek z menu akcie v DB na ktoré je oprávnenie		 
 @$nav_hl_foto=prikaz_sql("SELECT id_polozka, nazov FROM menu_galeria WHERE id_reg<=".jeadmin()." AND zobrazenie>0 ORDER BY id_polozka",
                          "Najdenie menu_galeria(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr.");
 if ($nav_hl_foto AND mysql_numrows($nav_hl_foto)>0) {       //Ak bola požiadavka úspešná a je čo vypisovať
  //echo("<div class=zalozky>"); //!!! POZOR ak sa použijú galérie zmazať zakomentovanie
  /*while ($hl_menu = mysql_fetch_array($nav_hl_foto)){ //Vytvorenie hlavného horizontálneho menu
   if ($hl_menu["id_polozka"]==$vyber_casti) {
    echo("<h3 class=active><a href=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$hl_menu[id_polozka]\">$hl_menu[nazov]</a></h3>");
	
   }
   else echo("<h3><a href=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$hl_menu[id_polozka]\">$hl_menu[nazov]</a></h3>");
  }*/
  if (jeadmin()>2) { //Odkaz pre pridanie položky podgalérie
   echo("<div class=zalozky>"); //!!! POZOR ak sa použijú galérie zmazať riadok
   /*echo("<h3");
   if ($zobr_co=="new_menu_galery") echo(" class=active");
   echo("><a href=\"./index.php?clanok=$zobr_clanok&amp;co=new_menu_galery\">Pridanie položky menu</a></h3>");
   if ($zobr_co=="edit_menu_galery") //Pribudne položka ak idem editovať
    echo("<h3 class=active><a href=\"./index.php?clanok=$zobr_clanok&amp;id=$vyber_casti&amp;co=edit_menu_galery\" title=\"Editácia položky menu\">Editácia položky menu</a></h3>");
   if ($zobr_co=="del_menu_galery") //Pribudne položka ak idem mazať
    echo("<h3 class=active><a href=\"./index.php?clanok=$zobr_clanok&amp;id=$vyber_casti&amp;co=del_menu_galery\" title=\"Vymazanie položky menu\">Vymazanie položky menu</a></h3>");	
	*/
   if ($zobr_co=="foto_upload") //Pribudne položka ak idem nahrávať fotky
    echo("<h3 class=active><a href=\"./index.php?clanok=$zobr_clanok&amp;id=$vyber_casti&amp;co=foto_upload\" title=\"Nahratie fotiek do galérie\">Nahratie fotiek</a></h3>");		
   if ($zobr_co=="new_podgalery") //Pribudne položka ak idem pridať podgalériu &amp;id=$vyber_casti
    echo("<h3 class=active><a href=\"./index.php?clanok=$zobr_clanok&amp;co=new_podgalery\" title=\"Pridať album\">Pridať album</a></h3>");
   if ($zobr_co=="del_podgalery") //Pribudne položka ak idem mazať podgalériu
    echo("<h3 class=active><a href=\"./index.php?clanok=$zobr_clanok&amp;&amp;id_clanok=$zobr_pol&amp;cast=$zobr_cast&amp;co=del_podgalery\" title=\"Mazať album\">Mazať album</a></h3>");
   if ($zobr_co=="edit_podgalery") //Pribudne položka ak idem editovať podgalériu
    echo("<h3 class=active><a href=\"./index.php?clanok=$zobr_clanok&amp;&amp;id_clanok=$zobr_pol&amp;cast=$zobr_cast&amp;co=edit_podgalery\" title=\"Editácia albumu\">Editácia albumu</a></h3>");
   echo("</div>");  //!!! POZOR ak sa použijú galérie zmazať riadok
  } 
  //echo("</div>"); //!!! POZOR ak sa použijú galérie zmazať zakomentovanie
  if (jeadmin()>2 AND $zobr_co=="") { //Len pre registrovaného a nezobrazí sa pri pridaní
   echo("<div id=oznamy><p class=oznam>");
  /* echo("<a href=\"./index.php?clanok=$zobr_clanok&amp;id=$vyber_casti&amp;co=edit_menu_galery\" title=\"Editácia položky menu\">Editácia položky menu</a>");
   echo("&nbsp;|&nbsp;<a href=\"./index.php?clanok=$zobr_clanok&amp;id=$vyber_casti&amp;co=del_menu_galery\" title=\"Vymazanie položky menu\">Vymazanie položky menu</a>");
   echo("&nbsp;|&nbsp;*/echo("<a href=\"./index.php?clanok=$zobr_clanok&amp;co=foto_upload\" title=\"Nahratie fotiek do galérie\">Nahratie fotiek</a>");
   if ($zobr_cast==0) echo("&nbsp;|&nbsp;<a href=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;co=new_podgalery\" title=\"Pridať album\">Pridať album</a>");
   echo("</p></div>");
  }
 }
 /*if ($zobr_co=="new_menu_galery") require("./fotogalery/edit_menu_galery.php"); //Idem pridať položku menu galérie
 elseif ($zobr_co=="edit_menu_galery") require("./fotogalery/edit_menu_galery.php"); //Idem opraviť položku menu galérie
 elseif ($zobr_co=="del_menu_galery") require("./fotogalery/edit_menu_galery.php"); //Idem vymazať položku menu galérie
 else*/if ($zobr_co=="foto_upload") require("./fotogalery/upload_foto.php"); //Idem nahrať fotky
 elseif ($zobr_co=="new_podgalery") require("./fotogalery/edit_podgalery.php"); //Idem pridať podgalériu
 elseif ($zobr_cast>0) {
  if ($zobr_co=="del_podgalery" OR $zobr_co=="new_podgalery" OR $zobr_co=="edit_podgalery") 
   require("./fotogalery/edit_podgalery.php"); //Ak sa ide pridať / opravovať / mazať konkrétna podgaléria
  else require("./fotogalery/galery_vypis.php"); //Inak Ak sa ide vypisovať, meniť, editovať titulná fotka, pridať/odobrať fotky konkrétnej podgalérie
 }
 else { //Ak sa ide vypísať len menu na výber podgalérií.
  $nav_sub_foto=prikaz_sql("SELECT id_polozka, nazov, DATE_FORMAT(datum,'%d.%m.%Y') as sdatum, tit_foto, popis FROM podgaleria 
                            WHERE id_menu=$vyber_casti AND id_reg<=".jeadmin()." AND zobrazenie>0 ORDER BY datum DESC",
                           "Polozky submenu-akcie(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr.");
  if ($nav_sub_foto AND mysql_numrows($nav_sub_foto)>0) {       //Ak bola požiadavka úspešná a je čo vypisovať
   //echo("<table id=kategoriaG border=0 cellpadding=0 cellspacing=0><tr>");
   $i=1;
   while ($podgaleria = mysql_fetch_array($nav_sub_foto)){
    $navrat_fotky=prikaz_sql("SELECT nazov FROM fotky WHERE id_galery=$podgaleria[id_polozka] AND id_foto=$podgaleria[tit_foto] LIMIT 1", // Výber titulnej fotky fotiek k podgalérii 
                             "Výber titulnej fotky (".__FILE__ ." on line ".__LINE__ .")", "Bohužiaľ sa nepodarilo spojiť s databázou. Skúste prosím neskôr!"); 
    if ($navrat_fotky && mysql_numrows($navrat_fotky)>0) { //Ak bola požiadavka v DB úspešná
	 $vyp_min=mysql_fetch_array($navrat_fotky);//Názov súboru titulnej fotky z databázy
	 $naz_tit_foto="fotogalery/images/$vyp_min[nazov]";
	}
	else { //Ak bola požiadavka v DB NEúspešná
     $naz_tit_foto="Obr/bez_titulky.gif";
	}
	echo("<div class=album><h3><a href=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$vyber_casti&amp;cast=$podgaleria[id_polozka]\">$podgaleria[nazov]</a>
	      <span class=datum>$podgaleria[sdatum]</span></h3>");
	echo("<a href=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$vyber_casti&amp;cast=$podgaleria[id_polozka]\">");
	include_once("fotogalery/imageCrop.php"); //Funkcia na úpravu obrázku (zmenšenie a orezanie)
	imageResizeCrop($naz_tit_foto, "fotogalery/images/temp_$i.jpg", (int)$hl_udaje["galeria_small"], (int)$hl_udaje["galeria_small"]);
	echo("<img src=\"fotogalery/images/temp_$i.jpg\" >");
	$i++;
	echo("</a></div>"); //<p>$podgaleria[popis]</p>
	/*echo("<td><a href=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$vyber_casti&amp;cast=$podgaleria[id_polozka]\"><img src=\"$naz_tit_foto\" ></a>"); //<br />
	echo("<h4><a href=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$vyber_casti&amp;cast=$podgaleria[id_polozka]\">$podgaleria[nazov]</a><br /><span>$podgaleria[sdatum]</span></td>");
	if ($i==4) {
	 $i=1;
	 echo("</tr><tr>");
	} 
	else $i++;*/
   }
   //echo("</tr></table>");
  } 	  
 }
//}
//else require("./fotogalery/historia.php");
?>
