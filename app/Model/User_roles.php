<?php
namespace DbTable;

/**
 * Model starajuci sa o tabulku user_roles
 * 
 * Posledna zmena 06.06.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
class User_roles extends Table {
  /** @var string */
  protected $tableName = 'user_roles';

  /** 
   * Hlada urovne registracie uzivatela v rozsahu od do
    * @param int $min
    * @param int $max
    * @return \Nette\Database\Table\Selection */
  public function hladaj_urovne($min, $max) {
    return $this->findBy(['id>='.$min, 'id<='.$max]);
  }

  /** 
   * Dava vsetky urovne registracie do poľa role=>id
    * @return array */
  public function vsetky_urovne_array() {
    return $this->findAll()->fetchPairs('role', 'id');
  }
  
  /** 
   * Hodnoty id=>name pre formulare
   * @param int $id_reg Uroven registracie
   * @return array */
  public function urovneReg($id_reg) {
    return $this->hladaj_urovne(0, $id_reg)->fetchPairs('id', 'name');
  }
}