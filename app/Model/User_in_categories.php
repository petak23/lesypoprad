<?php

namespace DbTable;
use Nette;

/**
 * Model, ktory sa stara o tabulku user_in_categories
 * 
 * Posledna zmena 27.01.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
class User_in_categories extends Table {
  /** @var string */
  protected $tableName = 'user_in_categories';

  /** Ulozenie kategorie
   * @param Nette\Utils\ArrayHash $values
   * @return Nette\Database\Table\ActiveRow|null */
  public function saveCategori(Nette\Utils\ArrayHash $values) {
    $id = isset($values->id) ? $values->id : 0;
    unset($values->id);
    return $this->uloz($values, $id);
  }
  
  /** Uloženie viacerích kategórií
   * @param int $id_user_main
   * @param array $categori pole = ['id'=>'id_user_in_categories'] */
  public function saveMultiCategori(int $id_user_main, array $categori) {
    $this->findBy(['id_user_main'=> $id_user_main])->delete();
    if (count($categori)) { //Ukladaj len ak je čo...
      $out = [];
      foreach ($categori as $key => $value) {
        $out[] = ['id_user_main'=> $id_user_main, 'id_user_categories' => $value];
      }
      $this->pridaj($out);
    }
  }
  
  /**
   * Pre formular pre pridanie dietata
   * @return array */
  public function parentForForm(): array {
    $p = $this->findBy(['user_categories.main_category'=>'B'])->order('user_main.priezvisko ASC, user_main.meno ASC');
    $out = [];
    foreach ($p as $r) {
      $out[$r->id_user_main] = $r->user_main->meno." ".$r->user_main->priezvisko;
    }
    return $out;
  }
}