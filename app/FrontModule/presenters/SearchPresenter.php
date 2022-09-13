<?php

namespace App\FrontModule\Presenters;

use DbTable;
use Nette\Application\Responses;

/**
 * Prezenter pre vyhadavania.
 * 
 * Posledna zmena(last change): 28.02.2022
 *
 *	Modul: FRONT
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.5
 */
class SearchPresenter extends BasePresenter
{

  /** @var int Maximálny počet nálezov */
  private $max_finds = 15;
  /** @var int Počet zobrazených slov pred a za vyhľadaným */
  private $words = 2;

  // -- DB
  /* * @var DbTable\Products @inject */
  //public $produkty;

  /** Zakladna akcia */
  public function actionDefault(string $searchStr)
  {
    $searchOld = $searchStr;
    $searchStr = '%' . $searchStr . '%';

    // -- Hladanie v nadpisoch článkov --
    $search = $this->hlavne_menu_lang
      ->findBy(['hlavne_menu.hlavne_menu_cast.mapa_stranky' => 1])
      ->where('LOWER(menu_name) LIKE LOWER(?) OR LOWER(h1part2) LIKE LOWER(?) OR LOWER(hlavne_menu_lang.view_name) LIKE LOWER(?)', $searchStr, $searchStr, $searchStr)
      ->limit($this->max_finds);
    $out = [];
    foreach ($search as $s) {
      $out[] = [
        'id'          => $s->id,
        'type'        => 1,
        'name'        => $s->view_name,
        'description' => $this->texty_presentera->translate('search_heading'),
      ];
    }
    $this->max_finds -= count($search); // Na hľadanie už len koľko zostane

    // -- Hladanie v textoch článkov --
    $search = $this->hlavne_menu_lang
      ->findBy(['hlavne_menu.hlavne_menu_cast.mapa_stranky' => 1])
      ->where('LOWER(text) LIKE LOWER(?) OR LOWER(anotacia) LIKE LOWER(?)', $searchStr, $searchStr)
      ->limit($this->max_finds);
    foreach ($search as $s) {
      $tmp = explode(" ", $s->text);
      $my_key = [];
      foreach ($tmp as $key => $value) {
        if (mb_stripos($value, $searchOld) !== false) {
          $my_key[] = $key;
        }
      }
      if (count($my_key)) {
        $des = $this->texty_presentera->translate('search_in_text') . (isset($tmp[$my_key[0] - $this->words - 1]) ? " ..." : ""); // Počiatočný text a bodky
        for ($i = $this->words; $i > 0; $i--) {                         // Slová pred 
          $des .= (isset($tmp[$my_key[0] - $i]) ? " " . $tmp[$my_key[0] - $i] : "");
        }
        $des .= " <b>" . $tmp[$my_key[0]] . "</b>";                                   // Hladané slovo
        for ($i = 1; $i <= $this->words; $i++) {                        // Slová za 
          $des .= (isset($tmp[$my_key[0] + $i]) ? " " . $tmp[$my_key[0] + $i] : "");
        }
        $des .= isset($tmp[$my_key[0] + $this->words + 1]) ? " ..." : ""; // Koncové bodky
      } else $des = "";
      $out[] = [
        'id'          => $s->id,
        'type'        => 1,
        'name'        => $s->view_name,
        'description' => $des,
      ];
    }
    $this->max_finds -= count($search); // Na hľadanie už len koľko zostane

    // -- Hladanie v nadpisoch  dokumentov --
    $search = $this->dokumenty
      ->findBy(['hlavne_menu.hlavne_menu_cast.mapa_stranky' => 1])
      ->where('LOWER(name) LIKE LOWER(?)', $searchStr)
      ->limit($this->max_finds);
    foreach ($search as $s) {
      $out[] = [
        'id'          => $s->id_hlavne_menu,
        'type'        => 2,
        'name'        => $s->name,
        'description' => $this->texty_presentera->translate('search_in_headnig_doc'),
        'id_dokument' => $s->id,
      ];
    }
    $this->max_finds -= count($search); // Na hľadanie už len koľko zostane

    // -- Hladanie v popisoch dokumentov --
    $search = $this->dokumenty
      ->findBy(['hlavne_menu.hlavne_menu_cast.mapa_stranky' => 1])
      ->where('LOWER(description) LIKE LOWER(?)', $searchStr)
      ->limit($this->max_finds);
    foreach ($search as $s) {
      $tmp = explode(" ", $s->description);
      $my_key = [];
      foreach ($tmp as $key => $value) {
        if (mb_stripos($value, $searchOld) !== false) {
          $my_key[] = $key;
        }
      }
      if (count($my_key)) {
        $des = $this->texty_presentera->translate('search_in_text_doc') . (isset($tmp[$my_key[0] - $this->words - 1]) ? " ..." : ""); // Počiatočný text a bodky
        for ($i = $this->words; $i > 0; $i--) {                         // Slová pred 
          $des .= (isset($tmp[$my_key[0] - $i]) ? " " . $tmp[$my_key[0] - $i] : "");
        }
        $des .= " <b>" . $tmp[$my_key[0]] . "</b>";                                   // Hladané slovo
        for ($i = 1; $i <= $this->words; $i++) {                        // Slová za 
          $des .= (isset($tmp[$my_key[0] + $i]) ? " " . $tmp[$my_key[0] + $i] : "");
        }
        $des .= isset($tmp[$my_key[0] + $this->words + 1]) ? " ..." : ""; // Koncové bodky
      } else $des = "";
      $out[] = [
        'id'          => $s->id_hlavne_menu,
        'type'        => 2,
        'name'        => $s->name,
        'description' => $des,
        'id_dokument' => $s->id,
      ];
    }
    $this->max_finds -= count($search); // Na hľadanie už len koľko zostane             

    // -- Hladanie v nadpisoch produktov --
    /*$search = $this->produkty
                    ->findBy(['hlavne_menu.hlavne_menu_cast.mapa_stranky'=>1])
                    ->where('LOWER(name) LIKE LOWER(?)', $searchStr)
                    ->limit($this->max_finds);
    foreach ($search as $s) {
      $out[] = [
        'id'          => $s->id_hlavne_menu,
        'type'        => 2,
        'name'        => $s->name,
        'description' => $this->texty_presentera->translate('search_in_headnig_pro'),
        'id_dokument' => $s->id,
      ];
    } 
    $this->max_finds -= count($search); // Na hľadanie už len koľko zostane

    // -- Hladanie v popisoch produktov --
    $search = $this->produkty
                    ->findBy(['hlavne_menu.hlavne_menu_cast.mapa_stranky'=>1])
                    ->where('LOWER(description) LIKE LOWER(?)', $searchStr)
                    ->limit($this->max_finds);
    foreach ($search as $s) {
      $tmp = explode(" ", $s->description);
      $my_key = [];
      foreach ($tmp as $key => $value) {
        if (mb_stripos($value,$searchOld) !== false) {
          $my_key[] = $key;
        } 
      }
      if (count($my_key)) {
        $des = $this->texty_presentera->translate('search_in_text_pro').(isset($tmp[$my_key[0] - $this->words - 1]) ? " ..." : ""); // Počiatočný text a bodky
        for ($i = $this->words; $i > 0; $i--) {                         // Slová pred 
          $des .= (isset($tmp[$my_key[0] - $i]) ? " ".$tmp[$my_key[0] - $i] : "");
        }
        $des .= " <b>".$tmp[$my_key[0]]."</b>";                                   // Hladané slovo
        for ($i = 1; $i <= $this->words; $i++) {                        // Slová za 
          $des .= (isset($tmp[$my_key[0] + $i]) ? " ".$tmp[$my_key[0] + $i] : "");
        }
        $des .= isset($tmp[$my_key[0] + $this->words + 1]) ? " ..." : ""; // Koncové bodky
      } else $des = "";
      $out[] = [
        'id'          => $s->id_hlavne_menu,
        'type'        => 2,
        'name'        => $s->name,
        'description' => $des,
        'id_dokument' => $s->id,
      ];
    }*/

    $this->sendResponse(new Responses\JsonResponse($out));
  }
}
