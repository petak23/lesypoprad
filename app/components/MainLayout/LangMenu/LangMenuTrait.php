<?php

namespace PeterVojtech\MainLayout\LangMenu;

/**
 * Traita pre favicon-y
 * 
 * Posledna zmena(last change): 28.01.2022
 * 
 * 
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.0
 */
 trait LangMenuTrait {
  /** @var ILangMenuControl @inject */
  public $langMenuFactory;
  
  /** 
   * Vytvorenie komponenty 
   * @return LangMenuControl */
	public function createComponentLangMenu(): LangMenuControl {
    $lmf = $this->langMenuFactory->create();
    $lmf->setLanguage($this->language);
    return $lmf;
	}

  /** 
   * Signal prepinania jazykov
   * @param string $language skratka noveho jazyka */
  public function handleSetLang(string $language) {
    if ($this->language != $language) { //Cokolvek rob len ak sa meni
      //Najdi v DB pozadovany jazyk
      $la_tmp = $this->lang->findOneBy(['skratka'=>$language]);
      //Ak existuje tak akceptuj
      if (isset($la_tmp->skratka) && $la_tmp->skratka == $language) { $this->language = $language; }
    }
    $this->redirect('this');
	}
}