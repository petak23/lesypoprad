<?php
include ("./function/func.php");          // Súbor rôznych funkcií
$GLOBALS["prip_db"]=pripoj_db();          // Pripojenie databazy   
if($_GET['id_dok']){ 
echo("SOM TU!!!"); 
$id = $_GET['id_dok']; 
$zmena_p=prikaz_sql("UPDATE dokumenty SET pocitadlo=pocitadlo+1 WHERE id_polozka=$id",
                    "Update počítadla (".__FILE__ ." on line ".__LINE__ .")","Nedalo sa pripočítať..."); 
} 