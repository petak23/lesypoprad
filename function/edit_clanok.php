<?php
/* Tento súbor slúži na obsluhu pridania/opravy/zmazania článku, podčlánku so 
   všetkým čo k tomu patrí. Samotná práca s DB je v samostatnom súbore function/p_o_clanok.php
   Zmena: 16.03.2012 - PV
   
   Moje funkcie:
    - form_zaskrt() ...  admin/admin_function.php
*/

// Hlavička stránky
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

//Inicializácia premených
 $datum=StrFTime("%Y-%m-%d %H:%M:%S", Time()); //Aktuálny dátum
 $datum_platnosti=StrFTime("%Y-%m-%d", Time()); //Do kedy je daný článok aktuálny
 $news=0;     		//Posielanie noviniek nastavené na nie
 if (@$_POST["nazov"]<>"") $nazov=strip_tags($_POST["nazov"]); else $nazov="";  		//Nazov článku
 $text="";   		//Text článku
 $typ=0;      		//Typ aktuálnosti "článku" podľa tab. clanok_typ
 $id_clanok=0;      //Id článku
 $id_hlavne_menu=0; //Id hlavného menu alebo nadradeného článku, ku ktorému je priradený článok(podčlánok)
 $podclanok=0;		//Nastavenie či je článok ako podčlánok a ak kde sa zobrazí na neho odkaz
 $id_reg=0;         //Úroveň registrácie
 $id_ikonka=1;      //Ikonka článku
 $mazanie=0;  		//mazanie po 90 dňoch
 if (@$_REQUEST["clanky_edit"]<>"" AND $vysledok<>"") $operacia=$_REQUEST["clanky_edit"]; else $operacia="Nič"; //Čo sa robilo na stránke
 $odkaz="./index.php?clanok=$zobr_clanok"; 
 if ((int)$zobr_pol>0) {
  $odkaz=$odkaz."&amp;id_clanok=$zobr_pol";
  if ($zobr_cast>0) $odkaz=$odkaz."&amp;cast=$zobr_cast";
 }
 $odkaz=$odkaz."&amp;co=$zobr_co";
 // ------------- Hlavička stránky ----------- 
echo("\n<h2>"); 
if ($zobr_co=="new_clanok") { 
 echo("Pridanie");
 $news=1; // Apriory sa novinky posielajú len pre nový článok.
 if ($zobr_pol>0) {
  $podclanok=3; 
  $id_hlavne_menu=$zobr_pol;
  echo("&nbsp;pod -");
 } 
 else $id_hlavne_menu=$zobr_clanok;
}
elseif ($zobr_co=="del_clanok") echo("Vymazanie");
elseif ($zobr_co=="edit_clanok") { 
 echo("Oprava");
 if ($zobr_cast>0) {
  $podclanok=3; 
  $id_hlavne_menu=$zobr_pol;
  echo("&nbsp;pod -");
 } 
 else $id_hlavne_menu=$zobr_clanok;
}
else echo("Spracovanie"); //Kôli chybe
echo("&nbsp;článku</h2>\n");
 // ------------- Koniec Hlavičky ------------------
 
if (@$zobr_co=="del_clanok" AND @$vysledok<>"ok") { /* Vymazanie článku */
 if ($zobr_cast>0) $hladaj=$zobr_cast; else $hladaj=$zobr_pol; 
 $vys_clanok=prikaz_sql("SELECT nazov FROM clanok WHERE id_clanok=$hladaj LIMIT 1",
                        "Nájdenie článku(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť tento článoka teda ani vymazať! Skúste neskôr.");
 if (@$vys_clanok) { //Ak bol nájdený článok/podčlánok na zmazanie
  $zaz_clanok=mysql_fetch_array($vys_clanok);
  if ($zobr_cast==0) { //Ak idem mazať článok nájdi aj podčlánky
   $vys_podclanok=prikaz_sql("SELECT * FROM clanok WHERE id_hlavne_menu=$zobr_pol AND podclanok>0",
                        "Nájdenie článku(".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo nájsť tento článok a teda ani vymazať! Skúste neskôr.");
   if (@$vys_podclanok) $zaz_podclanok=mysql_numrows($vys_podclanok); //Počet podčlánkov
   else $zaz_podclanok=0;
  } 
  echo("\n<div class=st_zle>Vymazanie článku !!!<br />");
  echo("Naozaj chceš vymazať");
  echo($zobr_cast>0 ? "pod" : ""); //Ak je podčlánok
  echo("článok: <u>$zaz_clanok[nazov]</u>!!!");
  if ($zobr_cast==0 && $zaz_podclanok>0) //Ak idem mazať článok
   echo("<br /> <b>Článok obsahuje aj $zaz_podclanok podčlánkov. Ak kliknente na ÁNO zmažú sa aj podčlánky. Zmazať aj tak?</b>");
  echo("\n<form action=\"$odkaz\" method=post>");
  echo("\n<input name=\"id_clanok\" type=\"hidden\" value=\"$hladaj\">");
  echo("\n<input name=\"id_hlavne_menu\" type=\"hidden\" value=\"$zobr_clanok\">");
  echo("\n<input name=\"clanky_edit\" type=\"submit\" value=\"Áno\">");
  echo("\n<input name=\"clanky_edit\" type=\"submit\" value=\"Nie\"></form></div>\n"); 
 }
}
  /* ----------- Časť spracovania formulára ---------- */
if (@$vysledok<>"") {     // Zapisovalo sa do databázy
  if ($vysledok=="ok") {   // Správny zápis článku do databázy
  $text="Článok bol ";  //Vypísanie info o operácii
  $clanok_datum=StrFTime("%d.%m.%Y %H:%M", Time());
  if ($operacia=="Pridaj") {
   $text .="pridaný! <br />";    
   $clan_n=prikaz_sql("SELECT id_clanok FROM clanok WHERE datum='$datum' LIMIT 1", "Najdenie id článku (".__FILE__ ." on line ".__LINE__ .")","");
   if ($clan_n AND mysql_numrows($clan_n)>0) { //Zistenie id článku, ktorý sa práve zapísal.
    $pclanky=mysql_fetch_array($clan_n);
	$id_clanok=$pclanky["id_clanok"];
   }
   $sprava_e="pribudol nov&yacute; čl&aacute;nok: \n D&aacute;tum pridania: $clanok_datum\n";
  } 
  elseif($operacia=="Oprav") {
   $text .="opravený!";
   $id_clanok=$_POST["id_clanok"]; //Zistenie id čláku, ktorý sa práve opravil
   $sprava_e="bol opraven&yacute; čl&aacute;nok: \n D&aacute;tum opravy: $clanok_datum\n";
  }
  elseif($operacia=="Áno") { //Keď sa maže  
   $text .="zmazaný!";
  }
  else $text .="zmenený!";
  stav_dobre("\n$text"); 
  if ($news==1 AND @(int)$_REQUEST["news"]>0) {   //Zaslanie mailu o aktualizacii podla adresara
    $navrat_n=prikaz_sql("SELECT meno, e_mail, news, id_reg FROM clenovia WHERE news=1",
	                     "Poslanie mailu (".__FILE__ ." on line ".__LINE__ .")","Žiaľ sa momentálne nepodarilo načítať clenov!");
    if ($navrat_n) { // Ak bola požiadavka v DB úspešná tak pošli mail všetkým čo to povolili
	  while ($clen_n = mysql_fetch_array($navrat_n)){ 
	   if ($clen_n["news"]>0 AND $_POST["id_reg"]<=$clen_n["id_reg"]){
	    echo("<br />$clen_n[meno] - mail: $clen_n[e_mail]");
	    $sprava ="<i>$hl_udaje[titulka]</i> \n<br /> --- !!! Na str&aacute;nke www.lesypp.sk boli uveden&eacute; novinky !!! ---\n<br />";
	    $sprava .="Na str&aacute;nke ".$sprava_e."<br />";
	   	$sprava .="N&aacute;zov: <b>$nazov</b> \n<br />";
	   	if ($id_clanok>0) {
		 $sprava .="\n Pre bližšie inform&aacute;cie kliknite \n<br />";
		 $sprava .="<a href=\"http://www.lesypp.sk/index.php?clanok=$zobr_clanok&id_clanok=$id_clanok\" title=\"Bližšie informácie\">sem</a> <br />\n";
		}
	   	$sprava .=$_SESSION["prezyvka"];
	   	$ako = posli_mail($clen_n["e_mail"], "Novinky na stránke www.rodinapp.sk", $sprava);
	   	echo("<br /><i>--- $ako ----</I>");
	   }
	  }
    }
  }
 }
 else {  // Načítanie údajov po chybnom zápise do databázy
  stav_zle("Záznam nebol pridaný. Niektorý údaj bol zadaný chybne alebo nebolo možné uskutočniť spojenie s databázou!<br />$vysledok");
  $datum=$_POST["datum"];  // Opätovné načítanie údajou ak došlo k chybe
  $datum_platnosti=$_POST["datum_platnosti"];
  $nazov=$_POST["nazov"];
  $text=$_POST["CKeditor01"];
  $typ=@$_POST["id_typ"];
  $id_reg=@$_POST["id_reg"];
  $id_ikonka=$_POST["id_ikonka"];
  $id_hlavne_menu=@$_POST["id_hlavne_menu"];
  $podclanok=@$_POST["podclanok"];
  $mazanie=@$_POST["mazanie"];
  $news=@$_POST["news"];
 }
}
if ($zobr_co=="del_clanok") $vysledok="ok"; //Aby sa nezobrazil formulár pri mazaní článku 
if (@$vysledok<>"ok") { //Ak je iný výsledok ako "ok" tak zobraz formulár
 if ($podclanok>0) { //Ak idem zadávať podčlánok načítajú sa hodnoty nadradeného článku
 	$navrat_nade=prikaz_sql("SELECT * FROM clanok WHERE id_clanok=$zobr_pol LIMIT 1",
                       "Načítanie pri oprave (".__FILE__ ." on line ".__LINE__ .")","Momentálne sa nepodarilo clanok nájsť! Skúste prosím neskôr.");
  if ($navrat_nade) $zaz_nad = mysql_fetch_array($navrat_nade);
 }
 echo("\n<form name=\"zadanie\" action=\"$odkaz\" method=post>\n"); //Začiatok formulára
 if ($zobr_co=="edit_clanok"){ //Načítanie údajov, keď sa ide opravovať clanok
  if ($zobr_cast>0) $hladaj=$zobr_cast; else $hladaj=$zobr_pol;
  $navrat_e=prikaz_sql("SELECT * FROM clanok WHERE id_clanok=$hladaj LIMIT 1",
                       "Načítanie pri oprave (".__FILE__ ." on line ".__LINE__ .")","Momentálne sa nepodarilo clanok nájsť! Skúste prosím neskôr.");
  if ($navrat_e) {
    $zaz_e = mysql_fetch_array($navrat_e);
    $datum=$zaz_e["datum"];
	 $datum_platnosti=$zaz_e["datum_platnosti"];
    $nazov=$zaz_e["nazov"];
    $text=$zaz_e["text"];
    $typ=$zaz_e["id_typ"];
	 $id_reg=$zaz_e["id_reg"];
	 $id_ikonka=$zaz_e["id_ikonka"];
    $id_hlavne_menu=$zaz_e["id_hlavne_menu"];
	 $podclanok=$zaz_e["podclanok"];
    $mazanie=$zaz_e["mazanie"];
    echo("<input type=\"hidden\" name=\"id_clanok\" value=\"$zaz_e[id_clanok]\">"); //Pri oprave sa do fomulára pridá id_článku
	echo("<input type=\"hidden\" name=\"datum\" value=\"$zaz_e[datum]\">"); //Pri oprave sa do fomulára pridá dátum zadania
  }
 }
 echo("<div class=admin><fieldset>");
 echo("\n<label for=\"nazov\">Nadpis:</label> <input type=\"text\" id=\"nazov\" name=\"nazov\" size=80 maxlength=80 value=\"$nazov\"><br />");
 // --- Sledovanie platnosti stránky a dátum platnosti ---
 if ($podclanok>0) { //Ak je to podclanok
  echo("\n&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"hidden\" name=\"id_typ\" value=$zaz_nad[id_typ]>");
  if($zaz_nad["id_typ"]>0) {
  	 echo("Sledovanie aktuálnosti článku s platnosťou do ".StrFTime("%d.%m.%Y", strtotime($datum_platnosti))."<br />\n");
  	 echo("\n<input type=\"hidden\" name=\"datum_platnosti\" value=\"$zaz_nad[datum_platnosti]\"/>");
  }	  
 }
 else { //Pre článok sledovanie aktuálnosti
  echo("\n&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"checkbox\" id=\"id_typ\" name=\"id_typ\" value=1");
  if (@$typ>0) { echo(" checked"); $viditelnost='block';} else $viditelnost='none';
  echo(" onClick=\"zobrazdat('dat_plat');\"><label for=\"id_typ\"> Sledovanie aktuálnosti článku</label><br />\n");
  echo("\n<span id=dat_plat style=\"display:$viditelnost\"><label for=\"datepicker\">Dátum platnosti[DD.MM.RRRR]:</label>");
  echo("<input type=\"text\" id=\"datepicker\" value=\"".StrFTime("%d.%m.%Y", strtotime($datum_platnosti))."\" size=10 maxlength=10>
       <input type=\"hidden\" id=\"alternate\" name=\"datum_platnosti\" size=\"10\" value=\"$datum_platnosti\"/>");
  echo("<div>(Dátum, do kedy je článok aktuálny)</div></span>");
 }
  // --- Priradenie k hl. menu a zobrazenie odkazu podčlánku---
 if ($podclanok>0) { //Ak je podčlánok priradí sa id nadradeného článku a zvolí spôsob zobrazenia odkazu
  echo("\n<input type=\"hidden\" name=\"id_hlavne_menu\" value=$id_hlavne_menu>"); 
  echo("<input type=\"hidden\" name=\"podclanok\" value=3>"); //Pre lesyPP nastavená hodnota - len záhlavie článku 
 }
 else { //Ak je to článok priradia sa základné hodnoty
  echo("\n<input type=\"hidden\" name=\"id_hlavne_menu\" value=$zobr_clanok>");
  echo("\n<input type=\"hidden\" name=\"podclanok\" value=0>");
 }
  echo("<input type=\"hidden\" name=\"id_reg\" value=0>"); //náhrada ak zlyhá DB

 if($podclanok==0) { // Platí pre článok
 // --- Hlavný článok --- 
   $pom_txt="Článok je hlavným článkom pre danú časť";
   if ($zobr_pol==$hlavicka_str["clanok"]) {
    $hlavny_clanok=1;
   }
   else {
    if ($hlavicka_str["clanok"]<>NULL) { //Ak je zadaný nejaký článok tak ho najdi
     $hla_cla=prikaz_sql("SELECT nazov FROM clanok WHERE id_clanok=".$hlavicka_str["clanok"]." LIMIT 1", "Hlavný článok (".__FILE__ ." on line ".__LINE__ .")", "ch");
	 if ($hla_cla) {
      $hlav_cla=mysql_fetch_array($hla_cla);
      $pom_txt=$pom_txt." - teraz: $hlav_cla[nazov]";
	 }
    }
    else $pom_txt=$pom_txt." - Nie je priradený žiaden hl. článok";
	$hlavny_clanok=0;
   }
   form_zaskrt("hlavny_clanok", $pom_txt, $hlavny_clanok);
   echo("<input type=\"hidden\" name=\"id_hlavne_menu\" value=$zobr_clanok>"); //Pre opravu hlavného článku
   echo("<input type=\"hidden\" name=\"id_ikonka\" value=0>");
 }
 // ------ Textový editor ------- 
 echo("Text:<br />"); //Textový editor
 if (jeadmin()>4) $toolbar="AdminToolbar"; 
 elseif (jeadmin()>2) $toolbar="UserToolbarSmall";
 else $toolbar="UserToolbar";
 $bkod='4RanoS5689q6-498';
 echo("<textarea id=CKeditor01 name=CKeditor01>$text</textarea>");
 echo("\n<script type=\"text/javascript\">\n
         CKEDITOR.replace( 'CKeditor01', 
		  { 
		    customConfig : '../../js/config_ckeditor.js',
			toolbar : '$toolbar',
			filebrowserBrowseUrl: '../www/editors/filemanager/index.php?bezp_kod=$bkod'
		  } );
	   \n</script>\n");
 echo("\nPodpis:&nbsp;".$_SESSION["prezyvka"]."<input type=\"hidden\" name=\"id_clena\" value=\"".(int)$_SESSION["id"]."\">");
 echo("&nbsp;&nbsp;-&gt;&nbsp;&nbsp;<input name=\"clanky_edit\" type=\"submit\" value=\"");
 echo($zobr_co=="new_clanok" ? "Pridaj" : "Oprav");
 echo("\"></fieldset></form></div>");
}
?>
