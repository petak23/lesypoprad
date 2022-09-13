<?php

namespace PeterVojtech\Clanky\ZobrazKartyPodclankov;

/**
 * Traita pre zobrazenie podclankov na kartach
 * 
 * Posledna zmena(last change): 16.12.2019
 * 
 * 
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2019 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.2
 */
 trait zobrazKartyPodclankovTrait {
  /** @var IFrontZobrazKartyPodclankovControl @inject */
  public $zobrazKartyPodclankovFControlFactory;
  
  /** @var IAdminZobrazKartyPodclankovControl @inject */
  public $zobrazKartyPodclankovAControlFactory;
  
  /** 
   * Vytvorenie komponenty 
   * @return FrontZobrazKartyPodclankovControl|AdminZobrazKartyPodclankovControl */
	public function createComponentZobrazKartyPodclankov() {
    if (explode(":", $this->name)[0] == "Front") {
      $out = $this->zobrazKartyPodclankovFControlFactory->create();
      $out->setArticle($this->zobraz_clanok->id_hlavne_menu, $this->language, $this->kotva);
    } else { 
      $out = $this->zobrazKartyPodclankovAControlFactory->create();
    }
    return $out->fromConfig($this->nastavenie['komponenty']['zobrazKartyPodclankov']); //Vrati komponentu aj s nastaveniami z komponenty.neon
	}
}