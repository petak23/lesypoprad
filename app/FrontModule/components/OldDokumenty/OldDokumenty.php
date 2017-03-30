<?php
namespace App\FrontModule\Components\OldDokumenty;
use Nette;
use DbTable;

/**
 * Komponenta pre zobrazenie aktualnych oznamov pre FRONT modul
 * Posledna zmena(last change): 30.03.2017
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.0
 *
 */
class OldDokumentyControl extends Nette\Application\UI\Control {
  /** @var DbTable\OldDokumenty */
  private $oldDokumenty;
  /** @var array Texty pre výpis */
  private $texty = [
      "h2"    =>"Aktuality",
      "viac"  =>"viac",
      "title" =>"Zobrazenie celého obsahu.",
                        ];
  private $nastavenie;

  /** @param DbTable\OldDokumenty $oldDokumenty  */
  public function __construct(DbTable\OldDokumenty $oldDokumenty) {
    parent::__construct();
    $this->oldDokumenty = $oldDokumenty;
    
  }

  /** @param array $nastavenie
   * @return \App\FrontModule\Components\Oznam\AktualneOznamyControl
   */
  public function setNastavenie($nastavenie) {
    $this->nastavenie = $nastavenie;
    return $this;
  }

  /** Nastavenie textov pre komponentu
   * @param array $t Texty pre komponentu
   * @return \App\FrontModule\Components\Oznam\AktualneOznamyControl
   */
  public function setTexty($t) {
    if (is_array($t) && count($t)) { $this->texty = array_merge ($this->texty, $t); }
    return $this;
  }
  
  public function render($params = []) {
    if (isset($params['templateFile']) && in_array($params['templateFile'], ['faktury', 'objednavky', 'zmluvy', 'zakazky-s-nizkou-hodnotou'])) {
      $this->template->setFile(__DIR__ . '/OldDokumenty_'.$params['templateFile'].'.latte');
    } else {
      $this->template->setFile(__DIR__ . '/OldDokumenty_error.latte');
    }
    $this->template->dokumenty = $this->dokumenty;
    $this->template->nastavenie = $this->nastavenie;
    $this->template->texty = $this->texty;
    $this->template->render();
  }
}

interface IOldDokumentyControl {
  /** @return OldDokumentyControl */
  function create();
}