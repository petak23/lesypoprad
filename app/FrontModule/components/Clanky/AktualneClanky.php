<?php
namespace App\FrontModule\Components\Clanky;
use DbTable;
use Language_support;
use Nette;
/**
 * Komponenta pre zobrazenie aktualnych projektov pre FRONT modul
 * 
 * Posledna zmena(last change): 13.04.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.8
 */
class AktualneClankyControl extends Nette\Application\UI\Control {
  /** @var DbTable\Hlavne_menu_lang $hlavne_menu_lang */
  private $hlavne_menu_lang;
  /** @var Nette\Security\User $user*/
  private $user;
  /** @var string $avatar_path Cesta k titulnemu obrazku clanku */
  private $avatar_path;
  /** @var Language_support\LanguageMain */
  private $texts;
  /** @var Nette\Database\Table\Selection $prilohy Prilohy k clanku */
  private $prilohy;
  /**
   * @param string $dir_to_menu Cesta k adresaru pre ukladanie obrazkov menu od www adresara - Nastavenie priamo cez servises.neon
   * @param DbTable\Hlavne_menu_lang $hlavne_menu_lang
   * @param DbTable\Dokumenty $dokumenty
   * @param Nette\Security\User $user
   * @param Language_support\LanguageMain $texts */
  public function __construct($dir_to_menu, DbTable\Hlavne_menu_lang $hlavne_menu_lang, DbTable\Dokumenty $dokumenty, Nette\Security\User $user, Language_support\LanguageMain $texts) {
    parent::__construct();
    $this->hlavne_menu_lang = $hlavne_menu_lang;
    $this->user = $user;
    $this->prilohy = $dokumenty->findAll();
    $this->texts = $texts;
    $this->avatar_path = $dir_to_menu;
  }
  
  /** 
   * Nastavenie jazyka 
   * @param int|string $language jazyk 
   * @return \App\FrontModule\Components\Clanky\AktualnyProjektControl */
  public function setLanguage($language) {
    $this->texts->setLanguage($language);
    return $this;
  }
  /** 
   * Render funkcia pre vypisanie odkazu na clanok 
   * @param array $p   
   * @see Nette\Application\Control#render() */
  public function render($p) { 
    $this->template->setFile(__DIR__ . '/AktualneClanky.latte');
    $this->template->aktuality = $this->hlavne_menu_lang->findBy([
                                  "hlavne_menu.datum_platnosti >= '".date("Y-m-d",strtotime("0 day"))."'",
                                  "hlavne_menu.id_user_roles <= ".($this->user->isLoggedIn()) ? ($this->user->getIdentity() === NULL ? 0 : $this->user->getIdentity()->id_user_roles) : 0,
                                  "hlavne_menu.id_nadradenej = ".$p["id"],
                                  ])->order('datum_platnosti DESC');
    $this->template->avatar_path = $this->avatar_path;
    $this->template->texts = $this->texts;
    $this->template->prilohy = $this->prilohy;
    $servise = $this;
    $this->template->addFilter('koncova_znacka', function ($text) use($servise){
      $rozloz = explode("{end}", $text);
      $vysledok = $text;
      if (count($rozloz)>1) {    //Ak som nasiel znacku
        $vysledok = $rozloz[0].\Nette\Utils\Html::el('a class="cely_clanok"')->href('#')->title($servise->texts->trText('base_view_all'))
                ->setHtml('&gt;&gt;&gt; '.$servise->texts->trText('base_viac')).'<div class="ostatok">'.$rozloz[1].'</div>';
      }
      return $vysledok;
    });
    $this->template->render();
  }
}

interface IAktualneClankyControl {
  /** @return AktualneClankyControl */
  function create();
}