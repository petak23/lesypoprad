<?php

namespace DbTable;
use Nette\Security\Passwords;

/**
 * Model, ktory sa stara o tabulku user_main
 * Posledna zmena 29.05.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */
class User_main extends Table {
  const
		COLUMN_ID = 'id',
    COLUMN_ID_USER_ROLES = 'id_user_roles',
    COLUMN_ID_USER_PROFILES = 'id_user_profiles',
    COLUMN_USERNAME = 'username',
    COLUMN_PASSWORD_HASH = 'password',
		COLUMN_MENO = 'meno',
    COLUMN_PRIEZVISKO = 'priezvisko',
		COLUMN_EMAIL = 'email',
    COLUMN_ACTIVATED = 'activated',
    COLUMN_BANNED = 'banned',
    COLUMN_BAN_REASON = 'ban_reason',
    COLUMN_LAST_IP = 'last_ip',
    COLUMN_CREATED = 'created';  
  
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
  
	/**
	 * Adds new user.
   * @param string $meno
   * @param string $priezvisko
   * @param string $username
   * @param string $email
   * @param string $password
   * @param int $activated
   * @param int $role
   * @return void
   * @throws DuplicateNameEmailException */
	public function add($meno, $priezvisko, $username, $email, $password, $activated = 0, $role = 0)	{
		try {
			$user_profiles = $this->connection->table('user_profiles')->insert([]); 
      $this->pridaj([
        self::COLUMN_MENO             => $meno,
        self::COLUMN_PRIEZVISKO       => $priezvisko,
				self::COLUMN_USERNAME         => $username,
				self::COLUMN_PASSWORD_HASH    => Passwords::hash($password),
				self::COLUMN_EMAIL            => $email,
        self::COLUMN_ID_USER_PROFILES => $user_profiles->id,
        self::COLUMN_ACTIVATED        => $activated,
        self::COLUMN_ID_USER_ROLES    => $role,
        self::COLUMN_CREATED          => StrFTime("%Y-%m-%d %H:%M:%S", Time()),
			]);
		} catch (Nette\Database\UniqueConstraintViolationException $e) {
      $message = explode("key", $e->getMessage());
      throw new DuplicateNameEmailException($message[1]);
		}
	}
  
  /**
   * @param Nette\Utils\ArrayHash $values
   * @return Nette\Database\Table\ActiveRow|FALSE
   * @throws Nette\Database\DriverException */
  public function saveUser($values) {
    try {
      $id = $values->id;
      if (!$values->banned) {
        $values->offsetSet("ban_reason", NULL);
      }
      unset($values->id);
      return $this->uloz($values, $id);
    } catch (Exception $e) {
      throw new Database\DriverException('Chyba ulozenia: '.$e->getMessage());
    }
  }
  
  /**
   * Funkcia pre formulár na zostavenie zoznamu všetkých užívateľov
   * @return array Pole uzivatelov vo formate: id => "meno priezvisko" */
  public function uzivateliaForm() {
    $u = $this->findAll();
    $out = [];
    foreach ($u as $v) {
    $out[$v->{self::COLUMN_ID}] = $v->{self::COLUMN_MENO}." ".$v->{self::COLUMN_PRIEZVISKO};
    }
    return $out;
  }
  
}

class DuplicateNameEmailException extends \Exception
{}