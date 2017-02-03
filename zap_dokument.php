<?php
include ("./function/func.php");          // Súbor rôznych funkcií
$GLOBALS["prip_db"]=pripoj_db();          // Pripojenie databazy  
//delete.php?id=IdOfPost 
if($_GET['id_dok']){ 
echo("SOM TU!!!"); 
$id = $_GET['id_dok']; 
$zmena_p=prikaz_sql("UPDATE dokumenty SET pocitadlo=pocitadlo+1 WHERE id_polozka=$id",
                    "Update počítadla (".__FILE__ ." on line ".__LINE__ .")","Nedalo sa pripočítať...");
 
  
// Presmeruje užívateľa 
//header("Location:index.php"); 
  
} 
 //Nasledujúca časť patrí do súboru, dokumenty_info.php  ?>
  <script>
   /*$(".dokum").click(function(){
    var odkaz = 'id_dok=' + $(this).attr("id"); //vytvorenie url na odosielanie
	$ajax({
	 type: "GET",
	 url: "zap_dokument.php",
	 data: odkaz,
	 succes: function(){
	  $(this).after("zobr");
     }
	});
	return false;
   });*/
  </script>
  <?php
?>