<h2><?= $dataDok['nazov'] ?></h2>
<?php if (isset($dataDok['text'])) stav_dobre($dataDok['text'], true); //Úspešná stavová hláška ?>
<?php if (isset($dataDok['errorText'])) stav_zle($dataDok['errorText'], true); //Neúspešná stavová hláška ?>
<?php if (jeadmin()>2) { //Táto časť je len pre admina ?>
	<ul id="sub2">
		<li>
			<a href="index.php?clanok=<?= $zobr_clanok ?>&id_clanok=<?= $zobr_pol ?>&co=add_dokumenty" title="Pridanie dokumentu">Pridanie dokumentu</a>
		</li>
	</ul>
<?php } ?>
<!--<h3><?= $dataDok['nazov'] ?> podľa rokov:</h3>-->
<?php if (isset($dataDok["rok"])) {  //Ak je čo vypisovať ?>

	<div id="dokumentyRoky">

	<?php foreach($dataDok["rok"] as $rok ) { //Nasleduje výpis všetkých povolených rokov ?>
		<h4><a href="#"><?= $rok[1]['dskupina'] ?></a></h4>

		<div id="oznamy">

		<?php if (isset($rok)) { //Ak bola požiadavka do DB úspešná a ak je čo vypisovať ?>

			<table class="dokumenty">

				<tr>

					<th>Číslo</th>

					<th><?= $dataDok['subjektN'] ?></th>

					<?php if($dataDok['castU']=="zmluvy") {?>

						<th>Názov</th>

					<?php } ?>

					<th>Predmet</th>

					<th><?= $dataDok['cenaN'] ?></th>

					<th><?= $dataDok['datumVN'] ?></th>

					<?php if($dataDok['castU']=="zmluvy") {?>

						<th>Dátum ukončenia zmluvy</th>

					<?php } ?>

					<th>Detail</th>

					<?php if (jeadmin()>2) { ?>

						<th>&nbsp;</th>

					<?php } ?>

				</tr>

			<?php $pom=1;

				foreach ($rok as $dok) { //Nasleduje výpis všetkých povolených dokumentov ?>
				<tr class="r<?= fmod($pom,2) ?>">
					<td><?= $dok['cislo'] ?></td>

					<td><?= $dok['subjekt'] ?></td>

					<?php if($dataDok['castU']=="zmluvy") {?>

						<td><?= $dok['dnazov'] ?></td>

					<?php } ?>

					<td><?= $dok['predmet'] ?></td>

					<td><?= $dok['cena'] ?></td>

					<td><?= $dok['datumV'] ?></td>

					<?php if($dataDok['castU']=="zmluvy") {?>

						<td><?= ($dok['datumU']>0) ? $dok['datumU'] : ""?></td>

					<?php } ?>

					<td><a href="<?= "index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=".$dok['id_polozka'] ?>" id="<?= $dok['id_polozka'] ?>" title="Dokument <?= $dok['dnazov']?>">

						<?= ((strlen($dok['dnazov'])) ? $dok['dnazov']." - " : '').$dok['subor'] ?></a>

					</td>

					<?php if (jeadmin()>2) { ?>

					<td><a href="<?= "index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=".$dok['id_polozka'] ?>&co=edit_dokumenty" title="Editácia údajov dokumentu <?= $dok['dnazov']?>">Editácia</a>&nbsp;|&nbsp;

						<a href="<?= "index.php?clanok=$zobr_clanok&amp;id_clanok=$zobr_pol&amp;cast=".$dok['id_polozka'] ?>&co=del_dokumenty" title="Vymazanie dokumentu <?= $dok['dnazov']?>">Vymazanie</a>
						<?php if (jeadmin()>3) { ?>
							&nbsp;|&nbsp;
							<?php if (is_file("dokumenty/".$dok['subor'])) { ?>Ok
							<?php } else { ?> <b><u>CH</u></b> <?php } ?>
						<?php } ?>

					</td>

					<?php }?>

				</tr>

			<?php	$pom++;} ?>

			</table>

		<?php } else stav_dobre("Nie sú žiadne dokumenty na zverejnenie!");	?>

	</div> 

	<?php } ?>

</div>

<?php }

else stav_dobre("Nie sú žiadne dokumenty na zverejnenie!");

?>

<script>

	$(function() {

		$( "#dokumentyRoky" ).accordion({

			autoHeight: false,

			navigation: true,

			collapsible: true,

			active: false

		});

	});

</script>