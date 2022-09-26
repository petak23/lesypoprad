<?php

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku hlavne_menu_template
 * 
 * Posledna zmena 03.10.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
class Hlavne_menu_template extends Table {
  /** @var string */
  protected $tableName = 'hlavne_menu_template';
    
  /** Hodnoty id=>name-description pre formulare
   * @return array */
  public function formPairs() {
    return $this->findAll()->fetchPairs('id', 'description');
//    $out = [];
//    foreach ($this->findAll() as $v) {
//      $out[$v->id] = $v->name.' - '.$v->description;
//    }
//    return $out;
  }
}