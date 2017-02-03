<?php
if ($bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód

function form_pole($nazov, $nadpis, $hodnota="", $help, $max_dlzka=20, $dlzka=0, $vyp_len=true, $type="text", $errorMsg="", $option=NULL)
/*
	Funkcia vypíše formulárový textový prvok input so zadanými parametrami. 
		Vstupy: 
			- $nazov     	-> Môže to byť text a je to názov prvku formulára
	    - $nadpis    	-> Môže to byť text text, čo sa vypíše pred prvkom
			- $hodnota   	-> Môže to byť text, ktorý sa vpíše do prvku
			- $help      	-> Môže to byť text, pomôcka pre vyplnenie prvku
			- $max_dlzka 	-> Môže to byť číslo určujúce max. dĺžku reťazca pre zápis do prvku
			- $dlzka     	-> Môže to byť číslo určujúce dĺžku prvku
			- $vyp_len   	-> True / false či sa má vypísať údaj o max dĺžke poľa
			- $type				-> Text určuje typ vypísaného prvku napr. text, checkbox, ...
			- $errorMsg  	-> Chybová hláška v prípade, že prvok neprejde validáciou
			- $option			-> nastavenie inputu a to checked, disabled, readonly
		Výstupy: výpis prvku
		Obmedzenie: Táto fununkcia je určená LEN pre input-y v <div id=admin>.
		Štruktúra:
		<label for="...">nadpis:</label>
		<input type="..." name="..." id="..." size="..." maxlength="..." value="..." [checked, disabled, readonly] />
		<span class="inputEroor">errorMsg</span>
		<div>$help (Maximálna dĺžka max_dlzka znakov!)</div>
    Zmena: 10.01.2012 - PV
  */
{
 if ((int)$max_dlzka==0) $max_dlzka=20; //Pre prípad chyby
 if ((int)$dlzka==0) $dlzka=(int)$max_dlzka; //Ak nie je dĺžka zadaná
 $pomocne="";
 if (isset($option["checked"]) && $option["checked"]==1) $pomocne.=" checked=\"checked\"";
 if (isset($option["disabled"]) && $option["disabled"]==1) $pomocne.=" disabled=\"disabled\"";
 if (isset($option["readonly"]) && $option["readonly"]==1) $pomocne.=" readonly=\"readonly\"";
 if (isset($option["onclick"])) $pomocne.=" onclick=\"".$option["onclick"]."\"";
 ?>
	<?php if ($type<>"hidden") { ?>
	<label for="<?= $nazov ?>"><?= $nadpis ?> :</label>
	<?php } ?>
	<input type="<?= $type ?>" name="<?= $nazov ?>" id="<?= $nazov ?>" size="<?= $dlzka ?>" maxlength="<?= $max_dlzka ?>" value="<?= $hodnota ?>" <?= $pomocne ?> />
	<?php if ($type<>"hidden") { ?>
	<span class="inputEroor"><?= $errorMsg ?></span>
	<div>
		<?= $help ?>
		<?php if ($vyp_len) { ?>
		(Maximálna dĺžka <?= $max_dlzka ?> znakov!)
		<?php } ?>
	</div>
	<?php } ?>
 <?php
}

function form_zaskrt($nazov, $nadpis, $hodnota=0, $nastav=false, $help="", $onclick="")
 /* Funkcia vypíše formulárový zaškrtávací prvok input so zadanými parametrami. 
     Vstupy: - $nazov     -> Môže to byť text a je to názov prvku formulára
	         - $nadpis    -> Môže to byť text text, čo sa vypíše za prvkom
			 - $hodnota   -> Môže to byť číslo nastavená hodnota
			 - $nastav		-> Či má byť pole zaškrtnuté
			 - $help      -> Môže to byť text, pomôcka pre vyplnenie prvku
			 - $onclick		-> Ak sa má spustiť javascript tak v tom je čo
	 Výstupy: výpis prvku
	 Obmedzenie: Táto fununkcia je určená LEN pre input-y v <div id=admin>.
    Zmena: 13.01.2011 - PV
  */
{
	$option=NULL;
	if ($nastav) $option["checked"]=1;
	if ($onclick<>"") $option["onclick"]=$onclick;
	form_pole($nazov, $nadpis, $hodnota, $help, 20, 0, false, "checkbox", "", $option);
}

function form_textarea($nazov, $nadpis, $hodnota, $help, $a_cols=50, $a_rows=5)
 /* Funkcia vypíše formulárový textový prvok textarea so zadanými parametrami. 
     Vstupy: - $nazov     -> Môže to byť text a je to názov prvku formulára
	         - $nadpis    -> Môže to byť text text, čo sa vypíše pred prvkom
			 - $hodnota   -> Môže to byť text, ktorý sa vpíše do prvku
			 - $help      -> Môže to byť text, pomôcka pre vyplnenie prvku
			 - $a_cols    -> Môže to byť číslo určujúce počet stĺpcov textového poľa
			 - $a_rows    -> Môže to byť číslo určujúce počet riadkov textového poľa
	 Výstupy: výpis prvku
	 Obmedzenie: Táto fununkcia je určená LEN pre input-y v <div id=admin>.
    Zmena: 26.10.2011 - PV
  */
{
 if ((int)$a_cols<40) $a_cols=50; //Pre prípad zlého zadania
 if ((int)$a_rows<3) $a_rows=5; //Pre prípad zlého zadania
 echo("<label for=\"$nazov\">$nadpis: </label><br />
       <textarea name=\"$nazov\" id=\"$nazov\" cols=\"$a_cols\" rows=\"$a_rows\">$hodnota</textarea>
       <div>$help</div>\n");
}

function form_registr($nazov, $hodnota=0, $max_reg=10, $filter=NULL)
 /* Funkcia vypíše formulárový zoznam pre výber úrovne registrácie.
     Vstupy: - $nazov   -> Môže to byť text a je to názov prvku formulára
			 - $hodnota -> Môže to byť číslo, ktoré sa prednastavý
			 - $max_reg -> Môže to byť číslo určujúce max. úroveň registrácie, ktorá sa vypíše.
			 - $filter  -> Text - pomocný filter pre určenie rozsahu
	 Výstupy: výpis prvku
	 Obmedzenie: Táto fununkcia je určená LEN pre input-y v <div id=admin>.
    Zmena: 10.01.2012 - PV
  */
{
if (isset($filter)) $odk="AND $filter"; else $odk=""; //Filter pre id_reg
$ur_reg=prikaz_sql("SELECT * FROM registracia WHERE id_reg<=$max_reg $odk ORDER BY id_reg", 
                   "Úroveň registracie (".__FILE__ ." on line ".__LINE__ .")", "Momentálne sa nepodarilo vypísať!");
					
if ($ur_reg) {  // Ak bola požiadavka v DB úspešná
	?>
	<label for="<?= $nazov ?>">Povolené prezeranie pre min. úroveň: </label>
  <select name="<?= $nazov ?>" id="<?= $nazov ?>">
  <?php while($uroven=mysql_fetch_array($ur_reg)) { ?>
		<option value="<?= $uroven['id_reg'] ?>" <?php if ($hodnota==$uroven['id_reg']) echo(" selected=\"selected\""); ?>>
			<?= $uroven['id_reg']." - ".$uroven['nazov'] ?>
		</option>
  <?php } ?>
  </select><br />
	<?php
}
else {
	?>
	<input type="hidden" name="<?= $nazov ?>" id="<?= $nazov ?>" value="<?php jeadmin(); ?>" />
	Povolené prezeranie pre min. úroveň: Nie je možné zmeniť z dôvodu chyby v databáze. Skúste prosím neskôr.<br />
  Prednastavená hodnota je <?= jeadmin(); ?><br />
	<?php
}
}

function form_ikonky($nazov, $hodnota=0, $filter=NULL)
/* Funkcia vypíše formulárový zoznam pre výber ikoniek.
     Vstupy: - $nazov   -> Môže to byť text a je to názov prvku formulára
			 - $hodnota -> Môže to byť číslo, ktoré sa prednastavý
			 - $filter  -> Text - pomocný filter pre určenie rozsahu
	 Výstupy: výpis prvku
	 Obmedzenie: Táto fununkcia je určená LEN pre input-y v <div id=admin>.
    Zmena: 25.01.2012 - PV
  */
{
if (isset($filter)) $odk="AND $filter"; else $odk=""; //Filter pre id_reg
$ur_ikonky=prikaz_sql("SELECT * FROM ikonka WHERE id_ikonka>-1 $odk ORDER BY id_ikonka", "Výpis ikoniek (".__FILE__ ." on line ".__LINE__ .")", "");
if ($ur_ikonky) { //Ak dotaz v DB bol v poriadku
	$i=1;
?>
<fieldset>
	<legend>Ikonka pred článkom:</legend>
	<div>(Označ aká ikonka sa objavý na začiatku článku)</div>
	<?php while($ikonky=mysql_fetch_array($ur_ikonky)) { ?>
    <input type="radio" name="id_ikonka" value="<?php echo($ikonky["id_ikonka"]);?>" <?php if ($hodnota==$ikonky["id_ikonka"]) echo("checked=\"checked\""); ?> />
		<img src="./ikonky/64/<?php echo($ikonky["nazov"]);?>64.png" alt="Ikonka <?php echo($ikonky["id_ikonka"]);?>" class="ikonkySmall" />
		<?php if ($i==9) {echo("<br />"); $i=1;} else $i++; 
	} ?>
</fieldset>
<br />
<?php }
else { //náhrada ak zlyhá DB ?>
Nie je možné zmeniť z dôvodu chyby v databáze. Skúste prosím neskôr.<input type="hidden" name="id_ikonka" value="0" />
<?php } 
}