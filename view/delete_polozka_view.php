<div class="st_zle"><?= $delPol['nadpis'] ?><br />
		<?= $delPol['text'] ?> <strong><?= $delPol['polozkaPopis'] ?></strong>!!!
		<form action="<?= $delPol['odkaz'] ?>" method="post">
		<?php 
			form_pole($delPol['idPolozkaNaz'], "", $delPol['idPolozka'], "", 0, 0, false, "hidden"); 
			form_pole("zobr_clanok", "", $delPol['zobr_clanok'], "", 0, 0, false, "hidden"); 
			form_pole('zobr_pol', "", $delPol['zobr_pol'], "", 0, 0, false, "hidden"); 
		?>
			<input name="<?= $delPol['nazov'] ?>" type="submit" value="Áno" />
			<input name="<?= $delPol['nazov'] ?>" type="submit" value="Nie" />
		</form>
</div>