<?php
/* Tento súbor slúži na vypísanie aktuánych oznamov, aktualizácií a článkov
   Zmena: 13.02.2017 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
//Inicializácia
$datumc_ozn=StrFTime("%Y-%m-%d",strtotime("0 day"));   // Aktuálne oznamy sú tie čo nie sú staršie ako dnes
//  --- oznamy ---
// Vyhladanie počtu aktuálnych oznamov
$navrat=prikaz_sql("SELECT id_oznamu, datum, DATE_FORMAT(datum_pridania,'%d.%m.%Y') as pdatum, oznam.nazov as onazov, text,  meno, ikonka.nazov as inazov, pocitadlo 
                           FROM oznam, clenovia, ikonka  
						   WHERE oznam.id_clena=clenovia.id_clena AND datum>='$datumc_ozn' AND oznam.id_ikonka=ikonka.id_ikonka AND oznam.id_reg<=".jeadmin()." 
						         AND zmazane>0
						   ORDER BY datum DESC",
						  "Vypis akual. oznamou (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!"); //potvrdenie,
if ($navrat) $pocet_akt_ozn=mysql_numrows($navrat); //Ak bol dopit v poriadku priraď počet inak 0 
else $pocet_akt_ozn=0;
$pocet_akt_akt=0;
$pocet_aktualnosti=$pocet_akt_ozn+$pocet_akt_akt;  //Suma za oznamy a aktualizácie
													   
if ($pocet_aktualnosti>0) {
 echo("<h2 class='oznamy'>Oznamy</h2>");
}
if ($pocet_akt_ozn>0) {  //Ak existuje aktuálny oznam
 if ($navrat) {	//Výpis aktuálnych oznamov					  
  while ($oznam = mysql_fetch_array($navrat)){
   $oznam_datum=StrFTime("%d.%m.%Y", strtotime($oznam["datum"]));
   echo("<div class=oznam>");
   echo("<img src=\"./www/ikonky/128/".$oznam["inazov"]."128.png\" width=72 height=72 class=\"far".vyp_oznam($oznam["datum"])." ikonky\" alt=\"Oznam - $oznam[onazov]\">");
   echo("<h3>$oznam[onazov]<span> pridané: $oznam[pdatum]");
   if (jeadmin()>2) echo(" | Platí do: $oznam_datum | Zobrazený: $oznam[pocitadlo]");
   echo("</span></h3>");
   if (strlen($oznam["text"])>150) {
    $text_oznam=substr(strip_tags($oznam["text"]),0,150)."...";
    $text_oznam=$text_oznam."<a href=\"index.php?co=oznam_info&amp;id_clanok=$oznam[id_oznamu]\" title=\"Zobrazenie celého oznamu\">&gt;&gt;&gt; celý oznam</a>"; 
   }
   else $text_oznam=strip_tags($oznam["text"]);
   echo("<p>$text_oznam</p>");
   if (jeadmin()>2) echo("<span>$oznam[meno]</span>");
   echo("</div>");
  }
 }
}