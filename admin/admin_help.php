<?php
/* Tento súbor slúži na vypísanie helpu a návodu pre admina
   Zmena: 19.07.2011 - PV
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h2>Pomocník a dokumentácia</h2>");
if (jeadmin()==5) { //Časť helpu určená len pre administrátora
?>
<p class=uvod><i>Posledná zmena 15.06.2011 - PV</i></p>
<h3>Názvy súborov</h3>
<p class=uvod>Súbory, ktoré sa priamo vzťahujú na položky hlavného menu majú nasledujúci formát názvu súboru a prípony:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><i>{nazov}_info.php</i></b></p>
<p class=uvod>Poznámka: <i>Od 19.4.2011 už <b>NIE je!!!</b> podporovaná koncovka .html</i> 
</p>

<h3>Základné rozloženie stránky</h3>
<p class=uvod>Rozloženie stránky sa načíta z DB z tabuľky <code>hl_menu</code> a môže nadobudnúť hodnoty:
<table border=0 align=center>
 <tr><td>0 - stránka má 2 stĺpce ľavý a stred+pravý</td><td><code>|--|-------|</code></td><td>(Toto je prednastavená hodnota.)</td></tr>
 <tr><td>1 - stránka má jeden stĺpec</td><td><code>|----------|</code></td><td></td></tr>
 <tr><td>2 - stránka má 3 stĺpce</td><td><code>|--|----|--|</code></td><td></td></tr>
 <tr><td>3 - stránka má 2 stĺpce ľavý+stred a pravý</td><td><code>|-------|--|</code></td><td></td></tr>
</table> 
Pri troch stĺpcoch sa pravý a ľavý stĺpec načítajú cez súbory bloky_l.php a bloky_r.php. Stredný stĺpec je vyhradený samotnému článku.
</p>

<h3>Základná štruktúra stránky pre prenos údajov</h3>
<p class=uvod>Štruktúra stránky je rozdelená na nasledujúce hlavné časti:
<ol>
	<li><b><u>HLAVNÁ PONUKA</u></b><i>(Zadáva, opravuje, maže - <b>ADMIN</b>)</i><br />V odkaze je to položka <code>clanok</code> v programe <code>$zobr_clanok</code> 
	a prenáša sa <code>id_hlavne_menu</code> čo je vždy odkaz na súbor s menom <code>*_info.php</code>.</li>
	<li><ol type="A">
	  <li><b><u>POD MENU(sub_menu)</u></b><i>(Zadáva, opravuje, maže - <b>ADMIN</b>)</i><br />V odkaze je to položka <code>id_clanok</code> v programe <code>$zobr_pol</code> 
	a prenáša sa textový identifikátor na príslušný súbor.</li>
	  <li><b><u>ČLÁNOK</u></b><i>(Zadáva, opravuje, maže - <b>ADMIN a UŽÍVATEĽ s oprávnením</b>)</i><br />V odkaze je to položka <code>id_clanok</code> v programe <code>$zobr_pol</code> 
	a prenáša sa číslo <code>id_clanok</code> na príslušný článok.</li>
	 </ol>
	</li> 
	<li><b><u>POD ČLÁNOK</u></b><i>(Zadáva, opravuje, maže - <b>ADMIN a UŽÍVATEĽ s oprávnením</b>)</i><br />V odkaze je to položka <code>cast</code> v programe <code>$zobr_cast</code> 
	a prenáša sa číslo <code>id_clanok</code> na príslušný článok.</li>
</ol>
</p>
<h3>Identifikácia článku v DB tabuľke články</h3>
<p class=uvod>
<ul>
  <li><code>id_clanok</code> - základné číslo článku</li>
  <li><code>podclanok</code> - identifikácia typu článku. 
    <ul>
	 <li><code>podclanok = 0</code> - clánok</li>
	 <li><code>podclanok > 0</code> - podclanok
	  <ol>
	   <li><code>podclanok = 1</code> - odkaz na podčlánok sa zobrazí v POD MENU a záhlaví nadradeného článku.</li>
	   <li><code>podclanok = 2</code> - odkaz na podčlánok sa zobrazí v POD MENU.</li>
	   <li><code>podclanok = 3</code> - odkaz na podčlánok sa zobrazí v záhlaví nadradeného článku.</li>
	 </li>
	</ul>
  </li>
  <li><code>id_hlavne_menu</code> - identifikácia nadradenej položky:
    <ul>
     <li>Ak je článok tak skutočné <code>id_hlavne_menu</code>, ku ktorému článok patrí.</li>
     <li>Ak je podčlánok tak sa rovná <code>id_clanok</code> nadradeného článku, ku ktorému článok patrí.</li></ul>
  </li>
  <li><code>id_ikonka</code> - ikonka v hlavičke článku. Ak je hodnota -1 tak sa jedná o prázdny článok.
</ul>
</p>
<h3>Jednotný vzor odkazu</h3>
<p class=uvod><code>./index.php?clanok=3&id_clanok=1&cast=5&co=new_clanok</code>
<ol>
<li><code>clanok&nbsp;&nbsp;&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;<code>$zobr_clanok</code>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;
  hlavná identifikácia v hlavnom menu aj ako $zobr_clanok. Prednastavená hodnota je 1 = Úvod, kde <code>číslo=id_hlavne_menu</code>.</li>
<li><code>id_clanok</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;<code>$zobr_pol</code>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;
  identifikácia konkrétneho článku v danej časti.</li>
<li><code>cast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;<code>$zobr_cast</code>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;
  toto je nové pre ďaľšiu úroveň zobrazenia napr. vo fotogalérii.</li>
<li><code>co&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;<code>$zobr_co</code>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;
  definovanie operácie, ktorá sa má na tejto úrovni uskutočniť.</li>
</ol> 
</p>

<h3>Položka ZOBRAZENIE</h3>
<p class=uvod>Položka <code>zobrazenie</code> slúži na voľbu spôsobu zobrazenia jednotlivých riadkov v tabuľke a to:
<ol>
<li><code>zobrazenie&nbsp;>&nbsp;0&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;tento riadok tabuľky sa zobrazí normálne.</li>
<li><code>zobrazenie&nbsp;=&nbsp;0&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;tento riadok sa nezobrazí.</li>
<li><code>zobrazenie&nbsp;<&nbsp;0&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;tento riadok sa považuje za "zmazný".</li>
</ol> 
</p>

<h3>Pevné priradenie <code>id_clanok</code></h3>
<p class=uvod>Pre niektoré články je pevne priradené <code>id_clanok</code> a to:
<ol>
<li><code>id_clanok&nbsp;=&nbsp;1&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;článok "O NÁS".</li>
<li><code>id_clanok&nbsp;=&nbsp;2&nbsp;</code>&nbsp;&nbsp;=&raquo;&nbsp;&nbsp;článok "KONTAKTY".</li>
</ol> 
</p>

<h3>Zmena čísel odkazov</h3>
<p class=uvod>Súbory, v ktorých je nutné zmeniť čísla indexov pri prechode na iný web:
<br /><i>bloky\vypis_sub_menu.php</i>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;na 16. riadku je odkaz na položku hlavného menu pre OZNAM (pridávanie oznamov).
<br /><i>bloky\oznam_akt.php</i>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;na 47. riadku je odkaz na položku hlavného menu pre OZNAM.
<br /><i>bloky\oznam_akt.php</i>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;na 83. riadku je odkaz na položku hlavného menu pre ČLÁNOK.
<br /><i>admin\admin_sub_menu.php</i>&nbsp;&nbsp;&raquo;&nbsp;&nbsp;na 126. riadku je odkaz na položku hlavného menu pre ČLÁNOK (else pre chybu v DB).
</p>

<?php } //KONIEC Časti helpu určená len pre administrátora 
?>
<h3>Zadávanie oznamov, článkov a podčlánkov</h3>
<p class=uvod>&nbsp;Dňom 1.4.2011 sa men&iacute; a sn&aacute;ď aj zjednodu&scaron;uje zad&aacute;vanie oznamov, čl&aacute;nkov a podčlánkov.</p>
<p class=uvod>Postup pre čl&aacute;nok a podčlánok je nasledovn&yacute;:
<ol>
    <li>Je možn&eacute; prid&aacute;vať čl&aacute;nky len do niektor&yacute;ch oblast&iacute; (napr. &Scaron;k&ocirc;lka, Čl&aacute;nky).</li>
    <li>Tam, kde je to možn&eacute; je vľavo pod hlavičkou tlačidlo na pridanie čl&aacute;nku. Ďal&scaron;&iacute; postup je rovnak&yacute;.</li>
	<li>Tam, kde je možné zadávať podčlánok je pod príslušnou položkou bočného menu farebne odlíšená položka "Pridanie podčlánku". Pomocou tejto
	    položky sa pridá podčlánok cez rovnaký formulár ako v prípade článku.</li>
    <li>Z&aacute;roveň, každ&yacute; m&ocirc;že editovať a vymazať čl&aacute;nok, ktor&yacute; zadal.</li>
</ol>
</p>
<p class=uvod>Postup pre oznam je nasledovn&yacute;:
<ol>
    <li>Oznamy sa prid&aacute;vaj&uacute;&nbsp;v&nbsp;časti OZNAM.&nbsp;Vľavo pod hlavičkou tlačidlo na pridanie oznamu. Ďal&scaron;&iacute; postup je rovnak&yacute; ako doteraz.</li>
    <li>Z&aacute;roveň, každ&yacute; m&ocirc;že editovať a vymazať oznam, ktor&yacute; zadal.</li>
</ol>
</p>

<h3>Zadávanie obsahu stránky</h3>
<p class=uvod>
<ol type="A">
    <li><b>Vytvorenie hlavného menu</b><br />Vzhľadom na väzby v systéme položky zadáva/edituje na základe požiadavky užívateľa <b><i>ADMIN</i></b>.<br />
     V požiadavke sa určí názov položiek, veľkosť hlavičky, úroveň registrácie, zvýraznenie, možnosť pridávať články.
    </li>
    <li><b>Pridávanie článkov</b><br />Tam, kde je to dovolené je možné k položkám hlavného menu pridávať články. Tieto tvoria samotný obsah webu. 
     Zadávanie článkov má dve úrovne. Úroveň článku a podčlánku.
     <ol type="a">
      <li><b>Zadávanie článku</b><br />Tam, kde je možné pridať článok je vľavo pod hlavičkou tlačidlo na pridanie čl&aacute;nku. Pri zadávaní sa zadávajú nasledujúce údaje:
       <ol type="1">
        <li>Názov článku.</li>
        <li>Či sa sleduje aktuálnosť článku. Ak áno zadáva sa dokedy je článok platný.</li>
        <li>Úroveň registrácie.</li>
        <li>Či sa jedná o takzvaný "prázdny" alebo "klasický" článok. "Prázdny" článok je taký, pre ktorý sa v bočnej ponuke zobrazí položka, ale táto nie je odkazom.</li>
        <li>Či sa článok zmaže z databázy po 90 dňoch.</li>
        <li>Či sa má posielať e-mail o zadaní článku registrovaným užívateľom.</li>
        <li>Úvodná ikonka článku.</li>
        <li>Text.</li>
       </ol>
       Pozn.: Body 7 a 8 sa zadajú len ak sa nejedná o "prázdny" článok. 
      </li>
     </ol> 
    </li>
    <li><b>Zadávanie podčlánku pre "klasický" a "prázdny" článok.</b>
     <ol type="a">
      <li><b>Pre "KLASICKÝ" článok</b>&nbsp;&nbsp;<code>id_ikonka > -1</code><br />
      Odkaz na pridanie podčlánku pre klasický článok sa nachádza po zobrazení v jeho hlavičke spolu s odkazom na editáciu a vymazanie tohto článku.
      Po kliknutí na túto položku sa zobrazí podobný formulár ako pre zadanie článku. Body č. 1, 5 - 8 sú bez zmeny.<br>Zmeny:<br>
      Bod č.2: Aktuálnosť podčlánku je rovnaká ako nadradeného článku.<br>
      Bod č.3: Úroveň registrácie je rovnaká ako nadradeného článku.<br>
      Bod č.4: Je možné sa rozhodnúť, kde sa zobrazí odkaz na podčlánok. Zvoliť je možné: V bočnej ponuke a/alebo v hlavičke článku.
      </li>
      <li><b>Pre "PRÁZDNY" článok</b>&nbsp;&nbsp;<code>id_ikonka == -1</code><br />
      Odkaz na pridanie sa nachádza v bočnej ponuke pod položkou "prázdneho" článku. Ostatné platí ako pre "klasický" článok so zmenou v bode č. 4, kde je možná len alternatíva pre bočnú ponuku. 
      </li>
     </ol>
    </li>
    <li><b>Editácia a vymazanie článku a podčlánku.</b><br />
     Bežný registrovaný užívateľ má právo editovať a mazať len (pod)články, ktoré zadal. 
     Odkaz na editáciu a vymazanie (pod)článku sa nachádza: 
     <ol type="a">
      <li>v hlavičke článku</li> 
      <li>v hlavnej ponuke v strednej časti, keď nie je zobrazený žiaden konkrétny (pod)článok. Je to po kliknutí na položku hlavného menu.</li>
     </ol> 
     Pre "prázdny" článok platí len možnosť b.). Pre podčlánok platí len možnosť a.)
     Upozornenie: Pri mazaní článku, ktorý má priradené podčlánky, sa zmažú aj tieto! 
    </li>    
</ol>	
</p>