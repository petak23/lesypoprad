<?php
if ($bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
function pripoj_db()
{
 if ($_SERVER["SERVER_ADDR"]=="127.0.0.1"){
   define("SQL_HOST","localhost");
   define("SQL_DBNAME","mlpp");
   define("SQL_USERNAME","root");
   define("SQL_PASSWORD","");
 }
 else{
   define("SQL_HOST","wm13.wedos.net");
   define("SQL_DBNAME","d13862_mlpp");
   define("SQL_USERNAME","a13862_mlpp");
   define("SQL_PASSWORD","adminMLPP-5410");
 }
 $GLOBALS["link"]=mysql_connect(SQL_HOST, SQL_USERNAME, SQL_PASSWORD);
 if (!$GLOBALS["link"]) {chyba("Nie je možné sa pripojiť k MySQL: ".mysql_error(),"");return false;}
 else {
   @$databaza=mysql_select_db(SQL_DBNAME);
   if (!$databaza) {chyba("Nedá sa vybrať databáza: ".mysql_error(),"");return false;}
   mysql_set_charset('utf8_bin',$GLOBALS["link"]);
 }
 return true;
}

function jeadmin_typ ($typ)
  /* Funkcia na zistenie, či daný prihlásený užívateľ je niektorý typ registrovaného užívateľa
     Vstupy: - $typ -> Môže to byť text, alebo číslo podľa tabuľky "registracia" položky "nazov" alebo "uroven"
	 Výstupy: true ak je to tak inak false
	 Obmedzenie: zatiaľ mi nie je známe
    Zmena: 24.9.2010 - PV
  */
{
  if ((int)$typ==0) {
   if (!isset($_SESSION["id"]) or (int)$_SESSION["id"]==0) return false;
   $vys_reg=prikaz_sql("SELECT id_reg FROM registracia WHERE nazov='$typ'","najdenie v reg (".__FILE__ ." on line ".__LINE__ .")","");
   if ($vys_reg) {
    $zaz_reg=mysql_fetch_array($vys_reg);
	$id_reg=$zaz_reg["id_reg"];
   }
  } 
  else $id_reg=$typ;
  $vysledok=prikaz_sql("SELECT id_reg FROM clenovia WHERE id_clena='".$_SESSION["id"]."' AND id_reg=$id_reg", "najdenie v reg (".__FILE__ ." on line ".__LINE__ .")","");
  if ($vysledok) $zaz_admin=mysql_fetch_array($vysledok);
  if (@$zaz_admin["id_reg"]>0) return true;
  return false;
}

function jeadmin ()
  /* Funkcia na zistenie úrovne registrácie prihláseného užívateľa. 
     Vstupy: cez Session
	 Výstupy: úroveň registrácie alebo 0
	 Obmedzenie: zatiaľ mi nie je známe
     Zmena: 25.2.2010 - PV
  */
{
  if (!isset($_SESSION["id"]) or (int)$_SESSION["id"]==0) return 0;
  $vysledok=mysql_query("SELECT id_reg FROM clenovia WHERE id_clena='".$_SESSION["id"]."'");
  $zaz_admin=mysql_fetch_array($vysledok);
  if ((int)$zaz_admin["id_reg"]<1) return 0;
  return (int)$zaz_admin["id_reg"];
}

function jeprihlaseny ()
{
  if (isset($_SESSION["id"]) and !(int)$_SESSION["id"]==0) return true; else return false;
}

function jeprihlaseny_id ($id)
{
  if (isset($_SESSION["id"]) and $_SESSION["id"]==$id) return true; else return false;
}

function ceskedatum ($datum)
{
	if ($datum =="") return "";
	return strftime("%d.%m.%Y",strtotime($datum));
}

function jepriestupny($rok)
{ if (($rok%4==0) && (!$rok%100==0 || $rok%400==0)) return 366;
 else return 365;
}

function poc_dnou($mesiac, $rok)
/*--vrati pocet dni v mesiaci --*/
{
 $dni=31;
 if (($mesiac==4) || ($mesiac==6) || ($mesiac==9) || ($mesiac==11)){ $dni=30; }
 If ($mesiac==2){ if (jepriestupny($rok)==366) {$dni=29;} else {$dni=28;} }
/*return cal_days_in_month(CAL_GREGORIAN, $mesiac, $rok);*/
return $dni;
}

function ake_nav($pocet)
{
$pocet=(int)$pocet;
if ($pocet >= 230){ $nav="nav_volno.gif";}
  else{if ($pocet >= 205){ $nav="nav_oc80.gif";}
   else{if ($pocet>180){ $nav="nav_oc40.gif";}
    else{if ($pocet>155){ $nav="nav_oc0.gif";}
     else{if ($pocet>130){ $nav="nav_40.gif";}
      else{if ($pocet>105){ $nav="nav_40oc80.gif";}
       else{if ($pocet>80){ $nav="nav_40oc40.gif";}
        else{if ($pocet>55){ $nav="nav_40oc0.gif";}
         else{if ($pocet>30){ $nav="nav_priv.gif";}
          else{$nav="nav_stoj.gif";}
  }}}}}}}}
return $nav;
}

function ake_poradie($pocet)
{
$pocet=(int)$pocet;
if ($pocet > 0){ $nav="sipka_hore.gif";}
elseif ($pocet == 0){ $nav="sipka_nic.gif";}
else {$nav="sipka_dole.gif";}
return $nav;
}

function ake_poc($pocet)
{
$pocet=(int)$pocet;
if ($pocet > 0){ $nav="sipka_hore.gif";}
else {$nav="sipka_nie.gif";}
return $nav;
}

function prikaz_sql($sql_prikaz, $text, $hlasenie, $log=0)
   /* Vykoná zadaný SQL príkaz a v prípade chyby vypíše hlásenie do súboru a aj na obrazovku
    Využíva funkciu chyba
    Vstupy: - $sql_prikaz -> sql príkaz
	        - $text       -> text hlásenia do súboru
            - $hlasenie   -> text hlásenie na obrazovku
			- $log        -> Ak 1 tak sa má zapísať do log súboru
    Výstupy: výsledok SQL príkazu
    Obmedzenie: zatiaľ mi nie je známe
    Zmena: 06.07.2011 - PV */
{
$vysledok=mysql_query($sql_prikaz);
//if ($log==1) log_sql($sql_prikaz." - ".$text);
if (!$vysledok){ chyba("$text Error: ".mysql_error()."<br /><b><i>&nbsp;&nbsp;&nbsp;SQL prikaz</i></b>: ".$sql_prikaz, $hlasenie); return 0;}
else return $vysledok;
}

function chyba($text, $hlasenie)
   /* Výpíše chybové hlásenie na obrazovku a do súboru chyby.txt
    Vstupy: - $text     -> text hlásenia do súboru
            - $hlasenie -> text hlásenie na obrazovku
    Výstupy: nič
    Obmedzenie: zatiaľ mi nie je známe
    Zmena: 26.8.2010 - PV */
{
if ($hlasenie) // Výpis hlásenia na obrazovku ak $hlasenie<>""
   echo("&nbsp;<div class=st_zle>$hlasenie</div><br>");
if ($text) // Výpis textu do súboru ak $text<>""
 {
  $cas=StrFTime("%Y-%m-%d %H:%M:%S", Time());
  $subor=fopen("./chyby.txt", "a");
  $pom="- <I>";
  if (@$_SESSION[id]>0) $pom=$pom.$_SESSION["prezyvka"]; // U koho sa chyba vyskytla
  else $pom=$pom."Neprihl.";
  $pom=$pom."</I> - $text";
  $tt="<B>[$cas]</B> $pom<BR>\n";
  fwrite($subor,$tt);
 } 
}

function log_sql($text)
   /* Výpíše chybové hlásenie do súboru log.txt
    Vstupy: - $text     -> text hlásenia do súboru
            - $hlasenie -> text hlásenie na obrazovku
    Výstupy: nič
    Obmedzenie: zatiaľ mi nie je známe
    Zmena: 06.07.2011 - PV */
{
if ($text) // Výpis textu do súboru ak $text<>""
 {
  $cas=StrFTime("%Y-%m-%d %H:%M:%S", Time());
  $subor=fopen("./log.html", "a");
  $pom="- <I>";
  if (@$_SESSION[id]>0) $pom=$pom.$_SESSION["prezyvka"]; // U koho sa chyba vyskytla
  else $pom=$pom."Neprihl.";
  $pom=$pom."</I> - $text";
  $tt="<B>[$cas]</B> $pom<br />\n";
  fwrite($subor,$tt);
 } 
}

function chyba_pis($hlasenie)
   /* Výpíše chybové hlásenie na obrazovku - biely podklad a červené písmo alebo podľa class=chyba_pis
    Vstupy: - $hlasenie -> text hlásenie na obrazovku
    Výstupy: nič
    Obmedzenie: zatiaľ mi nie je známe
    Zmena: 27.2.2008 - PV */
{
echo("&nbsp;<div class=chyba_pis>$hlasenie</div><br>");
}
function hlasenie_pis($hlasenie)
   /* Výpíše hlásenie na obrazovku - biely podklad a zelené písmo alebo podľa class=hlasenie_pis
    Vstupy: - $hlasenie -> text hlásenie na obrazovku
    Výstupy: nič
    Obmedzenie: zatiaľ mi nie je známe
    Zmena: 01.8.2008 - PV */
{
echo("&nbsp;<div class=hlasenie_pis>$hlasenie</div><br>");
}

function kolko_zaznamov($tabulka)
	/* Zistí počet záznamov starších ako dátum v tabuľke.
	Vstupy: - $tabulka -> názov tabuľky, v ktorej sa má hľadať
	Výstupy: 0 - ak je chyba v mysql, alebo nie je žiaden požadovaný záznam,
						číslo - počet nájdených záznamov,
	 					false - ak je chbne zadaný dátum.
	Obmedzenie: - platí len pre tabuľky, kde je dátum v stĺpci s názvom kedy.
	  	        - formát dátumu sa musí zhodovať s formátom položky kedy.
	Zmena: 18.1.2010 - PV		*/
{
$datum_posl_pr=StrFTime("%Y%m%d%H%M%S", strtotime($_SESSION["dat_pr"])); //Zistenie dátumu a času posledného prihlásenia z session.
																		 //Session existuje len po prihlásení.
if (!$datum_posl_pr) return false; //Kontrola či sa dátum vytvoril 
else {
 $news_tabulka=mysql_query("SELECT * FROM $tabulka WHERE kedy>$datum_posl_pr");
 if (!$news_tabulka) return 0;             //Ak prebehne SQL príkaz v poriadku tak sa vráti hodnota počtu inak 0
 else return mysql_numrows($news_tabulka);
 }
}

function vzhlad_stranky()
    /* Vyberie vzhľad stránky podľa prihláseného člena
    Vstupy: - nie sú
	Výstupy: - návratová hodnota z databázy podľa id_clena ak je prihlásený
	Obmedzenie: Zatiaľ neviem
	Zmena: 11.2.2008 - PV       */
{
  $vzhlad_str="peter";  //prednastavený vzhľad stránky
  if (jeprihlaseny()) { //Ak je prihlásený hľadá sa v databáze
    $vysledok=prikaz_sql("SELECT vzhlad FROM clenovia WHERE id_clena='".$_SESSION["id"]."'", "Function vyhlad_stranky(".__FILE__ ." on line ".__LINE__ .")","");
    if ($vysledok>0) {  //Ak prebehol sql prikaz uspesne vyberie sa vzhľad stránky z databázy
      $zaz_admin=mysql_fetch_array($vysledok);
      if (!mysql_numrows($vysledok)==0) $vzhlad_str=$zaz_admin["vzhlad"];
    }
  }
  return $vzhlad_str;
}

function pocitadlo($pocitadlo)
    /* Nájde počítadlo a pripočíta 1 a vráti aktuánu hodnotu po pripočítaní
	Vstupy - $pocitadlo -> id_hladaného pocitadla
	Výstupy - stav pocitadla po pripocítaní. Ak -1 tak chyba.
	Obmedzenie: ???
	Zmena: 22.10.2010 - PV          */
{
@$navrat=prikaz_sql("SELECT pocita FROM pocitadla WHERE id_poc=$pocitadlo",
                    "Nájdenie počítadla (".__FILE__ ." on line ".__LINE__ .")","Počítadlo nefungovalo...");
if ($navrat){
  $zaznam=mysql_fetch_array($navrat);
  $pocet=$zaznam["pocita"]+1;
  @$zmena_p=prikaz_sql("UPDATE pocitadla SET pocita=$pocet WHERE id_poc=$pocitadlo",
                       "Update počítadla (".__FILE__ ." on line ".__LINE__ .")","Nedalo sa pripočítať...");
  if ($zmena_p) return $pocet;
  else return -1;
 }
 else return -1;
}

function down_header($subor)
	/* Obsahuje kód pre hlavičku súboru na download a počítanie downloadu súboru
	Vstupy - $subor -> id_suboru na download
	Výstupy - hlavička súboru
	Obmedzenie: ???
	Zmena: 22.10.2010 - PV          */
{
if (@(int)$subor>0) { //Slúži na evidenciu downloadu súborov
 $subor=(int)$subor;
 @$navrat=prikaz_sql("SELECT * FROM pocitadla WHERE id_poc=$subor",
                     "Nájdenie počítadla (".__FILE__ ." on line ".__LINE__ .")","Počítadlo nefungovalo...");
 if ($navrat){
  $zaznam=mysql_fetch_array($navrat);
  $pocet=$zaznam["pocita"]+1;
  @$zmena_p=prikaz_sql("UPDATE pocitadla SET pocita=$pocet WHERE id_poc=$subor",
                       "Update počítadla (".__FILE__ ." on line ".__LINE__ .")","Nedalo sa pripočítať...");
  if ($zmena_p){ 
   header("Content-Description: File Transfer");
   header("Content-Type: application/force-download");
   header("Content-Disposition: attachment; filename=\"$zaznam[nazov]\"");
   header("Location: ./download/$zaznam[nazov]");
  } 
 }
}
}

function odk_download($id_pocitadla, $popis, $verzia)
	/* Vypíše na obrazovku riadok pre download/otvorenie súboru, ktorý je evidovaný v databázovej tabuľke pocitadla
	Vstupy - $id_pocitadla -> identifikačné číslo počítadla z tabuľky pocitadla - pole id_poc
	       - $popis        -> popis súboru
	       - $verzia       -> číslo verzie a dátum uverejnenia
	Výstupy - na obrazovku - jeden riadok tabuľky, kde:
	                           1. bunka - image s odkazom na súbor - veľkosť bunky 40
	                           2. bunka - názov súboru a popis
	                           3. bunka - Počet stiahnutí daného súboru.
	Obmedzenie: 
	Zmena: 11.05.2010 - PV          */
{
@$navrat_sub=prikaz_sql("SELECT * FROM pocitadla WHERE id_poc=$id_pocitadla LIMIT 1",
                        "Odkaz na download(".__FILE__ ." on line ".__LINE__ .")"," Nenašiel sa požadovaný súbor.");
if ($navrat_sub) {
 $zaznam=mysql_fetch_array($navrat_sub);
 echo("<div align=left><a href=\"index.php?clanok=".$_REQUEST["clanok"]);
 if (@$_REQUEST["id_clanok"]<>"") echo("&amp;pol=".$_REQUEST["id_clanok"]);
 echo("&amp;sub=$id_pocitadla\">");
 //echo("<img src=\"images/down.gif\" border=0 hspace=0>");
 echo("<b>$zaznam[nazov]&nbsp;</b>$popis</a>[$verzia] Stiahnuté: $zaznam[pocita]x");
}
}

function posli_mail($komu, $predmet, $sprava)
    /* Pošle e-mailovú správu na uvedenú adresu s uvedeným predmetom
	Vstupy - $komu    -> e-mailová adresa príjemcu
	       - $predmet -> predmet mailu
		   - $sprava  -> text správy
    Výstupy - Ok - správa bola úspešne odoslaná podľa daných pravidiel
              Er - Chyba - správa nebola odoslaná
	Obmedzenie:
	Zmena: 17.12.2007 - PV       */
{
if (@!ereg("^.+@.+\..+$",$komu)) return "Er"; // kontrola platnosti e-mailovej adresy
$headers = "FROM: CPR - Poprad<web@rodinapp.sk>\n";
$headers=$headers."Return-Path: <error@rodinapp.sk>\n";
$headers=$headers."Content-Type: text/html; charset=windows-1250\n";
if (@mail ($komu, $predmet, $sprava, $headers)) return "Ok";
else return "Er";
}

function vypis_pol_hl_menu($cis_pol, $cl, $nazov, $zv)
    /* Vypíše odkaz položky hlavného menu podľa vstupných parametrov
	   Táto funkcia je ponechaná len dočasne. Pravdepodobne už nebude potrebná.
	Vstupy - $cis_pol -> Číslo položky menu
	         $cl      -> Názov článku pre potreby odkazu
			 $nazov   -> Text, ktorý sa zobrazý v odkaze
			 $zv      -> Ak má byť položka zvýraznená je hodnota viac ako 0.
	Výstupy - na obrazovku - vypíše tak <A></A>
	Obmedzenie:
	Zmena: 23.02.2010 - PV    */
{	
echo("<A HREF=\"./index.php?clanok=$cl&amp;bl=1\" CLASS=");
if (@$zv>0) echo("p".$cis_pol."zv");
else echo("p".$cis_pol);
echo(">$nazov</A> ");	
}

function vypis_hl_menu($cl, $nazov, $kontr_zaz, $blok)
    /* Vypíše odkaz položky hlavného menu podľa vstupných parametrov
	Vstupy - $cl        -> Názov článku pre potreby odkazu
			 $nazov     -> Text, ktorý sa zobrazý v odkaze
			 $kontr_zaz -> Kontrola záznamou v tabuľke s názvom $cl
			 $blok      -> Typ zobrazenia stránky
	Výstupy - na obrazovku - vypíše tag <A></A>
	Obmedzenie:
	Zmena: 14.04.2010 - PV    */
{	
echo("<a href=\"./index.php?clanok=$cl");
if ((int)$blok>0) echo("&amp;bl=$blok\"");
if ($kontr_zaz>0) { //Ak má byť položka kontrolovaná na záznamy
  $pocet=kolko_zaznamov($cl);
  if ($pocet>0) echo("style=\" color: #FF0000\">$nazov($pocet)");
  else echo(">$nazov");
}
else echo(">$nazov");
echo("</a> ");	
}

function vypis_hl_menu1($cl, $nazov, $kontr_zaz, $blok)
    /* Vypíše odkaz položky hlavného menu podľa vstupných parametrov
	Vstupy - $cl        -> Názov článku pre potreby odkazu
			 $nazov     -> Text, ktorý sa zobrazý v odkaze
			 $kontr_zaz -> Kontrola záznamou v tabuľke s názvom $cl
			 $blok      -> Typ zobrazenia stránky
	Výstupy - na obrazovku - vypíše tag <A></A>
	Obmedzenie:
	Zmena: 14.04.2010 - PV    */
{	
echo("<a href=\"./index.php?clanok=$cl");
$nazov=ltrim($nazov);
if ((int)$blok>0) echo("&amp;bl=$blok\"");
if ($kontr_zaz>0) { //Ak má byť položka kontrolovaná na záznamy
  $pocet=kolko_zaznamov($cl);
  if ($pocet>0) echo("class=zvyrazni><span>&nbsp;$nazov($pocet)&nbsp;</span></a>");
  else echo("><span>&nbsp;$nazov&nbsp;</span></a>");
}
else echo("><span>&nbsp;$nazov&nbsp;</span></a>");
}

function kontrola_datumu($datum) 
  /* Funkcia skontroluje správnosť zadania dátumu vo formáte RRRR-MM-DD .
     Vstupy: - $datum -> kontrolovaný dátum
	 Výstupy: false ak dátum nezodpovedá formátu RRRR-MM-DD alebo neexzistuje
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 12.2.2010 - PV
  */
{
$pole=explode("-", $datum);
if ((int)$pole[0]<2010) return false;
if ((int)$pole[1]<0 or (int)$pole[1]>12) return false;
if ((int)$pole[2]<0 or (int)$pole[2]>(poc_dnou($pole[1], $pole[0])+1)) return false;
return true;
}	

function stav_dobre($text)
  /* Funkcia vypíše text vo formáte st_dobre.
     Vstupy: - $text -> text na vypísanie
	 Výstupy: - na obrazovku - <DIV>text</DIV>
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 19.3.2010 - PV
  */
{
echo("<div class=st_dobre>$text</div>");
}

function stav_zle($text)
  /* Funkcia vypíše text vo formáte st_zle.
     Vstupy: - $text -> text na vypísanie
	 Výstupy: - na obrazovku - <DIV>text</DIV>
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 19.3.2010 - PV
  */
{
echo("<div class=st_zle>$text</div>");
}

function upload_stav($er_kod)
  /* Funkcia vypíše text chyby uploadu súboru vo formáte st_zle.
     Vstupy: - $text -> text na vypísanie
	 Výstupy: - na obrazovku - <DIV>text</DIV>
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 12.07.2011 - PV
  */
{
$text="Chyba prenosu: ";
if ($er_kod==1) $text=$text."Súbor je väčší ako max. prípustná veľkosť! Tá je: ".ini_get('upload_max_filesize');
elseif ($er_kod==2) $text=$text."Súbor je väčší ako max. prípustná veľkosť určená formulárom!";
elseif ($er_kod==3) $text=$text."Súbor bol prenesený len čiastočne!";
elseif ($er_kod==4) $text=$text."Nebol prenesený žiaden súbor!";
elseif ($er_kod==6) $text=$text."Chýba temporary adresár!";
elseif ($er_kod==7) $text=$text."Vznikla chyba pri zápise súboru na disk!";
elseif ($er_kod==8) $text=$text."Nepovolená koncovka súboru!";
else $text=$text."Neznáma chyba prenosu!";
echo("<div class=st_zle>$text</div>");
}

function vyp_nadpis($farba,$typ,$text)
  /* Funkcia vypíše nadpis vo formáte n_xx.
     Vstupy: - $farba  -> typ class-u farba
	         - $typ    -> typ nadpisu
	         - $text   -> text na vypísanie
	 Výstupy: - na obrazovku - <DIV>typ text</DIV>
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 22.4.2010 - PV
  */
{
echo("<div class=n_$farba><div>$typ</div><span>$text</span></div>");
}

function vyp_oznam($datum)
  /* Funkcia vráti id farby pre výkreslenie pozadia aktualnosti.
     Vstupy: - $datum  -> dátum platnosti
	 Výstupy: - id farby
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 12.1.2011 - PV
  */
{
   $id=0; //Inicializácia
   $dnes_den=StrFTime("%j", time());
   $dnes_rok=StrFTime("%Y", time());
   $oznam_den=StrFTime("%j", strtotime($datum));
   $oznam_rok=StrFTime("%Y", strtotime($datum));
   $kedy=2; // 0-dnes; 1-bolo; -1-bude
   if ($dnes_rok==$oznam_rok){
	 if ($dnes_den<$oznam_den){ // bude 
	   $kedy=-1;
	   $cas=$oznam_den-$dnes_den;
	 }
	 elseif ($dnes_den==$oznam_den){ // dnes 
	   $kedy=0;
	   $cas=0;
	 }
   }
   elseif ($dnes_rok<$oznam_rok){ // bude buduci rok 
     $kedy=-1;
     $cas=(jepriestupny($dnes_rok)-$dnes_den)+$oznam_den;
  }
  if ($kedy==-1){  // Pre určenie farby 
    if ($cas> 14 ) $id=1;
    if (($cas>7) && ($cas<15)) $id=2;
    if (($cas>4) && ($cas<8)) $id=3;
    if (($cas>2) && ($cas<5)) $id=4;
    if ($cas==2) $id=5;
    if ($cas==1) $id=6;
  }
  if ($kedy==0) $id=7;
  return $id;
}

function rand_str($length = 10, $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890')
 /* Funkcia na generovanie náhodného reťazca
    stiahnute z http://sk.php.net/manual/en/function.rand.php 
	Vložené : 31.01.2011
 */
{
$chars_length = (strlen($chars) - 1);             // Dĺžka reťazca
$string = $chars{rand(0, $chars_length)};         // Začiatok reťazca
for ($i = 1; $i < $length; $i = strlen($string)){ // Generovanie náhodného reťazca
  $r = $chars{rand(0, $chars_length)};            // Vyber náhodný znak zo vstupného reťazca
  if ($r != $string{$i - 1}) $string .=  $r;      // Skontroluj, že za sebou nejdú dva rovnaké znaky
}
return $string;                                   // Vráť výsledok
}

function normalize($string) {
 /* Funkcia na normalizáciu textu t.j. nahradenie diakritiky
    stiahnute z http://www.php.net/manual/en/function.strtr.php 
	Vložené : 26.07.2011
 */
$table = array(
        'Š'=>'S', 'š'=>'s', 'Đ'=>'Dj', 'đ'=>'dj', 'Ž'=>'Z', 'ž'=>'z', 'Č'=>'C', 'č'=>'c', 'Ć'=>'C', 'ć'=>'c',
        'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A', 'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E',
        'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I', 'Ï'=>'I', 'Ñ'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O',
        'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U', 'Ú'=>'U', 'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss',
        'à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a', 'å'=>'a', 'æ'=>'a', 'ç'=>'c', 'è'=>'e', 'é'=>'e',
        'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i', 'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ò'=>'o', 'ó'=>'o',
        'ô'=>'o', 'õ'=>'o', 'ö'=>'o', 'ø'=>'o', 'ù'=>'u', 'ú'=>'u', 'û'=>'u', 'ý'=>'y', 'ý'=>'y', 'þ'=>'b',
        'ÿ'=>'y', 'Ŕ'=>'R', 'ŕ'=>'r', 
		//Doplnené PV 26.07.2011
		'ř'=>'r', 'ľ'=>'l', 'ĺ'=>'l', 'ť'=>'t', 'ň'=>'n', 'ď'=>'d',
		'Ď'=>'D', 'Ľ'=>'L', 'Ĺ'=>'L', 'Ň'=>'N', 'Ř'=>'R', 'Ť'=>'T' 
);
return strtr($string, $table);
}

function str2num($str)
/*	Funkcia konvertuje string na desatinné číslo float
		stiahnuté z http://www.php.net/manual/en/language.types.float.php
		Vložené : 10.02.2012
*/
{
if(strpos($str, '.') < strpos($str,',')){
	$str = str_replace('.','',$str);
	$str = strtr($str,',','.');           
}
else{
	$str = str_replace(',','',$str);           
}
return (float)$str;
} 

function pre_r($data, $text="")
  /* Funkcia vypíše pole data cez print_r.
   Vstupy: 	- $text  -> čo sa má vypísať pred pole         
						- $data  -> pole         
	 Výstupy: - na obrazovku - <pre>print_r($data)</pre>
	 Obmedzenie: Zatiaľ neznáme.
	 Zmena: 30.12.2011 - PV
  */
{
?>
<br /><?= $text ?>:<br />
<pre>
	<?php print_r($data); ?>
</pre>
<?php
}
?>
