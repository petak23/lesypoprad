<?php
namespace App\FrontModule\Components\Clanky;

use Nette;
use DbTable;
use Language_support;

/**
 * Komponenta pre zobrazenie príloh clanku pre FRONT modul
 * 
 * Posledna zmena(last change): 18.02.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.3
 *
 */
class PrilohyClanokControl extends Nette\Application\UI\Control {

  /** @var DbTable\Dokumenty */
  private $prilohy;
  /** @var Language_support\LanguageMain */
	public $texts;
  /** @var int */
  private $id_article;
  /** @var string */
  private $avatar_path;

  /**
   * @param DbTable\Dokumenty $dokumenty
   * @param Language_support\LanguageMain $texts */
  public function __construct(DbTable\Dokumenty $dokumenty, Language_support\LanguageMain $texts) {
    parent::__construct();
    $this->prilohy = $dokumenty;
    $this->texts = $texts;
  }
	  
  /** Nastavenie id polozky, ku ktorej patria prilohy
   * @param int $id
   * @return \App\FrontModule\Components\Clanky\PrilohyClanokControl  */
  public function setNastav($id_article, $avatar_path, $id_lang) {
    $this->id_article = $id_article;
    $this->avatar_path = $avatar_path;
    $this->texts->setLanguage($id_lang);
    return $this;
  }
  
  /** Render funkcia pre vypisanie odkazu na clanok 
   * @see Nette\Application\Control#render()
   */
  public function render() { 
    $this->template->setFile(__DIR__ . "/PrilohyClanok.latte");
    $this->template->prilohy = $this->prilohy->getViditelnePrilohy($this->id_article);
    $this->template->texts = $this->texts;
    $this->template->avatar_path = $this->avatar_path;

    $servise = $this;
    $template->addFilter('odkazdo', function ($id) use($servise){
      $serv = $servise->presenter->link("Dokumenty:default", array("id"=>$id));
      return $serv;
    });
    
    $this->template->render();
	}
}

interface IPrilohyClanokControl {
  /** @return PrilohyClanokControl */
  function create();
}