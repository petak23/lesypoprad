<?php

namespace App\AdminModule\Components\Clanky;

use Nette;
use Nette\Utils\Html;
use DbTable;

/**
 * Komponenta pre zobrazenie konkretneho clanku
 * Posledna zmena(last change): 29.05.2017
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.1.0
 */
class ZobrazClanokControl extends Nette\Application\UI\Control {
  /** @var DbTable\Hlavne_menu_lang */
	public $hlavne_menu_lang;
  /** @var int */
  protected $id_hlavne_menu;
  /** @var boolean $zobraz_anotaciu Zobrazenie anotacie polozky*/
  private $zobraz_anotaciu;

  /** @param DbTable\Hlavne_menu_lang $hlavne_menu_lang */   
  public function __construct(DbTable\Hlavne_menu_lang $hlavne_menu_lang) {
    parent::__construct();
    $this->hlavne_menu_lang = $hlavne_menu_lang;
  }
  
  /** Nastavenie komponenty
   * @param int $id_hlavne_menu
   * @param boolean $zobraz_anotaciu */
  public function setZobraz($id_hlavne_menu, $zobraz_anotaciu = FALSE) {
    $this->id_hlavne_menu = $id_hlavne_menu;
    $this->zobraz_anotaciu = $zobraz_anotaciu;
    return $this;
  }
  
  /** Render */

  public function render() {
    $this->template->setFile(__DIR__ . "/ZobrazClanok.latte");
    $this->template->cl_texts = $this->hlavne_menu_lang->findBy(["id_hlavne_menu"=> $this->id_hlavne_menu]);
    $this->template->zobraz_anotaciu = $this->zobraz_anotaciu;




    $servise = $this;
    $this->template->addFilter('obr_v_txt', function ($text) use($servise){

      $rozloz = explode("#", $text);
      $serv = $servise->presenter;
      $vysledok = '';
      $cesta = 'http://'.$serv->nazov_stranky."/";
      foreach ($rozloz as $k=>$cast) {
        if (substr($cast, 0, 2) == "I-") {
          $obr = $serv->dokumenty->find((int)substr($cast, 2));
          if ($obr !== FALSE) {
            $cast = Html::el('img class="jslghtbx-thmb img-rounded noajax"')->src($cesta.$obr->thumb_file)
                    ->alt($obr->name)->addAttributes([ 'data-jslghtbx' => $cesta.$obr->main_file, 'data-ajax'=>'false', 'data-jslghtbx-group'=>"mygroup1"]);
          }
        }
        $vysledok .= $cast;
      }
      return $vysledok;
    });
    $this->template->addFilter('koncova_znacka', function ($text) use($servise){
      $rozloz = explode("{end}", $text);
      $vysledok = $text;
      if (count($rozloz)>1) {    //Ak som nasiel znacku
        $vysledok = $rozloz[0].Html::el('a class="cely_clanok"')->href($servise->link("this"))->title("Zobrazenie celého článku")
                ->setHtml('&gt;&gt;&gt; viac').'<div class="ostatok">'.$rozloz[1].'</div>';
      }
      return $vysledok;
    });
    

    $this->template->render();
  }
}

interface IZobrazClanokControl {
  /** @return ZobrazClanokControl */
  function create();
}
