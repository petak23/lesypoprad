<?php

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku dlzka_novinky
 * 
 * Posledna zmena 06.06.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */
class Dlzka_novinky extends Table {
  /** @var string */
  protected $tableName = 'dlzka_novinky';
  
  /** Hodnoty id=>nazov pre formulare
   * @return array */
  public function dlzkaNovinkyForm() {
    return $this->findAll()->fetchPairs('id', 'nazov');
  }  
}
