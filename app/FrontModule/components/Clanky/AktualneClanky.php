<?php

namespace App\FrontModule\Components\Clanky;
use Nette;
use DbTable;

/**
 * Komponenta pre zobrazenie aktualnych projektov pre FRONT modul
 * Posledna zmena(last change): 19.05.2017
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.3
 *
 */
class AktualneClankyControl extends Nette\Application\UI\Control {

  /** @var Nette\Database\Table\Selection $aktualne_clanky Data zobrazovaneho clanku */
  private $aktualne_clanky;
  /** @var string $avatar_path  Cesta k titulnemu obrazku clanku */
  private $avatar_path = "";
  /** @var array $texts */
  private $texts = ['h2'=>'Aktuality', 'title'=> 'Titulok', 'viac' => 'viac'];
  /** @var Nette\Database\Table\Selection $prilohy Prilohy k clanku */
  private $prilohy;

  /**
   * @param DbTable\Hlavne_menu_lang $hlavne_menu_lang
   * @param DbTable\Dokumenty $dokumenty
   * @param Nette\Security\User $user
   */
  public function __construct(DbTable\Hlavne_menu_lang $hlavne_menu_lang, DbTable\Dokumenty $dokumenty, Nette\Security\User $user) {
    parent::__construct();
    $this->aktualne_clanky = $hlavne_menu_lang->findBy(["hlavne_menu.datum_platnosti >= '".StrFTime("%Y-%m-%d",strtotime("0 day"))."'",
                                                        "hlavne_menu.id_user_roles <= ".(($user->isLoggedIn()) ? $user->getIdentity()->id_user_roles : 0)])
                              ->order('datum_platnosti DESC');
    $this->prilohy = $dokumenty->findAll();   
  }
  
  /** Nastavenie textov
   * @param array $texts
   * @return \App\FrontModule\Components\Clanky\AktualneClankyControl
   */
  public function setTexts($texts) {
    $this->texts = array_merge($this->texts, $texts);
    return $this;
  }

  /** Nastavenie cesty k titulnemu obrazku clanku
   *  @param string $avatar_path Cesta
   */
  public function setAvatarPath($avatar_path) {
    if (isset($avatar_path) && $avatar_path) { $this->avatar_path = $avatar_path; }
    return $this;
  }
  
  /** Render funkcia pre vypisanie odkazu na clanok 
   * @param array $p      */
  public function render($p) { 
    $this->template->setFile(__DIR__ . '/AktualneClanky.latte');
    $this->template->aktuality = $this->aktualne_clanky->where("hlavne_menu.id_nadradenej", $p["id"]);
    $this->template->avatar_path = $this->avatar_path;
    $this->template->h2_aktualne = $this->texts['h2'];
    $this->template->prilohy = $this->prilohy;

    $servise = $this;
    $template->addFilter('koncova_znacka', function ($text) use($servise){
      $rozloz = explode("{end}", $text);
      $vysledok = $text;
			if (count($rozloz)>1) {		 //Ak som nasiel znacku
				$vysledok = $rozloz[0].\Nette\Utils\Html::el('a class="cely_clanok"')->href('#')->title($servise->texts['title'])
                ->setHtml('&gt;&gt;&gt; '.$servise->texts['viac']).'<div class="ostatok">'.$rozloz[1].'</div>';
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