<?php
namespace PeterVojtech\Clanky\ZobrazKartyPodclankov;


use DbTable;
use Language_support;
use Nette;

/**
 * Komponenta pre zobrazenie podclankov na kartach
 * Posledna zmena(last change): 16.12.2019
 * 
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2019 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.8
 */
class FrontZobrazKartyPodclankovControl extends Nette\Application\UI\Control {

  /** @var Language_support\LanguageMain */
	public $texts;
  /** @var DbTable\Hlavne_menu_lang */
	public $hlavne_menu_lang;
    /** @var DbTable\Dokumenty */
	public $dokumenty;
  /** @var Nette\Database\Table\Selection */
  protected $articles;
  /** @var string */
  private $kotva = "";
  
  /** @var array */
  private $paramsFromConfig;

  /**
   * @param DbTable\Hlavne_menu_lang $hlavne_menu_lang
   * @param Language_support\LanguageMain $texts */
  public function __construct(DbTable\Hlavne_menu_lang $hlavne_menu_lang, DbTable\Dokumenty $dokumenty, Language_support\LanguageMain $texts) {
    parent::__construct();
    $this->hlavne_menu_lang = $hlavne_menu_lang;
    $this->dokumenty = $dokumenty;
    $this->texts = $texts;
  }
  
  /**
   * Parametre z komponenty.neon
   * @param array $params
   * @return FrontAktualneOznamyControl */
  public function fromConfig(array $params) {
    $this->paramsFromConfig = $params;
    return $this;
  }

  /** 
   * Nacitanie zobrazovanych podclankov
   * @param int $id nadradeneho clanku
   * @param string $language Skratka zobrazovaneho jazyka
   * @param string $kotva
   * @return FrontZobrazKartyPodclankovControl */
  public function setArticle(int $id, string $language = 'sk', $kotva = "") {
    $this->texts->setLanguage($language);
    $this->articles = $this->hlavne_menu_lang->subArticleToView($id_lang, $id);
    $this->kotva = $kotva;
    return $this;
  }

  /** 
   * Render
   * @param array $p Parametre: template - pouzita sablona
   * @see Nette\Application\Control#render() */
  public function render($p = []) {
    $this->template->setFile(__DIR__ . "/FrontZobrazKartyPodclankov".(isset($p["template"]) && strlen($p["template"]) ? "_".$p["template"] : "_default").".latte");
    $this->template->texts = $this->texts;
    $this->template->articles = $this->articles;
    $this->template->kotva = $this->kotva;
    $this->template->dokumenty = $this->dokumenty;
    $this->template->render();
  }
}

interface IFrontZobrazKartyPodclankovControl {
  /** @return FrontZobrazKartyPodclankovControl */
  function create();
}