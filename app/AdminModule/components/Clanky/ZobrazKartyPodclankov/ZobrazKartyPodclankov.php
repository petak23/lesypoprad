<?php
namespace App\AdminModule\Components\Clanky\ZobrazKartyPodclankov;
use Nette;

/**
 * Komponenta pre zobrazenie odkazu na iny clanok
 * Posledna zmena(last change): 18.02.2022
 * 
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.6
 */
class ZobrazKartyPodclankovControl extends Nette\Application\UI\Control {

  /** 
   * Render
   * @param array $p Parametre: template - pouzita sablona */
  public function render($p = []) {
    $this->template->setFile(__DIR__ . "/ZobrazKartyPodclankov_default.latte");
    $this->template->render();
  }
}

interface IZobrazKartyPodclankovControl {
  /** @return ZobrazKartyPodclankovControl */
  function create();
}