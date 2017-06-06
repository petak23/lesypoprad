<?php

namespace DbTable;
use Nette;

/**
 * Model, ktory sa stara o tabulku dokumenty
 * 
 * Posledna zmena 06.06.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2016 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.3
 */
class Dokumenty extends Table {
  /** @var string */
  protected $tableName = 'dokumenty';

  /** Vracia vsetky prilohy polozky
   * @param int $id - id_hlavne_menu prislusnej polozky
   * @return Nette\Database\Table\Selection|FALSE */
  public function getPrilohy($id) {  
    return $this->findBy(["id_hlavne_menu", $id])->order("pripona ASC");
  }
  
  /** Vracia vsetky viditelne prilohy polozky
   * @param int $id - id_hlavne_menu prislusnej polozky
   * @return Nette\Database\Table\Selection|FALSE */
  public function getViditelnePrilohy($id) {
    return $this->findBy(["id_hlavne_menu"=>$id, "zobraz_v_texte"=>1])->order("pripona ASC");
  }
}
