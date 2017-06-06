<?php

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku user_prihlasenie
 * 
 * Posledna zmena 06.06.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */ 
class User_prihlasenie extends Table {
  const
    COLUMN_LOG_IN_DATETIME = 'log_in_datetime',
    COLUMN_ID_USER_MAIN = 'id_user_main';
  
  /** @var string */
  protected $tableName = 'user_prihlasenie';

  /** Vrati poslednych x prihlaseni
   * @param int $pocet
   * @return \Nette\Database\Table\Selection */
  public function getLastPr($pocet = 25) {
		return $this->findAll()->order(self::COLUMN_LOG_IN_DATETIME.' DESC')->limit($pocet);
	}
  
  /** Zapise prihlasenie
   * @param int $id_user_main
   * @return \Nette\Database\Table\ActiveRow|FALSE */
  public function addLogIn($id_user_main) {
    return $this->pridaj([self::COLUMN_ID_USER_MAIN => $id_user_main, 
                          self::COLUMN_LOG_IN_DATETIME => StrFTime("%Y-%m-%d %H:%M:%S", Time())
                         ]);
  }
  
  /** Vymaze vstetky data z DB */
  public function delAll() {
    $this->getTable()->delete();
  }
}