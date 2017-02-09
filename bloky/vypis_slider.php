<?php
 /* Tento súbor slúži na vypísanie div-u pre slider spolu s nastavením pre jQuery
    Zmena: 09.02.2017 - PV
*/
if ($bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

$pol_slider=prikaz_sql("SELECT * FROM slider ORDER by poradie" ,
                       "Položky slideru (".__FILE__ ." on line ".__LINE__ .")","Je mi ľúto, ale slider sa kôli chybe nepodarilo vykresliť!");
if ($pol_slider && mysql_numrows($pol_slider)>0) {  //Ak bola požiadavka v DB úspešná a ak sa našli položky slideru
  while ($pslider=mysql_fetch_array($pol_slider)) {
    if ($pslider["zobrazenie"]==NULL) {
      echo('<img src="'.$pslider['subor'].'" alt="'.$pslider['popis'].'" />'); //Neobmedzené zobrazenie
    } else {
      $v_vysl=explode(",",$pslider["zobrazenie"]); //Rozdelenie obmedzení z textu oddeleného čiarkou do poľa napr. 1,3 -> $vysl[0]=1; $vysl[1]=3
      foreach($v_vysl as $vysl) {
        if((int)$vysl==$zobr_clanok) {
          echo('<img src="'.$pslider['subor'].'" alt="'.$pslider['popis'].'" />'); //Blok sa zobrazí len ak je v zozname obmedzení
        }
      }
    }
  }
}