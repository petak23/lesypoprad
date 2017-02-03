<?php
/* Tento súbor slúži na odoslanie mailu správcovy obsahu webu
   Zmena: 13.09.2011 - PV
*/
if (@$bzpkod<>1934572) exit("Neoprávnený prístup!!!");  // Bezpečnostný kód
echo("<h4>Kontaktný formulár na správcu obsahu webu:</h4>");
if (@$_REQUEST["poslaniemailuT"]=="Odoslať"){
    $to = $_POST["frm_to"];
	$ho = $_POST["frm_ho"];
    $subject = $_POST["frm_subject"];
    $message = $_POST["frm_message"];
    $priority = 3;
    $contents = 2;
    $headers = "FROM: $ho\n";
    if ($contents==2) $headers .= "Content-Type: text/html; charset=utf-8\n";
    else $headers .= "Content-Type: text/plain; charset=utf-8\n";
    if (mail ($to, $subject, $message, $headers)) stav_dobre("Správa bola úspešne odoslaná!");
    else stav_zle("Správa NEBOLA odoslaná!");
}
?>
<form name="poslaniemailu" action="./index.php?co=mail" method=post>
 <div id=admin>
  <fieldset>
   <label for="frm_to">Komu: lesypoprad@lesypoprad.sk</label><input type="hidden" name="frm_to" value="lesypoprad@lesypoprad.sk"><br />
   <label for="frm_ho">Od koho(e-mail):</label><input type="text" name="frm_ho" id="frm_ho" size=42 maxlength=50 value="@"><br />
   <label for="frm_ho">Subjekt:</label><input type="text" name="frm_subject" id="frm_subject" size=50 maxlength=50 value=""><br />
   <label for="frm_ho">Text:</label><br /><textarea name="frm_message" cols=70 rows=8></textarea><br />
   <input type="submit" name="poslaniemailuT" value="Odoslať">
  </fieldset>
 </div> 
</form>