<?php
/* Tento súbor slúži na obsluhu vyhľadávania
   Zmena: 09.01.2012 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
if (@$_REQUEST["tl_vyhladaj"]==" "){  //Idem niečo hľadať
  $txt_normal=trim($_REQUEST["vyhladavanie"]); //Odstránenie medzier na začiatku a konci
  $txt_locase=strtolower(normalize($txt_normal)); //Odstránenie diakritiky a prevod na malé písmo
  $clanok_vyb=prikaz_sql("SELECT id_clanok, id_hlavne_menu, podclanok, nazov, text FROM clanok",
  						 "Nájdenie článku (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
  if ($clanok_vyb) {
   echo("<h3>Vyhľadávanie textu <b>$txt_normal</b></h3>");
   echo("<div id=\"oznamy\">");
   $najdene=false;
   while ($zaznam_cl = mysql_fetch_array($clanok_vyb)) {
    $txt_vychodzie=trim($zaznam_cl["nazov"]); //Odstránenie medzier na začiatku a konci nadpisu
	$txt_text_upr=strtolower(normalize($zaznam_cl["text"])); //Odstránenie diakritiky a prevod na malé písmo textu
	$pozicia_nadpis=strpos(strtolower(normalize($txt_vychodzie)), $txt_locase); //nájdenie hľadaného textu v nadpise
	$pozicia_text=strpos($txt_text_upr, $txt_locase); //nájdenie hľadaného textu v texte článku
	if ($pozicia_nadpis !== false) { //Našlo sa v nadpise ?
	 $spec_txt2=str_replace($txt_normal,"<span>$txt_normal</span>",$txt_vychodzie); //Zvýraznenie hľadaného textu
	 $najdene=true; //Info o tom, že som niečo našiel
	 echo("<p class=\"oznamy\">");//$zaznam_cl[id_clanok] - $zaznam_cl[nazov]<br />");
	 echo("<a href=\"index.php?clanok=$zaznam_cl[id_hlavne_menu]&amp;id_clanok=$zaznam_cl[id_clanok]\" title=\"$txt_vychodzie\" class=\"spec1\">$spec_txt2</a>");
	 echo("</p>");
	}
    if ($pozicia_text !== false) { //Našlo sa v texte ?
	 $spec_txt2=str_replace($txt_normal,"<span class=\"hladaj\">$txt_normal</span>",$zaznam_cl["text"]); //Zvýraznenie hľadaného textu
	 $najdene=true; //Info o tom, že som niečo našiel
	 echo("<p class=\"oznamy\">");//$zaznam_cl[id_clanok] - $zaznam_cl[nazov]<br />");
	 echo("<a href=\"index.php?clanok=$zaznam_cl[id_hlavne_menu]&amp;id_clanok=$zaznam_cl[id_clanok]\" title=\"$txt_vychodzie\" class=\"spec1\">$txt_vychodzie</a>");
	 if ($pozicia_text<50) echo(mb_substr($spec_txt2,0,100)."...");
	 else echo("...".mb_substr($spec_txt2,$pozicia_text-50,100)."...");
	 echo("</p>");
	}	
   }
   if (!$najdene) stav_zle("Nič som nenašiel!");
   echo("</div>");
  }
}
else stav_dobre("Mal by som niečo hľadať?");
?>
