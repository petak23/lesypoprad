<?php
namespace App\FrontModule\Components\Clanky\ZobrazClanok;
use Language_support;
use Nette\Application\UI\Control;
use Nette\Database\Table\ActiveRow;
use Nette\Utils\Html;
use Texy;
/**
 * Komponenta pre zobrazenie konkretneho clanku pre FRONT modul
 * 
 * Posledna zmena(last change): 11.05.2020
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2020 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.1.6
 */
class ZobrazClanokControl extends Control {
  /** @var Language_support\LanguageMain */
  private $texts;
  /** @var ActiveRow; - data zobrazovaneho clanku */
  private $zobraz_clanok;
  /** @var int $clanok_hlavicka - ake udaje sa zobrazia v hlavicke clanku */
  private $clanok_hlavicka = 0;
  /** @var string $parentTemplate Nazov suboru template clanku na zobrazenie */
  private $parentTemplate = "ZobrazClanok_default.latte";
  /** @var string|FALSE */
  private $err = FALSE;
  /** @var string $avatar_path Cesta k titulnemu obrazku clanku */
  private $avatar_path;
  /** @var Texy\Texy */
	public $texy;
  
  /**
   * @param string $dir_to_menu Cesta k adresaru pre ukladanie obrazkov menu od www adresara - Nastavenie priamo cez servises.neon
   * @param Language_support\LanguageMain $texts
   * @param Texy\Texy $texy */
  public function __construct(string $dir_to_menu, 
                              Language_support\LanguageMain $texts,
                              Texy\Texy $texy) {
    $this->avatar_path = $dir_to_menu;
    $this->texts = $texts;
    $this->texy = $texy;
    
  }
  
  public function setArticle(ActiveRow $article): ZobrazClanokControl {
    $this->zobraz_clanok = $article;
    return $this;
  }
  
  /** 
   * Nastavenie jazyka */
  public function setLanguage(int|string $language): ZobrazClanokControl {
    $this->texts->setLanguage($language);
    return $this;
  }
  
  /** Rucne nastavenie defaultnej template pre zobrazenie clanku.
   * POZOR! Toto nastavenie prebije nastavenie v DB(ak je)
   * @param string $pt Nazov template */
  public function setClanokTemplate($pt) {
    if (isset($pt) && strlen($pt)) {
      if (is_file(__DIR__ . "/ZobrazClanok_".$pt.".latte")) {
        $this->parentTemplate = "ZobrazClanok_".$pt.".latte";
      } else {
        $this->err = sprintf($this->texts->trText('base_not_found'), $pt);
      }
    }
  }
  
  /** Nastavenie hlavicky clanku
   *  @param int $clanok_hlavicka ake udaje sa zobrazia v hlavicke clanku */
  public function setClanokHlavicka($clanok_hlavicka) {
    if (isset($clanok_hlavicka) && $clanok_hlavicka) { $this->clanok_hlavicka = $clanok_hlavicka; }
  }
  
  /** Otestovanie názvu a existencie suboru template a jeho nastavenie */
  private function _testTemplate() {
    $pt = $this->zobraz_clanok !== FALSE ? $this->zobraz_clanok->hlavne_menu->hlavne_menu_template->name : FALSE;
    if ($pt && strlen($pt)) { 
      if (is_file(__DIR__ ."/ZobrazClanok_".$pt.".latte")) {
        $this->parentTemplate = "ZobrazClanok_".$pt.".latte";
      } else {
        $this->err = sprintf($this->texts->trText('base_not_found'), $pt);
      }
    }
    $this->template->setFile(__DIR__ ."/".$this->parentTemplate);
  }
  
  /** Render */
  public function render($parameters = []) { 
    $pthis = $this->presenter;
    $this->_testTemplate();
    if ($this->err !== FALSE) { //Je nejaka chyba
      $this->template->setFile(__DIR__ . '/ZobrazClanok_error.latte');
      $this->template->text = $this->err;
    } else { //Vsetko je OK
      $this->template->clanok_hlavicka = isset($parameters["clanok_hlavicka"]) ? $parameters["clanok_hlavicka"] : $this->clanok_hlavicka;
      $this->template->clanok = $this->zobraz_clanok;
      $this->template->texts = $this->texts;
      $this->template->avatar_path = $this->avatar_path;
			$this->template->article_avatar_view_in = $pthis->nastavenie["article_avatar_view_in"];
      $this->template->nastav = $parameters;
      $this->template->menu = $pthis->getComponent('menu');
    }
    $servise = $this;
    $this->template->addFilter('obr_v_txt', function ($text) use($servise){
      $serv = $servise->presenter;
      $vysledok = '';
      $cesta = 'http://'.$serv->nazov_stranky."/";
      foreach (explode("#", $text) as $k=>$cast) {
        if (substr($cast, 0, 2) == "I-") {
          $obr = $serv->dokumenty->find((int)substr($cast, 2));
          if ($obr !== FALSE) {
            $img = Html::el('img')->src($cesta.$obr->thumb_file)->alt($obr->name)->class('jslghtbx-thmb noajax')
                    ->data('jslghtbx', $cesta.$obr->main_file)->data('ajax', 'false')->data('jslghtbx-group', "group_text");
            $cast = Html::el('div')->class('img-in-text')->setHtml($img."<br/>".$obr->name);
          }
        }
        $vysledok .= $cast;
      }
      return $vysledok;
    });
    $this->template->addFilter('sponzor', function ($text) use($servise){
      $rozloz = explode("#", $text);
      $serv = $servise->presenter;
      $vysledok = '';
      $cesta = 'http://'.$serv->nazov_stranky."/";
      foreach ($rozloz as $k=>$cast) {
        if (substr($cast, 0, 2) == "I-") {
          $obr = $serv->dokumenty->find((int)substr($cast, 2));
          if ($obr !== FALSE) {
            $cast = Html::el('img')->src($cesta.$obr->main_file)->alt($obr->name)->class('img-center img-responsive');
          }
        }
        $vysledok .= $cast;
      }
      return $vysledok;
    });
    $this->template->addFilter('koncova_znacka', function ($text) use($servise){
      $rozloz = explode("<p>{end}</p>", $text);
      $vysledok = $text;
      if (count($rozloz)>1) {    //Ak som nasiel znacku
        $vysledok = $rozloz[0];
        $vysledok .= Html::el('a class="cely_clanok"')->href("#")->title("Zobrazenie celého článku")->setHtml('&gt;&gt;&gt; '.$servise->texts->trText("viac"));
        $vysledok .= Html::el('span class="ostatok"')->setHtml($rozloz[1]);
      }
      return $vysledok;
    });
    $this->template->addFilter('kontaktuj', function ($text) use($servise){
      $rozloz = explode("{end}", $text);
      $vysledok = $text;
      if (count($rozloz)>1) {    //Ak som nasiel znacku
        $vysledok = $rozloz[0];
        $vysledok .= Html::el('a class="cely_clanok"')->href("#")->title("Zobrazenie celého článku")->setHtml('&gt;&gt;&gt; '.$servise->texts->trText("viac"));
        $vysledok .= Html::el('span class="ostatok"')->setHtml($rozloz[1]);
      }
      return $vysledok;
    });
        
    $this->texy->allowedTags = TRUE;
    $this->texy->headingModule->balancing = "FIXED";
    $this->template->addFilter('texy', [$this->texy, 'process']);
    $this->template->render();
  }
}
interface IZobrazClanokControl {
  /** @return ZobrazClanokControl */
  function create();
}
