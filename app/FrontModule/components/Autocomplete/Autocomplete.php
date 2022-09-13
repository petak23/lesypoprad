<?php

namespace App\FrontModule\Components\Autocomplete;

use Language_support;
use Nette;
use Nette\Utils\Json;

/**
 * Komponenta pre našepkávanie pri vyhladavani pre FRONT modul
 * 
 * Posledna zmena(last change): 03.05.2021
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2021 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.3
 */

class AutocompleteControl extends Nette\Application\UI\Control {
  
  /** @var Language_support\LanguageMain */
  private $texts;

  /**
   * @param Language_support\LanguageMain $texts */
	public function __construct(Language_support\LanguageMain $texts) {
    $this->texts = $texts;
	}
  
  /** 
   * Nastavenie jazyka 
   * @param string $language jazyk 
   * @return AutocompleteControl */
  public function setLanguage(string $language) {
    $this->texts->setLanguage($language);
    return $this;
  }

	public function render() {
    $this->template->setFile(__DIR__ . '/Autocomplete.latte');
    $this->template->links = Json::encode([
      1 => $this->presenter->link('Clanky:').'/',
      2 => $this->presenter->link('Clanky:').'/',
    ]);
    $this->template->texts = Json::encode([
      'placeholder' => $this->texts->translate('autocomplete_placeholder'),
      'searching'   => $this->texts->translate('autocomplete_searching'),
      'min_char'    => $this->texts->translate('autocomplete_min_char'),
      'not_found'   => $this->texts->translate('autocomplete_not_found'),
    ]);
		$this->template->render();
	}
}

interface IAutocompleteControl {
  /** @return AutocompleteControl */
  function create();
}
