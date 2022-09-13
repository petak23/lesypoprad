<?php
namespace App\AdminModule\Components\User;

use DbTable;
use Nette\Application\UI\Control;

/**
 * Komponenta pre vytvorenie kontaktneho formulara
 * 
 * Posledna zmena(last change): 25.10.2017
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.sk
 * @version 1.0.3
 */
class KontaktControl extends Control {
  /** @var DbTable\Clanok_komponenty */
  private $clanok_komponenty;
  
  /** Konstruktor komponenty
   * @param DbTable\Clanok_komponenty $clanok_komponenty */
	public function __construct(DbTable\Clanok_komponenty $clanok_komponenty) {
		parent::__construct();
		$this->clanok_komponenty = $clanok_komponenty;
	}
  
  /** @see Nette\Application\Control#render() */
  public function render() {
    $this->template->setFile(__DIR__ . '/Kontakt.latte');
    $this->template->render();
  }
  
  /** Signal pre odstranenie komponenty */
  public function handleDelete() {
    $this->clanok_komponenty->findOneBy(["spec_nazov"=>"kontakt"])->delete();
    $pthis = $this->presenter;
    $pthis->flashMessage("Kontaktný formulár bol odstránený!", 'success');
    if (!$pthis->isAjax()) {
      $this->presenter->redirect('this');
    } else {
      $this->invalidateControl();
    }
  }
}

interface IKontaktControl {
  /** @return KontaktControl */
  function create();
}