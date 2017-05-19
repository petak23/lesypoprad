<?php

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku user_main
 * Posledna zmena 18.05.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
class User_main extends Table {
  const
    COLUMN_USERNAME = 'username',
    COLUMN_EMAIL = 'email',
    COLUMN_LAST_IP = 'last_ip';  
  
  /** @var string */
  protected $tableName = 'user_main';

  /** 
   * Hladanie uzivatela podla username
   * @param string $username
   * @return \Nette\Database\Table\ActiveRow|FALSE */
  public function findByUsername($username) {
    return $this->findOneBy([self::COLUMN_USERNAME => $username]);
  }
  
  /** 
   * Test existencie username
   * @param string $username
   * @return boolean */
  public function testUsername($username) {
    return $this->findBy([self::COLUMN_USERNAME=>$username])->count() > 0 ? TRUE : FALSE;
  }
  /** 
   * Test existencie emailu
   * @param string $email
   * @return boolean */
  public function testEmail($email) {
    return $this->findBy([self::COLUMN_EMAIL=>$email])->count() > 0 ? TRUE : FALSE;
  }
  
  /**
   * Aktualizuje IP adresu posledneho prihlasenia
   * @param int $id
   * @param string $ip
   * @return boolean */
  public function logLastIp($id, $ip) {
    return $this->find($id)->update([self::COLUMN_LAST_IP => $ip]);
  }
  
  /**
   * Otestuje existenciu username alebo emailu
   * @param string $username
   * @return \Nette\Database\Table\ActiveRow|FALSE */
  public function testByUsernameOrEmail($username) {
    $row = $this->findOneBy([self::COLUMN_USERNAME => $username]);
    if (!$row) { //Ak sa nenajde username skus hladat email
      $row = $this->findOneBy([self::COLUMN_EMAIL => $username]);
    }
    return $row;
  }
  
}