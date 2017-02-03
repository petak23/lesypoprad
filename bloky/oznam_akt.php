<?php
/* Tento súbor slúži na vypísanie aktuánych oznamov, aktualizácií a článkov
   Zmena: 21.09.2011 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
//$pocet_akt=0; //Inicializácia
$datumc_ozn=StrFTime("%Y-%m-%d",strtotime("0 day"));   // Aktuálne oznamy sú tie čo nie sú staršie ako dnes
//$datumc_akt=StrFTime("%Y-%m-%d",strtotime("-5 day")); // Aktuálne aktualizácie sú tie čo nie sú staršie ako 5 dní
//  --- oznamy ---
// Vyh2adanie počtu aktuálnych oznamov
$navrat=prikaz_sql("SELECT id_oznamu, datum, DATE_FORMAT(datum_pridania,'%d.%m.%Y') as pdatum, oznam.nazov as onazov, text,  meno, ikonka.nazov as inazov, pocitadlo 
                           FROM oznam, clenovia, ikonka  
						   WHERE oznam.id_clena=clenovia.id_clena AND datum>='$datumc_ozn' AND oznam.id_ikonka=ikonka.id_ikonka AND oznam.id_reg<=".jeadmin()." 
						         AND zmazane>0
						   ORDER BY datum DESC",
						  "Vypis akual. oznamou (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!"); //potvrdenie,
if ($navrat) $pocet_akt_ozn=mysql_numrows($navrat); //Ak bol dopit v poriadku priraď počet inak 0 
else $pocet_akt_ozn=0;
//  --- aktualizácie ---
/*$navrat=prikaz_sql("SELECT datum FROM aktualizacia WHERE datum>='$datumc_akt' ORDER BY datum LIMIT 1", //Vyhľadanie počtu aktuálnych aktualizácií
                   "Aktuálne aktualizácie (".__FILE__ ." on line ".__LINE__ .")","");
if ($navrat) $pocet_akt_akt=mysql_numrows($navrat); //Ak bol dopit v poriadku priraď počet inak 0 
else */$pocet_akt_akt=0;
$pocet_aktualnosti=$pocet_akt_ozn+$pocet_akt_akt;  //Suma za oznamy a aktualizácie
													   // Aktuálnosť ostatných položiek je v DB
/*$pocet_akt_cla=0; //Nasledujúci príkaz je platný len ak dátum pl. bude a typ je 1 alebo typ je 2
$navrat=prikaz_sql("SELECT datum FROM clanok 
                    WHERE ((datum_platnosti>='$datumc_ozn' AND id_typ=1 ) OR id_typ=2) AND id_reg<=".jeadmin()." AND id_hlavne_menu=10 AND zmazane=0
                    ORDER BY datum",
                   "Aktuálne články (".__FILE__ ." on line ".__LINE__ .")","");
if ($navrat) $pocet_akt_cla=mysql_numrows($navrat); //Ak bol dopit v poriadku priraď počet inak 0 
else $pocet_akt_cla=0;
$pocet_aktualnosti=$pocet_aktualnosti+$pocet_akt_cla;*/
if ($pocet_aktualnosti>0) {
 //echo("<h2>Čo sa deje aktuálne?</h2>"); //|$pocet_aktualnosti| Ak sa nájde nejaká na vypísanie
 echo("<h2 class='oznamy'>Oznamy</h2>");
 //echo("<div id=oznam>"); //Začiatok id-oznamy
}
if ($pocet_akt_ozn>0) {  //Ak existuje aktuálny oznam
 //mysql_data_seek($navrat,0); //Presun pointeru na začiatok DB tabuľky
 if ($navrat) {	//Výpis aktuálnych oznamov					  
  while ($oznam = mysql_fetch_array($navrat)){
   $oznam_datum=StrFTime("%d.%m.%Y", strtotime($oznam["datum"]));
   echo("<div class=oznam>");
   echo("<img src=\"./ikonky/128/".$oznam["inazov"]."128.png\" width=72 height=72 class=\"far".vyp_oznam($oznam["datum"])." ikonky\" alt=\"Oznam - $oznam[onazov]\">");
   echo("<h3>$oznam[onazov]<span> pridané: $oznam[pdatum]");
   if (jeadmin()>2) echo(" | Platí do: $oznam_datum | Zobrazený: $oznam[pocitadlo]");
   echo("</span></h3>");
   if (strlen($oznam["text"])>150) {
    $text_oznam=substr(strip_tags($oznam["text"]),0,150)."...";
    $text_oznam=$text_oznam."<a href=\"index.php?co=oznam_info&amp;id_clanok=$oznam[id_oznamu]\" title=\"Zobrazenie celého oznamu\">&gt;&gt;&gt; celý oznam</a>"; 
   }
   else $text_oznam=strip_tags($oznam["text"]);
   echo("<p>$text_oznam</p>"); //<br />
   if (jeadmin()>2) echo("<span>$oznam[meno]</span>");
   //if ($oznam["potvrdenie"]>0 and jeprihlaseny()) {include ("./bloky/ucast.php");}
   echo("</div>");
  }
 }
}
//echo("</div>"); //Ukončenie id=oznamy
/*if ($pocet_akt_akt>0) {  // Zistenie a vypísanie aktualnych aktualizácií
 $navrat_aktualizacia=prikaz_sql("SELECT id_akt, DATE_FORMAT(datum,'%d.%m.%Y') as datum, text, meno FROM aktualizacia, clenovia 
                                  WHERE aktualizacia.id_clena=clenovia.id_clena AND datum>='$datumc_akt' ORDER BY datum DESC LIMIT 1",
  							     "Vypis akual. aktual (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
 if ($navrat_aktualizacia) {
  while ($aktualizacia = mysql_fetch_array($navrat_aktualizacia)){
	echo("<img src=\"./images/ikonky/64/ceruza_cierna64.png\" alt=\"Aktualizácia - $aktualizacia[datum]\">");
    echo("<h4>$aktualizacia[datum]</h4>");
    echo("<p class=oznam>&nbsp;$aktualizacia[text]<br /><span>$aktualizacia[meno]</span></p>");
  }
 }
}
if ($pocet_akt_cla>0) {  // Zistenie a vypísanie aktualnych článkov
$navrat_clanok=prikaz_sql("SELECT id_clanok, DATE_FORMAT(datum,'%d.%m.%Y') as datum1, DATE_FORMAT(datum_platnosti,'%d.%m.%Y') as datum_pl,clanok.nazov as nazov, 
                                  text, meno, pocitadlo, id_typ
                           FROM clanok, clenovia 
                           WHERE clanok.id_clena=clenovia.id_clena AND clanok.id_reg<=".jeadmin()." AND
 					             ((datum_platnosti>='$datumc_ozn' AND id_typ=1 ) OR id_typ=2) AND id_hlavne_menu=10 AND zmazane=0
						   ORDER BY datum DESC",
  	 					   "Vypis akual. aktual (".__FILE__ ." on line ".__LINE__ .")","Žiaľ doško k chybe v databáze. Prosím skúste neskôr!");
 if ($navrat_clanok) {
  while ($clanok = mysql_fetch_array($navrat_clanok)){
    echo("<img src=\"./images/users_color_64.png\" alt=\"Článok - $clanok[nazov]\"><h4>$clanok[nazov] <span>$clanok[datum1]");
	echo($clanok["id_typ"]==1 ? " - (Aktuálne do: $clanok[datum_pl])" : " ");
	echo("</span></h4>"); 
    if (strlen($clanok["text"])>150) {
     $text_oznam=substr(strip_tags($clanok["text"]),0,150)."...";
     $text_oznam=$text_oznam."<a href=\"index.php?clanok=10&amp;id_clanok=$clanok[id_clanok]\">&gt;&gt;&gt; celý článok</a>"; 
    }
    else $text_oznam=strip_tags($clanok["text"]);
    echo("<p class=oznam>$text_oznam<br /><span>$clanok[meno]</span></p>");
   }
  }
}*/
//if ($pocet_aktualnosti>0) echo("</div>"); //Ukončenie id-oznamy
?>
