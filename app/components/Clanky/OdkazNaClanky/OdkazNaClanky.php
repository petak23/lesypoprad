<?php
namespace PeterVojtech\Clanky\OdkazNaClanky;
use Nette;
use DbTable;
use Language_support;

/**
 * Komponenta pre zobrazenie odkazu na iny clanok
 * Posledna zmena(last change): 28.02.2022
 * 
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.9
 */
class OdkazNaClankyControl extends Nette\Application\UI\Control {
  
  /** @var Language_support\LanguageMain */
	public $texts;
  
  /** @var DbTable\Hlavne_menu_lang */
	public $hlavne_menu_lang;
  /** @var DbTable\Lang */
	public $lang;
  
  /** @var array */
  private $paramsFromConfig;
  
  /**
   * @param string $language 
   * @param DbTable\Hlavne_menu_lang $hlavne_menu_lang
   * @param DbTable\Lang $lang
   * @param Language_support\LanguageMain $texts */   
  public function __construct(string $language, DbTable\Hlavne_menu_lang $hlavne_menu_lang, DbTable\Lang $lang, Language_support\LanguageMain $texts) {
    parent::__construct();
    $this->hlavne_menu_lang = $hlavne_menu_lang;
    $this->lang = $lang;
    $this->texts = $texts;
    $this->texts->setLanguage($language);
  }
  
  /**
   * Parametre z komponenty.neon
   * @param array $params
   * @return AdminAktualneOznamyControl */
  public function fromConfig(array $params) {
    $this->paramsFromConfig = $params;
    return $this;
  }

  /** 
   * Render funkcia pre vypisanie odkazu na clanok 
   * @param array $p Parametre: id_hlavne_menu - id odkazovaneho clanku, template - pouzita sablona
   * @see Nette\Application\Control#render() */
  public function render($p = []) {
    $article = $this->hlavne_menu_lang->findOneBy(["id_lang"=>$this->texts->getLanguage_id(), "id_hlavne_menu"=>$p["id_hlavne_menu"]]);
    $p_hlm = $article->hlavne_menu; //Pre skratenie zapisu
    $this->template->setFile(__DIR__ . "/OdkazNaClanky".(isset($p["template"]) && strlen($p["template"]) ? "_".$p["template"] : "_default").".latte");
    $this->template->article = $article;
    $this->template->nazov = $article->menu_name;
    $this->template->datum_platnosti = $p_hlm->datum_platnosti;
    $this->template->avatar = $p_hlm->avatar;
    $this->template->anotacia = $article->anotacia;
    $this->template->texty = $this->texts;
    $this->template->link_presenter = $p_hlm->druh->presenter == "Menu" ? "Clanky:" : $p_hlm->druh->presenter.":";
    $this->template->to_link = $p_hlm->druh;
    $this->template->id_hlavne_menu = $p_hlm->id;
    $this->template->absolutna = $p_hlm->absolutna;
    $this->template->render();
  }
}

interface IOdkazNaClankyControl {
  /** @return OdkazNaClankyControl */
  function create(string $language);
}