<?php
namespace App\FrontModule\Presenters;

use DbTable, Language_support;

/**
 * Prezenter pre spravu oznamov.
 * (c) Ing. Peter VOJTECH ml.
 * Posledna zmena(last change): 05.05.2017
 *
 *	Modul: FRONT
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.1
 *
 * Akcie: Default - zobrazenie vsetkych aktualnych oznamov a rozhodovanie 
 */
class OznamPresenter extends \App\FrontModule\Presenters\BasePresenter {
  /** 
   * @inject
   * @var DbTable\Oznam */
	public $oznam;
   /**
   * @inject
   * @var Language_support\Oznam */
  public $texty_presentera;

	/** @var \Nette\Database\Table\Selection */
	private $aktualne;
  
  /** Akcia pre nacitanie aktualnych oznamov */
	public function actionDefault() {
    //Z DB zisti ako budu oznamy usporiadane
    if (($pomocna = $this->udaje->getKluc("oznam_usporiadanie")) !== FALSE) {
      $oznamy_usporiadanie = (boolean)$pomocna->text;
    } else { $oznamy_usporiadanie = FALSE; }
    $this->aktualne = $this->oznam->aktualne($oznamy_usporiadanie);
    //Ak nie su oznamy najdi 1. clanok cez udaje a ak je tak presmeruj na neho
    if ($this->aktualne->count() == 0) {
      if (($id = $this->udaje->getUdajInt('oznam_presmerovanie')) > 0) {
        $this->flashRedirect(['Clanky:default', $id], $this->trLang('ziaden_aktualny'), 'info');
      } else {
        $this->setView("prazdne");
      }
    }
	}
  
  /** Render pre vypis aktualnych oznamov */
	public function renderDefault() {
    $this->template->plati_do = $this->trLang('plati_do');
    $this->template->zverejnene = $this->trLang('zverejnene');
    $this->template->zobrazeny = $this->trLang('zobrazeny');
    $this->template->h2 = $this->trLang('h2');
    $this->template->oznamy = $this->aktualne;
	}
  
  /** Render pre vypis infa o tom, ze nie su aktualne oznamy */
  public function renderPrazdne() {
    $this->template->h2 = $this->trLang('h2');
    $this->template->ziaden_aktualny = $this->trLang('ziaden_aktualny');
  }
}