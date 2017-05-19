<?php

namespace DbTable;

/**
 * Model starajuci sa o tabulku user_prihlasenie
 * Posledna zmena 19.05.2016
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */ 
class User_prihlasenie extends Table
{
  /** @var string */
  protected $tableName = 'user_prihlasenie';

  /**
   * Vrati poslednych x prihlaseni
   * @param int $pocet
   * @return \Nette\Database\Table\Selection */
  public function getLastPr($pocet = 25) {
		return $this->findAll()->order('prihlasenie_datum DESC')->limit($pocet);
	}
  
  /**
   * Zapise prihlasenie
   * @param int $id_user_main
   * @return \Nette\Database\Table\ActiveRow|FALSE */
  public function addLogIn($id_user_main) {
    return $this->pridaj(['id_user_main' => $id_user_main, 'prihlasenie_datum' => StrFTime("%Y-%m-%d %H:%M:%S", Time())]);
  }
  
  

}