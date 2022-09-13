<?php
namespace App\FrontModule\Components\Lang\LangMenu;

use App\FrontModule\Forms;
use DbTable;
use Language_support;
use Nette\Application\UI\Control;
use Nette\Security\User;
use Nette\Utils\Html;

/**
 * Plugin pre zobrazenie ponuky o jazykoch
 * Posledna zmena(last change): 02.12.2021
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2013 - 2021 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.0
 */
class LangMenuControl extends Control {
  /** @var Language_support\LanguageMain Texty pre dany jazyk */
  public $texty;
	
  /** @var array Lokalne nastavenia */
	private $nastavenie = [];

  /** @var DbTable\Lang */
  public $lang;

  /**
   * @param array $nastavenie Nastavenie priamo cez servises.neon
   * @param Language_support\LanguageMain $language
   * @param DbTable\Lang $lang
   * @param User $user */
  public function __construct(array $nastavenie, 
                              Language_support\LanguageMain $language, 
                              DbTable\Lang $lang,
                              ) {
    $this->lang = $lang;
    $this->texty = $language; 
    $this->nastavenie = $nastavenie;
  }
  
  /** Nastavenie aktualneho jazyka
   * @param string|int $language Skratka jazyka alebo jeho id */
  public function setLanguage($language) {
    // Nacitanie základných textov z neon suboru podla jazyka
    $this->texty->setLanguage($language);//->appendLanguageFile(__DIR__ . '/lang_'. $this->texty->jazyk.'.neon');
    return $this;
  }

  /** Vykreslenie komponenty */
  public function render() {
		
		$lang_temp = $this->lang->findBy(['prijaty'=>1]);
    $langs = null;
		if ($lang_temp !== null && count($lang_temp)>1) {
			foreach($lang_temp as $lm) {
				$langs[] = [
          'link'  => ['setLang!', $lm->skratka],
          'title' => $lm->nazov.", ".$lm->nazov_en,
          'class' => ($lm->skratka == $this->texty->jazyk) ? "lang actual" : "lang",
          'name'  => $lm->nazov,
          'image' => Html::el('img')->src($this->template->baseUrl.'/www/ikonky/flags/'.$lm->skratka.'.png')
                                    ->alt('Flag of '.$lm->skratka)
				];
			}
		}
    $this->template->langs = $langs;
    $this->template->setTranslator($this->texty);
		$this->template->setFile(__DIR__ . '/LangMenu.latte');
		$this->template->render();
	}		
}

interface ILangMenuControl {
  /** @return LangMenuControl */
  function create();
}