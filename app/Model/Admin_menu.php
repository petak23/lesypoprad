<?php
declare(strict_types=1);

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku admin_menu
 * 
 * Posledna zmena(last change): 11.11.2021
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2021 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
class Admin_menu extends Table {

  /** @var string */
  protected $tableName = 'admin_menu';

  /**
   * Vráti menu ako pole s prvkami [ $id => [ link, name, avatar ], ...]
   * @param int $id_user_roles Id užívateľskej roly
   * @return array
   */
  public function getAdminMenu(int $id_user_roles = 0): array {
    $p = $this->findBy([
        'id_user_roles <= '. $id_user_roles,
        'view' => 1,
      ]
    );
    $o = [];
    foreach ($p as $v) {
      $o[$v->id] = [
        'id'    => $v->id,
        'link'  => $v->odkaz,
        'name'  => $v->nazov,
        'avatar'=> $v->avatar
      ];
    };  
    return $o;
  }
}