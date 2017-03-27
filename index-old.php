<?php
/* Hlavný súbor stránky
   (c) Ing. Peter VOJTECH ml. - VZ
   Zmena: 08.02.2017
*/
session_start();
ob_start();

/* ------ Inicializácia premených ------ */
$zobr_clanok=1;					          // Id zobrazovanej položky hlavného menu. Prednastavená hodnota 1 (Úvod)
$zobr_pol=0; 							  // Id bližšie špecifikovaného článku  
$zobr_cast=0; 							  // Id bližšie špecifikovaného podčlánku 
$zobr_co=""; 							  // Názov operácie, ktorá sa bude vykonávať
$omrvinky["clanok"]["url"]="";			  // Inicializácia premenných pre vypísanie omrviniek
$omrvinky["clanok"]["txt"]="";			  // Pozn.: toto by sa mohlo zmeniť aj na dvojrozmerné pole, kde 2.index by
$omrvinky["id_clanok"]["url"]="";		  // rozlišoval url a txt.
$omrvinky["id_clanok"]["txt"]="";
$omrvinky["cast"]["url"]="";
$omrvinky["cast"]["txt"]="";
$blok_stranka=0;						  // Základné rozdelenie strany na 2 stĺpce žavý a stred+pravý      |--|-------|
$chyba_pr=1;   					          // Chyby pri prihlásení
$bzpkod=1934572;						  // Bezpečnostný kód
$GLOBALS["bol_prihlaseny"]=0;             // Aby sa zobrazilo pole pre prihlasenie
$index_oznam=9;						      // Id hlavné menu pre oznam
$index_admin=20;						      // Id hlavné menu pre admin
$index_fotog=7;						      // Id hlavné menu pre fotogalériu

/* ------ Vloženie potrebných súborou, pripojenie sa k DB a načítanie potrebného vzhľadu ------ */
include ("./function/func.php");          // Súbor rôznych funkcií
$GLOBALS["prip_db"]=pripoj_db();          // Pripojenie databazy
include ("./function/pri_odhl.php");      // Prihlásenie/Odhlásenie člena
if (jeadmin()>0) include ("./admin/admin_function.php");          // Súbor rôznych funkcií pre administráciu

/* ----- Načítanie základných hodnôt ------------ */
if (@$_REQUEST["co"]<>"") $zobr_co=$_REQUEST["co"]; //Ak je definovaná operácia tak v $zobr_co je uložený názov operácie
if (@(int)$_REQUEST["clanok"]<>0) $zobr_clanok=(int)$_REQUEST["clanok"];		//V $zobr_clanok je uložené id_hlavne_menu na zobrazenie
@$navrat=prikaz_sql("SELECT nazov, title, clanok, description, clanky FROM old_hlavne_menu WHERE id_hlavne_menu=$zobr_clanok AND id_reg<=".jeadmin()." LIMIT 1",
                    "Základná položka (".__FILE__ ." on line ".__LINE__ .")",""); //V DB hlavne menu najdi údaje
@$navrat1=prikaz_sql("UPDATE old_hlavne_menu SET pocitadlo=pocitadlo+1 WHERE id_hlavne_menu=$zobr_clanok AND id_reg<=".jeadmin()." LIMIT 1",
                     "Základné počítadlo (".__FILE__ ." on line ".__LINE__ .")",""); //Update počítadla
					 
if ($navrat && mysql_numrows($navrat)==1){           //Ak bol dopit v DB úspešný a existuje výsledok. Nájdená položka hl. menu
  $hlavicka_str=mysql_fetch_array($navrat);              //Načítanie hodnôt z DB - hl. menu
  if (@(int)$_REQUEST["id_clanok"]>0) {      //Ak je definovaný článok
   $zobr_pol=(int)$_REQUEST["id_clanok"];	//V $zobr_pol je uložená identifikácia konkrétneho článku v danej časti
   if (@(int)$_REQUEST["cast"]>0) {          //Ak je definovaná "časť" článku. t.j. napr. podčlánok 
    $zobr_cast=(int)$_REQUEST["cast"];	    //V $zobr_cast je uložená identifikácia konkrétneho podčlánku alebo albumu
   }
  }
  if ($zobr_pol==0 AND $zobr_co=="") $zobr_pol=(int)$hlavicka_str["clanok"];  // Ak nie definovaný článok v odkaze tak priraď názov položky z DB 
}
else {  //Ak dopit nebol v DB úspešný vlož prednastavené hodnoty - nenašla sa v DB položka hl. menu
   chyba("Nenašla sa položka hlavného menu! clanok=$zobr_clanok",
         "Požadovaná položka menu sa nenašla! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");
}				

//Výber hlavných údajov o stránke
@$z_hodnoty=prikaz_sql("SELECT nazov, text FROM udaje", "Základné údaje (".__FILE__ ." on line ".__LINE__ .")",
	  				   "Požadovaná položka sa nenašla! Buď neexzistuje alebo došlo k chybe. Skúste, prosím, neskôr.");
if ($z_hodnoty AND mysql_numrows($z_hodnoty)>0){ //Ak bol dopit v DB úspešný a existuje výsledok
  $i=1;
  while ($hlavne_udaje=mysql_fetch_array($z_hodnoty)){
   $hl_udaje[$hlavne_udaje["nazov"]]=$hlavne_udaje["text"]; //Naplň pole hlavných údajov
   $i++;
  }
  mysql_free_result($z_hodnoty); //Uvolnenie pamäte
}
//Pre omrvinky úroveň 1. - položka hlavného menu
$omrvinky["clanok"]["url"]=$zobr_clanok;
$omrvinky["clanok"]["txt"]=$hlavicka_str["nazov"];

//Pri pridávaní článkov
if (isset($_REQUEST["clanky_edit"])) { //Čo sa robilo na stránke
	$operacia=$_REQUEST["clanky_edit"];
	include ("./function/p_o_clanok.php");          
}
if (isset($_REQUEST["oznamy"])) { //Čo sa robilo na stránke
	$operacia=$_REQUEST["oznamy"];
	include ("./function/p_o_oznam.php");
    echo("vysledok:$vysledok");	
}
if (isset($_REQUEST["dokumenty_rob"])) { //Čo sa robilo na stránke časť dokumenty
	include ("./bloky/dokumenty/p_o_dokumenty.php");
}
if ($zobr_clanok==$index_fotog) { //Pre fotogalériu
 include ("./fotogalery/p_o_menu_galery.php");
 include ("./fotogalery/p_o_podgalery.php");
 if ($zobr_cast>0) { //Pre doplnenie do omrviniek 
  @$f_hodnoty=prikaz_sql("SELECT nazov FROM menu_galeria WHERE id_polozka=$zobr_pol AND zobrazenie>0 LIMIT 1",
                         "Omrvinky fotogaléria (".__FILE__ ." on line ".__LINE__ .")","");
  if ($f_hodnoty && mysql_numrows($f_hodnoty)>0){ //Ak bol dopit v DB úspešný a existuje výsledok
   $f_udaje=mysql_fetch_array($f_hodnoty);
   $omrvinky["id_clanok"]["url"]=$zobr_pol;    //Naplnenie omrviniek
   $omrvinky["id_clanok"]["txt"]=$f_udaje["nazov"]; 
  }
  mysql_free_result($f_hodnoty); //Uvolnenie pamäte  
 }
}
if ($zobr_clanok==-1) { //Pre záporné hodnoty hl. menu
 @$f_hodnoty=prikaz_sql("SELECT nazov FROM clanok WHERE id_hlavne_menu=-1 AND id_clanok=$zobr_pol LIMIT 1",
                        "Záporný názov (".__FILE__ ." on line ".__LINE__ .")","");
 if ($f_hodnoty && mysql_numrows($f_hodnoty)==1){ //Ak bol dopit v DB úspešný a existuje výsledok
  $f_udaje=mysql_fetch_array($f_hodnoty);
  $pom_h1_text=$f_udaje["nazov"];
 }
 mysql_free_result($f_hodnoty); //Uvolnenie pamäte 
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="sk" lang="SK" dir="ltr">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="robots" content="index, follow" />
  <meta name="Content-Language" content="sk" />
  <meta name="Language" content="Slovak, sk, slovensko"/>
  <meta name="geo.region" content="SK-PV" />
  <meta name="description" content="<?= $hlavicka_str['description'] ?>" />
  <meta name="keywords" content="<?= $hl_udaje['keywords'] ?>" />
  <title><?= $hl_udaje['titulka']." - ".$hlavicka_str['title'] ?></title>
  <meta name="author" content="<?= $hl_udaje['autor'] ?>" />
  <link rel="stylesheet" type="text/css" media="screen" href="www/css/main-2017-02-08.css"/>
  <link rel="stylesheet" type="text/css" media="screen" href="www/css/docasne-2017-02-08.css" />
  <link rel="stylesheet" type="text/css" href="www/css/south-street/jquery-ui-1.8.12.custom.css" />
  <link rel="stylesheet" type="text/css" href="www/css/colorbox.css" media="screen" />
  
</head>

<body>
<!-- ——————————————————— celý dokument ——————————————————— -->
  <div id="dokument">
    <!-- ——————————————————— veľká hlavička ——————————————————— -->
    <div id="hlavicka">
      <!-- ——————————————————— sekundárna navigácia - o nás, kontakt ——————————————————— -->
      <div id="subnavigacia">
        <ul>		  
          <li><a href="./index.php?clanok=-1&amp;id_clanok=1" title="Informácie o mestských lesoch  [klávesová skratka i]" accesskey="i" tabindex="7">o nás</a></li>
          <li><a href="./index.php?clanok=-1&amp;id_clanok=2" title="Kontaktné informácie [klávesová skratka k]" accesskey="k" tabindex="8">kontakt</a></li>
          <?php if (jeadmin() == 5) { ?>
          <li><a href="./www/adminer/?server=wm13.wedos.net&username=a13862_mlpp&db=d13862_mlpp" title="Adminer" target="_blank">adminer</a></li>
          <?php } 
           if (jeadmin()>2) {
          ?>
          <li>
           <?php include("./bloky/prihlasenie.php");  // Prihlásenie registrovaného účastníka 
           ?>
          </li>
          <?php } ?>
        </ul>
      </div>
      <!-- sekundárna navigácia -->
      <h1><?php 
	   if ($zobr_clanok<0) echo($pom_h1_text); //Pre zápornú položku hl. menu
	   elseif ($zobr_clanok==1) echo($hl_udaje["titulka"]); //Hlavná titulka pre úvod
	   else echo($hlavicka_str["title"]);
	  ?></h1>
      
      <!-- ——————————————————— malá hlavička (navigácia, slider, fsc logo) ——————————————————— -->
      <div id="hlavickaM">
        <div id="logofsc">
          <img src="www/images/logoML.png" alt="Logo Mestských Lesov Poprad" title="Mestské lesy Poprad" width="101" height="110" />
        </div>
        <!-- ——————————————————— primárna navigácia (oranžové tlačidlá) ——————————————————— -->
        <div id="navigacia">
          <ul>
          <?php include("./bloky/vypis_menu.php");          // Súbor pre výpis menu  ?>
           <li style="padding: 4ex 1ex; background: #CCC;">
            <form id="hladat" action="./index.php?clanok=-2" method="post">
              <fieldset>
                <label for="vyhladavanie"> Vyhľadávanie:<br /></label>
                <input type="text" id="vyhladavanie" name="vyhladavanie"
                <?php 
                  if (@$_REQUEST["vyhladavanie"]<>"") { echo("value=\"".$_REQUEST["vyhladavanie"]."\""); //Doplnenie hľadaného textu 
                  } else  { echo("value=\"\""); }
                ?>
                />			 
                <input name="tl_vyhladaj" type="submit" class="najdi" value=" " />
              </fieldset>
            </form>
           </li>
          </ul>
          <img src="www/images/logo_fsc_web.png" alt="Logo FSC" title="Zodpovedné obhospodarovanie lesov" width="120" height="150" />
        </div>
        <!-- primárna navigácia -->
        <!-- ——————————————————— slider ——————————————————— -->
        <div id="slider"><?php include("./bloky/vypis_slider.php"); ?></div>
        <!--slider -->
      </div>
      <!-- malá hlavička -->
      <img id="vetvicka" src="www/images/vetva_02.jpg" width="105" height="127" alt="" />
    </div>
    <!-- veľá hlavička -->
    
    <!-- ——————————————————— obsah (úvodný text, oznamy) ——————————————————— -->  
    <div id="obsah">
	 <!-- *** ZAČIATOK omrvinky (id=odrobinky) *** -->
     <p id="odrobinky">
	  &nbsp;&raquo;&nbsp;<a href="./index.php?clanok=1" title="Úvod">Úvod</a>
	  <?php
      if ($omrvinky["clanok"]["url"]>1) { // 1 je pre Úvod
       echo("&nbsp;&raquo;&nbsp;<a href=\"./index.php?clanok=".$omrvinky["clanok"]["url"]."\" title=\"".$omrvinky["clanok"]["txt"]."\">".$omrvinky["clanok"]["txt"]."</a>");
	   if ($omrvinky["id_clanok"]["txt"]<>"") {
	    echo("&nbsp;&raquo;&nbsp;<a href=\"./index.php?clanok=".$omrvinky["clanok"]["url"]."&amp;id_clanok=".$omrvinky["id_clanok"]["url"]."\" 
	          title=\"".$omrvinky["id_clanok"]["txt"]."\">".$omrvinky["id_clanok"]["txt"]."</a>");
	    if ($omrvinky["cast"]["txt"]<>"") {
	     echo("&nbsp;&raquo;&nbsp;<a href=\"./index.php?clanok=".$omrvinky["clanok"]["url"]."&amp;id_clanok=".$omrvinky["id_clanok"]["url"]."&amp;cast=".$omrvinky["cast"]["url"]."\"
     	       title=\"".$omrvinky["cast"]["txt"]."\">".$omrvinky["cast"]["txt"]."</a>");
	    } 
	   }  
      }
	  ?>
	 </p>
	 <!-- *** KONIEC omrvinky *** -->
	 <div id="clanok">
      <?php require("./function/ukaz_clanok.php"); ?>
	 </div>
    </div>
    <div id="pata">
      <div id="mapa"><?php include("./bloky/vypis_mapa.php"); ?></div>
      <p>
        &copy; <?= $hl_udaje['titulka'] ?> - Posledná aktualizácia 08.02.2017-PV <br />
        <a href="./index.php?co=admin" title="Prihlásenie pre správcu">Prihlásenie pre správcu</a>
      </p>
    </div>
    <div id="pataObr"> </div>
  </div>
  <script type="text/javascript" src="www/editors/ckeditor/ckeditor.js"></script>
  <script type="text/javascript" src="www/js/jquery-1.5.2.min.js"></script>
  <script type="text/javascript" src="www/js/jquery-ui-1.8.12.custom.min.js"></script>
  <script type="text/javascript" src="www/js/jquery.ui.datepicker-sk.js"></script>
  <script type="text/javascript" src="www/js/jquerylazyload.js"></script>
  <script type="text/javascript" src="www/js/jqFancyTransitions.js"></script>
  <script type="text/javascript" src="www/js/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="www/js/pomocny.js"></script>
</body>
</html>
