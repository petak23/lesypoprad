<?php
/* Tento súbor slúži na pridanie fotiek do fotogaléfie a ich zápis do DB
   Zmena: 13.02.2017 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
//echo("<h2>Nahrávanie a zápis foto do DB</h2>");
echo("<h2>&nbsp;</h2>\n"); //Zatiaľ ostáva kôly medzere
       //Inicializácia
$max_obrazok_sirka=1024;      //Max. šírka obrázku
$max_obrazok_vyska=800;       //Max. výška obrázku
$max_obrazok_velkost=1000000; //Max. veľkosť súboru v bajtoch
$small_file_length=150;       //Veľkosť dlhšej strany pre miniatúru

if (@$_REQUEST["pr_foto_upload"]=="Nahraj") { //Ak je požiadavka na uploadovanie
 $imageinfo = getimagesize($_FILES['pr_file1']['tmp_name']);  //Zisti info o obrázku
 if($imageinfo['mime'] != 'image/gif' && $imageinfo['mime'] != 'image/jpeg') { //Kontrola na správnosť typu súboru  
  stav_zle("Je mi ľúto, ale pokúšate sa nahrať iný typ súboru ako GIF alebo JPEG.");
 }
 elseif ($_FILES['pr_file1']['size'] > $max_obrazok_velkost) { //Kontrola na veľkosť súboru
  stav_zle("Je mi ľúto, ale pokúšate sa nahrať príliš veľký súbor obrázku! <br />
          Max veľkosť je: ".($max_obrazok_velkost/1000000)."Mb (má ".($_FILES['pr_file1']['size']/1000000)."Mb)!"); 
 }
 elseif ($imageinfo[0]>$max_obrazok_sirka OR $imageinfo[1]>$max_obrazok_vyska) { //Kontrola rozmerov obrázku
  stav_zle("Je mi ľúto, ale pokúšate sa nahrať obrázok s nesprávnymi rozmermi. <br />
          Prípustné hodnoty sú $max_obrazok_sirka (má $imageinfo[0]) x $max_obrazok_vyska (má $imageinfo[1])!");
 }
 else {
  $uploaddir = "www/files/fotogalery/";
  $safe_filename = preg_replace( 
                      array("/\s+/", "/[^-\.\w]+/"), 
                      array("_", ""), 
                      trim($_FILES['pr_file1']['name']));
  $uploadfile = $uploaddir."images/".$safe_filename; //Vytvorenie samotného názvu súboru pre adresár images
  $uploadfile_small = $uploaddir."small/".$safe_filename; //Vtvorenie samotného názvu súboru pre adresár small
  if (move_uploaded_file($_FILES['pr_file1']['tmp_name'], $uploadfile)) {
   if (copy($uploadfile, $uploadfile_small)) {
    if ($imageinfo[0]>$imageinfo[1]) { //Výpočet nových rozmerov pre miniatúru
	 $new_width=$small_file_length;
	 $new_height=round($imageinfo[1]*$small_file_length/$imageinfo[0]);
    }
    else {
	 $new_width=round($imageinfo[0]*$small_file_length/$imageinfo[1]);;
	 $new_height=$small_file_length;
    }
    $image_p = imagecreatetruecolor($new_width, $new_height); //Samotný prevod 
    $image = imagecreatefromjpeg($uploadfile_small);
    imagecopyresampled($image_p, $image, 0, 0, 0, 0, $new_width, $new_height, $imageinfo[0], $imageinfo[1]);
    // Output
    imagejpeg($image_p, $uploadfile_small, 65);	
	
    stav_dobre("Obrázok ".basename($_FILES['pr_file1']['name'])." bol nahraný v poriadku!"); //Výsledok uploadovania fotiek
   }
  }
  else {
   stav_zle("Upload súboru sa nepodaril!");
  }
 }
}

  /* --- Upload fotiek --- */
echo("\n<form name=\"upload\" action=\"./index.php?clanok=$zobr_clanok&amp;co=foto_upload\" method=post enctype=\"multipart/form-data\">"); // Začiatok formulára pre zadanie údajov 
echo("\n<div id=admin><fieldset>"); //Samotny formular na zadanie
echo("<label for=\"pr_file1\">Obrázok: </label><input name=\"pr_file1\" id=\"pr_file1\" type=\"file\">");
echo("<div>Tu sa zadávajú názvy súborov obrázkov. Max. veľkosť obrázku je $max_obrazok_sirka x $max_obrazok_vyska px 
           a max. veľkosť súboru obrázku je ".($max_obrazok_velkost/1000000)."Mb.</div>\n");
echo("<input name=\"pr_foto_upload\" type=\"submit\" value=\"Nahraj\">");
echo("</fieldset></form><br />");
  /* --- Hľadanie nových fotiek --- */
$adresar = opendir("www/files/fotogalery/images"); //Adresár s fotkami
$pocet=0;
$i=0;
$pokracovanie=TRUE; // Ak vznikne vnútry nasledujúceho while chyba - zabezpečí jeho ukončenie
while (($subor = readdir($adresar)) AND $pokracovanie){
  $navrat_e=prikaz_sql("SELECT * FROM fotky WHERE nazov LIKE '$subor' LIMIT 1",
                       "Vyhladanie fotiek (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo fotky nájsť! Skúste neskôr.");
					   
  if (!$navrat_e) $pokracovanie=FALSE; //Došlo k chybe vo vyhľadávaní v DB
  else {//Vyhľadanie v DB v poriadku
   if (mysql_num_rows($navrat_e)==0) { //V DB sa nenašla fotka s týmto názvom
     if (stripos($subor,".")>0 AND (strpos($subor, "temp") === false)) { //Ak je 1. výskyt "." na inom ako 1. mieste súbor zapíš inak je to adresár a
	  $i++;                                                              //ak nie je v názve súboru "temp"
      //Nasleduje vloženie info. o fotke do DB
      $navrat=prikaz_sql("INSERT INTO fotky (nazov, id_clena) VALUES ('$subor', ".$_SESSION["id"].")",
	                     "Vloženie foto do DB (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo fotku pridať! Skúste neskôr.");
	 }
   }
   if (!is_file("www/files/fotogalery/small/$subor") AND stripos($subor,".")>0) { //Hľadanie miniatúr k súboru
    stav_zle("Nenašiel som miniatúru pre súbor www/files/fotogalery/small/$subor");
	$imageinfo = getimagesize("www/files/fotogalery/images/$subor");  //Zisti info o obrázku
	echo("Veľkosť fotky: $imageinfo[0] x $imageinfo[1]");
	if ($imageinfo[0]>$imageinfo[1]) { //Výpočet nových rozmerov pre miniatúru
	 $new_width=$small_file_length;
	 $new_height=round($imageinfo[1]*$small_file_length/$imageinfo[0]);
    }
    else {
	 $new_width=round($imageinfo[0]*$small_file_length/$imageinfo[1]);;
	 $new_height=$small_file_length;
    }
	echo(" -> Nová veľkosť: $new_width x $new_height");
    $image_p = imagecreatetruecolor($new_width, $new_height); //Samotný prevod 
    $image = imagecreatefromjpeg("www/files/fotogalery/images/$subor");
    imagecopyresampled($image_p, $image, 0, 0, 0, 0, $new_width, $new_height, $imageinfo[0], $imageinfo[1]);
    // Output
    imagejpeg($image_p, "www/files/fotogalery/small/$subor", 65);	//Vytvorenie novej miniatúry
    stav_dobre("Obrázok www/files/fotogalery/small/$subor bol vytvorený v poriadku!"); //Výsledok uploadovania fotiek
   }
  }	
}
if ($i==0) echo("V adresáry ./www/files/fotogalery/images sa nenašli nové fotky bez zápisu do databázy!<br />");
else stav_dobre("Počet fotiek pridaných do databázy: <B>$i</B>"); //V adresáry ./www/files/fotogalery/images boli nájdené tieto nové fotky:<BR>

$navrat=prikaz_sql("SELECT * FROM fotky WHERE id_galery=0",
                   "Nové fotky (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo zoznam vypísať! Skúste neskôr.");
if ($navrat AND mysql_num_rows($navrat)>0) { //Dopit v DB bol úspešný a bol nájdený nejaký záznam
  stav_dobre("Nové nezaradené fotky (".(int)mysql_num_rows($navrat)."):");
  echo("<div class=oznam><table id=kategoriaF border=0 cellpadding=0 cellspacing=0><tr>");$i=1;
  while ($foto_new = mysql_fetch_array($navrat)){
    echo("<td><img src=\"./www/files/fotogalery/small/$foto_new[nazov]\" alt=\"$foto_new[nazov]\" /><br />$foto_new[nazov]</td>");
    if ($i==7) {
	 $i=1;
	 echo("</tr><tr>");
	} 
	else $i++;
   }
  echo("</tr></table></div>");
}
else { stav_dobre("V databáze sa nenašli nezaradené fotky!"); }