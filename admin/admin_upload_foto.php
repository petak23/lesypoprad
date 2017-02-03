<?php
/* Tento súbor slúži na pridanie fotiek pre články
   Zmena: 08.07.2011 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Nahrávanie fotiek pre články</h2>");
       //Inicializácia
$max_obrazok_sirka=1024;      //Max. šírka obrázku
$max_obrazok_vyska=800;       //Max. výška obrázku
$max_obrazok_velkost=1000000; //Max. veľkosť súboru v bajtoch

if (@$_REQUEST["cl_foto_upload"]=="Nahraj") { //Ak je požiadavka na uploadovanie
 $imageinfo = getimagesize($_FILES['cl_file1']['tmp_name']);  //Zisti info o obrázku
 if($imageinfo['mime'] != 'image/gif' && $imageinfo['mime'] != 'image/jpeg') { //Kontrola na správnosť typu súboru  
  stav_zle("Je mi ľúto, ale pokúšate sa nahrať iný typ súboru ako GIF alebo JPEG.");
 }
 elseif ($_FILES['cl_file1']['size'] > $max_obrazok_velkost) { //Kontrola na veľkosť súboru
  stav_zle("Je mi ľúto, ale pokúšate sa nahrať príliš veľký súbor obrázku! <br />
          Max veľkosť je: ".($max_obrazok_velkost/1000000)."Mb (má ".($_FILES['cl_file1']['size']/1000000)."Mb)!"); 
 }
 elseif ($imageinfo[0]>$max_obrazok_sirka OR $imageinfo[1]>$max_obrazok_vyska) { //Kontrola rozmerov obrázku
  stav_zle("Je mi ľúto, ale pokúšate sa nahrať obrázok s nesprávnymi rozmermi. <br />
          Prípustné hodnoty sú $max_obrazok_sirka (má $imageinfo[0]) x $max_obrazok_vyska (má $imageinfo[1])!");
 }
 else {
  $uploaddir = "obrazky/";
  $uploadfile = $uploaddir.basename($_FILES['cl_file1']['name']); //Vytvorenie samotného názvu súboru pre adresár images
  if (move_uploaded_file($_FILES['cl_file1']['tmp_name'], $uploadfile)) {
   stav_dobre("Obrázok ".basename($_FILES['cl_file1']['name'])." bol nahraný v poriadku!"); //Výsledok uploadovania fotiek
  }
  else {
   stav_zle("Upload súboru sa nepodaril!");
  }
 }
}
  /* --- Upload fotiek --- */
echo("\n<form name=\"upload\" action=\"./index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol\" method=post enctype=\"multipart/form-data\">"); // Začiatok formulára pre zadanie údajov 
echo("\n<div id=admin><fieldset>"); //Samotny formular na zadanie
echo("<label for=\"cl_file1\">Obrázok: </label><input name=\"cl_file1\" id=\"cl_file1\" type=\"file\">");
echo("<div>Tu sa zadávajú názvy súborov obrázkov. Max. veľkosť obrázku je $max_obrazok_sirka x $max_obrazok_vyska px 
           a max. veľkosť súboru obrázku je ".($max_obrazok_velkost/1000000)."Mb.</div>\n");
echo("<input name=\"cl_foto_upload\" type=\"submit\" value=\"Nahraj\">");
echo("</fieldset></form><br />");
  /* --- Hľadanie nových fotiek --- */
$adresar = opendir("obrazky"); //Adresár s fotkami
$pokracovanie=TRUE; // Ak vznikne vnútry nasledujúceho while chyba - zabezpečí jeho ukončenie
echo("<div class=oznam><table id=kategoriaF border=0 cellpadding=0 cellspacing=0><tr>");$i=1;
while (($subor = readdir($adresar)) AND $pokracovanie){
 if (stripos($subor,".")>0) { //Ak je 1. výskyt "." na inom ako 1. mieste súbor zapíš inak je to adresár
  echo("<td><img src=\"./obrazky/$subor\" alt=\"$subor\" /><br />$subor</td>");
  if ($i==7) {
   $i=1;
   echo("</tr><tr>");
  } 
  else $i++;
 }
}
echo("</tr></table></div>");
?>