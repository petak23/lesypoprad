<form action="<?= $dataDokument['odkaz'] ?>" method="post" enctype="multipart/form-data" >
	<div id="admin">
		<fieldset>
			<?php
			if ($zobr_cast>0) { //Pri oprave sa do fomulára pridá dokumentu 
				form_pole("id_polozka","",$dataDokument['id_polozka'],"", 0, 0, false, "hidden");
			}
			form_pole("id_clena","",$dataDokument['id_clena'],"", 0, 0, false, "hidden");
			form_pole("id_skupina","",$zobr_pol,"", 0, 0, false, "hidden"); //Časť do ktorej je zaradený dokument
			form_pole("cislo","Číslo ".$dataDok['castNazov'],$dataDokument['cislo'],"", 20);
			form_pole("subjekt",$dataDok['subjektN'],$dataDokument['subjekt'],"", 200, 50);
			if ($dataDok['castU']=="zmluvy") form_pole("nazov","Názov",$dataDokument['nazov'],"", 50);
			else form_pole("nazov","",$dataDokument['nazov'],"", 0, 0, false, "hidden");
			form_pole("predmet","Predmet",$dataDokument['predmet'],"", 200, 50);
			form_pole("cena",$dataDok['cenaN'],$dataDokument['cena'],"", 50);
			?>
			<label for="datum_vystavenia"><?= $dataDok['datumVN'] ?></label>
			<input type="text" id="datum_vystavenia" name="datum_vystavenia" class="datepicker" value="<?= $dataDokument['datum_vystavenia'] ?>" size="10" maxlength="10" />
			<div></div>
			<?php if ($dataDok['castU']=="zmluvy") { ?>
				<label for="datum_ukoncenia">Dátum ukončenia zmluvy</label>
				<input type="text" id="datum_ukoncenia" name="datum_ukoncenia" class="datepicker" value="<?= $dataDokument['datum_ukoncenia'] ?>" size="10" maxlength="10" />
				<div></div>
			<?php } 			
			//form_registr("id_reg", $id_reg, 5);   ALEBO
				form_pole("id_reg","",0,"", 0, 0, false, "hidden");
				if ($zobr_cast==0){ ?>
					<label for="pr_file1">Dokument: </label>
					<input name="pr_file" type="file" />
					<div>Max. veľkosť je: 2Mb.</div>
				<?php }?>
			<input name="dokumenty_rob" type="submit" value="<?= ($zobr_co=="add_dokumenty") ? "Pridaj" : "Oprav" ?>" />
		</fieldset>
	</div>
</form>