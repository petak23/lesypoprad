<?php

namespace DbTable;
use Nette;

/**
 * Model, ktory sa stara o tabulku user_categories
 * 
 * Posledna zmena 27.01.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
class User_categories extends Table {
  const
    /* int ID [A]Index */ 
    TABLE_COL_ID = 'id',
    /* string(60) NAME Nazov */
    TABLE_COL_NAME = 'name',
    /* string(6) SHORTCUT Skratka */      
    TABLE_COL_SHORTCUT = 'shortcut',
    /* enum('V','R','O','B') MAIN_CATEGORY Hlavny druh kategorie */
    TABLE_COL_MAIN_CATEGORY = 'main_category',
    /* string(6) MOVE_TO_SHORTCUT Pri posune sa premenuje na skratku. */
    TABLE_COL_MOVE_TO_SHORTCUT = 'move_to_shortcut',
    /* int PORADIE Poradie položiek */
    TABLE_COL_PORADIE = 'poradie',
    /* tinint CHILD_ENABLE Povolenie zadať dieťa pre danú kategóriu */
    TABLE_COL_CHILD_ENABLE = 'child_enable';
  
  /** @var string */
  protected $tableName = 'user_categories';

  /** Ulozenie kategorie
   * @param Nette\Utils\ArrayHash $values
   * @return Nette\Database\Table\ActiveRow|null */
  public function saveCategori(Nette\Utils\ArrayHash $values) {
    $id = isset($values->id) ? $values->id : 0;
    unset($values->id);
    return $this->uloz($values, $id);
  }
  
  /** Hodnoty id=>nazov pre formulare
   * @return array */
  public function opravnenieForm(): array {
    return $this->findAll()->fetchPairs(self::TABLE_COL_ID, self::TABLE_COL_NAME);
  }
}