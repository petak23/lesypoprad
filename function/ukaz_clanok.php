<?php
/* Slúži na priradenie správneho článku (súboru) k vstupným hodnotám.
    Využíva funkciu prikaz_sql
    Vstupy: - $zobr_clanok -> názov článku na zobrazenie
	        - $zobr_pol    -> názov podčlánku ak má článok viac verzií alebo číslo id - článku.
    Obmedzenie: zatiaľ mi nie je známe
    Zmena: 16.03.2012 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
if (@$zobr_co<>""){ //Bude sa vykonávať nejaká operácia a podľa toho sa vyberie článok
 $navrat_oper=prikaz_sql("SELECT subor FROM operacia WHERE nazov='$zobr_co' LIMIT 1",
                        "Položka operacia (".__FILE__ ." on line ".__LINE__ .")",
	 		            "Požadovaná operácia sa nenašla! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");					   
  if ($navrat_oper){ //Ak bol dopit v DB úspešný  
   if (mysql_numrows($navrat_oper)==1) { //V DB sa našla operácia
    $ad_oper=mysql_fetch_array($navrat_oper); //Načítaj z DB
    $nazovclanku="./$ad_oper[subor]";        //Do nazovclanku vlož nájdenú hodnotu 
   }
   else { chyba("Nenejdená položka operácia v zobr_co=$zobr_co (".__FILE__ ." on line ".__LINE__ .")",
	 		    "Požadovaná operácia sa nenašla! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");   
	return ;
   }			
 }
}
else {
 if($zobr_pol>0) {
 	if($zobr_cast>0) { //Bude to počlánok
	 if($zobr_pol<9000) {
 	  $navrat_cla=prikaz_sql("SELECT nazov FROM clanok WHERE id_clanok=$zobr_cast AND id_hlavne_menu=$zobr_pol AND id_reg<=".jeadmin()." LIMIT 1", 
                             "Položka článok (".__FILE__ ." on line ".__LINE__ .")",
				             "Požadovaný článok sa nenašiel! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");
	  if ($navrat_cla AND mysql_numrows($navrat_cla)==1) { //Ak bol dopit v DB úspešný a niečo sa našlo
	   $vys_clanok=mysql_fetch_array($navrat_cla); //Načítaj z DB
	   $nazovclanku="./clanky_info.php";
	   @$_REQUEST["id_clanok"]=$vys_clanok["id_clanok"];
	  }
      if ($zobr_clanok==7) { //je to fotogaléria
	   $nazovclanku="./fotogalery_info.php";
	  }
	 }
	 else {  //Výber zo sub_menu
 	  	 $navrat_sub=prikaz_sql("SELECT subor FROM sub_menu WHERE id_sub_menu=$zobr_pol AND id_hl_menu=$zobr_clanok AND id_reg<=".jeadmin()." LIMIT 1",
                         "Položka sub menu-súbor (".__FILE__ ." on line ".__LINE__ .")",
	 		             "Požadovaný článok sa nenašiel! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");					   
       if ($navrat_sub AND mysql_numrows($navrat_sub)==1){ //Ak bol dopit v DB úspešný - pre  zobr_pol a id_hl_menu sa našiel v DB jeden názov súboru 
        $ad_clanok=mysql_fetch_array($navrat_sub); //Načítaj z DB
        $nazovclanku="./$ad_clanok[subor]";        //Do nazovclanku vlož nájdenú hodnotu zo sub menu
       }
 	 }
 	}
 	else {
 	  if($zobr_pol<9000) { //Bude to článok
 	  	 $navrat_cla=prikaz_sql("SELECT nazov FROM clanok WHERE id_clanok=$zobr_pol AND id_hlavne_menu=$zobr_clanok AND id_reg<=".jeadmin()." LIMIT 1", 
                            "Položka článok (".__FILE__ ." on line ".__LINE__ .")",
				                "Požadovaný článok sa nenašiel! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");
	    if ($navrat_cla AND mysql_numrows($navrat_cla)==1) { //Ak bol dopit v DB úspešný a niečo sa našlo
	     $vys_clanok=mysql_fetch_array($navrat_cla); //Načítaj z DB
	     $nazovclanku="./clanky_info.php";
	     @$_REQUEST["id_clanok"]=$vys_clanok["id_clanok"];
	    }
		if ($zobr_clanok==7) { //je to fotogaléria
	     $nazovclanku="./fotogalery_info.php";
	    }
 	  }
 	  else {  //Výber zo sub_menu
 	  	 $navrat_sub=prikaz_sql("SELECT subor FROM sub_menu WHERE id_sub_menu=$zobr_pol AND id_hl_menu=$zobr_clanok AND id_reg<=".jeadmin()." LIMIT 1",
                         "Položka sub menu-súbor (".__FILE__ ." on line ".__LINE__ .")",
	 		             "Požadovaný článok sa nenašiel! Buď neexzistuje, došlo k chybe alebo nemáte dostatočné oprávnenie na prezeranie. Skúste, prosím, neskôr.");					   
       if ($navrat_sub AND mysql_numrows($navrat_sub)==1){ //Ak bol dopit v DB úspešný - pre  zobr_pol a id_hl_menu sa našiel v DB jeden názov súboru 
        $ad_clanok=mysql_fetch_array($navrat_sub); //Načítaj z DB
        $nazovclanku="./$ad_clanok[subor]";        //Do nazovclanku vlož nájdenú hodnotu zo sub menu
       }
 	  }
 	}	
 }
 else { //Ak je zobr_pol==0 t.j. nemám info o článku. Chýba alebo nemá byť
	if ($hlavicka_str["clanky"]==1) $nazovclanku="./clanky_info.php"; //Chýba priradený článok
 	else $nazovclanku="./".$hlavicka_str["clanok"]."_info.php"; //Článok nemá byť
 }	
}
if (@is_file($nazovclanku)){//Hľadá sa PHP súbor "$nazovclanku" 
    require($nazovclanku);
}
else{                      //Nenašiel sa vyhovujúci PHP súbor
   $not_file_found=@$nazovclanku;
   require("./function/notfound.php");
}
?>