<?php
namespace PeterVojtech\Clanky\ZobrazKartyPodclankov;
use Nette;
use DbTable;

/**
 * Komponenta pre zobrazenie odkazu na iny clanok
 * Posledna zmena(last change): 22.09.2022
 * 
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.7
 */
class AdminZobrazKartyPodclankovControl extends Nette\Application\UI\Control {

  /** @var DbTable\Hlavne_menu_lang */
//	public $hlavne_menu_lang;

  /** @var Nette\Database\Table\Selection */
  protected $articles;
  
  /** @var array */
  //private $paramsFromConfig;

  /**
   * Parametre z komponenty.neon
   * @param array $params
   * @return AdminAktualneOznamyControl */
  public function fromConfig(array $params) {
    //$this->paramsFromConfig = $params;
    return $this;
  }
  
  /** 
   * Render
   * @param array $p Parametre: template - pouzita sablona
   * @see Nette\Application\Control#render() */
  public function render($p = []) {
    $this->template->setFile(__DIR__ . "/AdminZobrazKartyPodclankov_default.latte");
    $this->template->render();
  }
}

interface IAdminZobrazKartyPodclankovControl {
  /** @return AdminZobrazKartyPodclankovControl */
  function create();
}