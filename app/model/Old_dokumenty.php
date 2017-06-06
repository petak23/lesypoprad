<?php

namespace DbTable;
use Nette;

/**
 * Model, ktory sa stara o tabulku old_dokumenty
 * 
 * Posledna zmena(last change): 06.06.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.4
 */
class OldDokumenty extends Table {
  /** @var string */
  protected $tableName = 'old_dokumenty';

  /** Vracia vsetky prilohy polozky
   * @param int $id Id_hlavne_menu prislusnej polozky
   * @return Nette\Database\Table\Selection|FALSE */
  public function getPrilohy($id) {  
    return $this->findBy(["id_hlavne_menu", $id])->order("pripona ASC");
  }
  
  /** Vracia vsetky viditelne prilohy polozky
   * @param int $id Id_hlavne_menu prislusnej polozky
   * @return Nette\Database\Table\Selection|FALSE */
  public function getViditelnePrilohy($id) {
    return $this->findBy(["id_hlavne_menu"=>$id, "zobraz_v_texte"=>1])->order("pripona ASC");
  }
  
  /** Test existencie nazvu
   * @param string $nazov
   * @param int $id_user_profiles
   * @return boolean */
  public function testNazov($nazov, $id_user_profiles) {
    return $this->findBy(['nazov'=>$nazov, 'id_user_profiles'=>$id_user_profiles])->count() > 0 ? TRUE : FALSE;
  }
}
