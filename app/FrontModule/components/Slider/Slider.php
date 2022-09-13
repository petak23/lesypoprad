<?php
namespace App\FrontModule\Components\Slider;

use DbTable;
use Nette\Application\UI\Control;

/** 
 * Komponenta pre vykreslenie slider-u.
 *Posledna zmena(last change): 24.03.2022
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2013 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.2
 */
class SliderControl extends Control {  
	/** @var DbTable\Slider */
	private $slider;  
    
	/** @var array */
	private $nastavenie;

  /**
   * @param array $nastavenie Nastavenia slidera - Nastavenie priamo cez servises.neon
   * @param DbTable\Slider $slider */
  public function __construct(array $nastavenie, DbTable\Slider $slider) {
    $this->slider = $slider;
    $this->nastavenie = $nastavenie;
	}
  
  /** Render */
	public function render() {
    $this->template->setFile(__DIR__ . '/Slider_'.$this->nastavenie["varianta"].'.latte');
    $p_name = explode(":", $this->presenter->name);
    $id_pre_zobrazenie = ($p_name[1] == "Clanky") ? (isset($this->presenter->params['id']) ? $this->presenter->params['id'] : 0) : 0;
    
    if ($this->nastavenie["varianta"] == 5) { // Pre bwfoto... Verzia pre výber jednej fotky podľa položky v menu
      $menu = $this->presenter->getComponent('menu')->getPath();
      $path = [];
      // Konverzia path na pole bez 0-tej položky
      foreach ($menu as $p) {
        $path[] = $p->id;
      }
      unset($path[0]);
      $out = $this->_findIn($id_pre_zobrazenie, $path)->limit(1)->fetch();
      $this->template->slider = $out != null && isset($out->subor) ? "files/slider/".$out->subor : "images/cierny_bod.png";
    } elseif ($this->nastavenie["varianta"] == 4) {
      $this->template->slider = $this->slider->getSlider();
    } elseif ($this->nastavenie["varianta"] == 3) {
      $this->template->slider = $this->slider->getSlider();
    } elseif ($this->nastavenie["varianta"] > 0 && $this->nastavenie["varianta"] < 3) { //Varianty 1 - 2
      $this->template->slider = $this->_findIn($id_pre_zobrazenie)->fetchAll();
    } else { //Varianta 0
      $s = $this->slider->getSlider();
      $this->template->slider = $s->limit(1,  (int)rand(0, count($s)-1))->fetch();
    }
    
    $this->template->id_pre_zobrazenie = $id_pre_zobrazenie;
    $this->template->nastavenie = $this->nastavenie;
    $this->template->p_name = $p_name;
    $this->template->render();
	}
  
  /**
   * Najdenie poloziek slidera
   * @param int $id_pre_zobrazenie
   * @return \Nette\Database\Table\Selection */
  private function _findIn($id_pre_zobrazenie, $path = null) {
    $p_name = explode(":", $this->presenter->name);
    $slider = $this->slider->getSlider('poradie DESC');
    $slider_zobrazenie = $slider->fetchPairs("id", "zobrazenie");
    $vysa = [];
    // Nájdi priamo daný klúč
    $vysa[0] = array_search($id_pre_zobrazenie, $slider_zobrazenie);
    if ($vysa[0] == false) { // Ak nieje ...
      $vysa = [];
      foreach ($slider_zobrazenie as $k => $v) {
        $s_o[$k] = $_v = strpos($v, ",") !== FALSE ? explode(",", $v) : $v;
        $vysledok = FALSE;
        if (is_array($_v)) {
          foreach ($_v as $ke => $z) {
            $vysledok = $this->_zisti($z, $p_name[1], $path) == TRUE ? TRUE : $vysledok;
          }
        } else {
          $vysledok = $this->_zisti($_v, $p_name[1], $path);
        }
        if ($vysledok == TRUE) { $vysa[] = $k;}
      }
    }
    return $slider->where('id', $vysa[0]);
  }
  
  /**
    * Pre vyhodnotenie zobrazenia
		* @param mix     $z  zobrazenie polozky
		* @param string  $p  nazov presentera
		* @param array   $path  cesta pre zobrazenie
		* @return bool   */
  private function _zisti(?int $z, string $p, array $path): bool {
    return $z == NULL ? TRUE : 
                  ($z == 0 && $p == 'Homepage' ? TRUE : 
                    ($z > 0 && array_search($z, $path) != false ? TRUE : FALSE));  
	}
}

interface ISliderControl {
  /** @return SliderControl */
  function create();
}