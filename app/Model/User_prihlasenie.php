<?php
declare(strict_types=1);

namespace DbTable;

use Nette\Database;
use Nette\Utils;

/**
 * Model, ktory sa stara o tabulku user_prihlasenie
 * 
 * Posledna zmena 13.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.3
 */ 
class User_prihlasenie extends Table {
  const
    COLUMN_ID              = 'id',
    COLUMN_ID_USER_MAIN    = 'id_user_main',
    COLUMN_LOG_IN_DATETIME = 'log_in_datetime';
    
  
  /** @var string */
  protected $tableName = 'user_prihlasenie';

  /** Vrati poslednych x prihlaseni
   * @param int $count Počet záznamov, ktoré sa vrátia
   * @param bool $as_array Či sa má vrátiť ako array
   * @return Database\Table\Selection|array */
  public function getLastLogin(int $count = 25, bool $as_array = false): mixed {
    $out = $this->findAll()->order(self::COLUMN_LOG_IN_DATETIME.' DESC')->limit($count);

    if ($as_array) {  // Ak má vrátiť ako pole
      $p = [];
      foreach ($out as $v) {
        $p[] = [
          'id_user_main' => $v->{self::COLUMN_ID_USER_MAIN},
          'name' => $v->user_main->meno . " " . Utils\Strings::upper($v->user_main->priezvisko),
          'log_in_datetime' => Utils\DateTime::from($v->{self::COLUMN_LOG_IN_DATETIME})->format("d.m.Y H:i")
        ];
      }
      $out = $p;
    }
    
		return $out;
	}
  
  /** 
   * Zapise prihlasenie
   * @param int $id_user_main
   * @return Database\Table\ActiveRow|null */
  public function addLogIn(int $id_user_main): ?Database\Table\ActiveRow {
    return $this->pridaj([self::COLUMN_ID_USER_MAIN => $id_user_main, 
                          self::COLUMN_LOG_IN_DATETIME => date("Y-m-d H:i:s", Time())
                         ]);
  }
  
  /** 
   * Vymaze vstetky data z DB 
   * @return int Vráti počet záznamov v DB tabuľke po vymazaní. Ak 0 tak OK */
  public function delAll(): int {
    $this->getTable()->delete();
    return $this->findAll()->count();
  }
}