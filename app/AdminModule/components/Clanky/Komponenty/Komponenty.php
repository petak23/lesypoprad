<?php
declare(strict_types=1);

namespace App\AdminModule\Components\Clanky\Komponenty;

use DbTable;
use Nette;
use Nette\Application\UI;
use Nette\Database\Table\ActiveRow;
use Nette\Security\User;

/**
 * Komponenta pre spravu priloh clanku.
 * 
 * Posledna zmena(last change): 04.05.2022
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.1.2
 */

class KomponentyControl extends UI\Control {

  /** @var DbTable\Clanok_komponenty */
	public $clanok_komponenty;
  /** @var Nette\Database\Table\ActiveRow $clanok Info o clanku */
  private $clanok;
  /** @var array */
  private $nastavenie_k;
  /** @var Nette\Security\User */
  private $user;

  /**
   * @param array $nastavenie_k Nastavenie obrazkov pre prilohy - Nastavenie priamo cez servises.neon
   * @param DbTable\Clanok_komponenty $clanok_komponenty
   * @param User $user */
  public function __construct(array $nastavenie_k,
                              DbTable\Clanok_komponenty $clanok_komponenty,
                              User $user) {
    $this->clanok_komponenty = $clanok_komponenty;
    $this->user = $user;
    $this->nastavenie_k = $nastavenie_k;
  }
  
  /** 
   * Nastavenie komponenty */
  public function setTitle(ActiveRow $clanok): void {
    $this->clanok = $clanok;
  }

  public function getKomponentyCount(): int {
    return count($this->clanok_komponenty->getKomponenty($this->clanok->id_hlavne_menu, $this->nastavenie_k));
  }

  /** 
   * Univerzalny formular pre pridanie komponenty k clanku.
	 * @return UI\Form */
	protected function createComponentKomponentaAddForm(): UI\Form {
		$form = new UI\Form;
		$form->addSubmit('uloz', 'Ulož')->setHtmlAttribute('class', 'btn btn-success');
		$form->onSuccess[] = [$this, 'komponentaUloz'];
		return $form;
	}
  
  public function komponentaUloz(UI\Form $form): void {
    $komponenta_spec_nazov = $form->getHttpData($form::DATA_TEXT, 'spec_nazov');
    $komponenta = $this->nastavenie_k[$komponenta_spec_nazov];
    $out = [
        'id_hlavne_menu'  => $form->getHttpData($form::DATA_TEXT, 'id_hlavne_menu_clanku'),
        'spec_nazov'      => $komponenta_spec_nazov,
        'parametre'       => "",
    ];
    foreach ($komponenta['parametre'] as $k => $v) {
      $out["parametre"] .= $form->getHttpData($form::DATA_TEXT, $k).",";
    }
    $out["parametre"] = substr($out["parametre"], 0, strlen($out["parametre"])-1);
    $this->clanok_komponenty->pridaj($out);
    $this->presenter->flashRedirect("this", "Komponenta bola pridaná", "success");
  }

  /** 
   * Signal pre pridanie komponenty, ktora nema parametre
   * @param string $komponenta_spec_nazov Specificky nazov komponenty
   * @param int $id_hlavne_menu Id clanku */
  public function handleAddKomponenta(String $komponenta_spec_nazov, int $id_hlavne_menu = 0): void {
    $k = $this->nastavenie_k[$komponenta_spec_nazov];
    $this->clanok_komponenty->pridaj(["id_hlavne_menu"=>(int)$id_hlavne_menu, "spec_nazov"=>$komponenta_spec_nazov]);
    $this->flashRedirect(["Clanky:default", $id_hlavne_menu],'Komponenta "'.$k["nazov"].'" bola pridaná!', "success");
  }
  
  /** 
   * Render */
	public function render(): void {
    $this->template->setFile(__DIR__ . '/Komponenty.latte');
    $this->template->clanok = $this->clanok;
    //Zisti, ci su k clanku priradene komponenty
    $this->template->komponenty = $this->clanok_komponenty->getKomponenty($this->clanok->id_hlavne_menu, $this->nastavenie_k);
    //Kontrola jedinecnych komponent. Ak uz su priradene tak sa vypustia
    $this->template->zoznam_komponent = $this->clanok_komponenty->testJedinecnosti($this->nastavenie_k, $this->clanok->id_hlavne_menu);
		$this->template->render();
	}
}

interface IKomponentyControl {
  /** @return KomponentyControl */
  function create();
}