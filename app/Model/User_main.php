<?php
//declare(strict_types=1);

namespace DbTable;

use Nette;

/**
 * Model, ktory sa stara o tabulku user_main
 * 
 * Posledna zmena 13.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.5
 */
class User_main extends Table {
  const
		COLUMN_ID = 'id',
    COLUMN_ID_USER_ROLES = 'id_user_roles',
    COLUMN_ID_USER_PROFILES = 'id_user_profiles',
    COLUMN_PASSWORD_HASH = 'password',
    COLUMN_TITUL_PRED = 'titul_pred',
		COLUMN_MENO = 'meno',
    COLUMN_PRIEZVISKO = 'priezvisko',
    COLUMN_TITUL_ZA = 'titul_za',
		COLUMN_EMAIL = 'email',
    COLUMN_ACTIVATED = 'activated',
    COLUMN_BANNED = 'banned',
    COLUMN_BAN_REASON = 'ban_reason',
    COLUMN_LAST_IP = 'last_ip',
    COLUMN_CREATED = 'created';  
  
  /** @var string */
  protected $tableName = 'user_main';

  private $passwords;

  public function __construct(Nette\Security\Passwords $passwords, Nette\Database\Explorer $db ) {
    $this->passwords = $passwords;
    $this->connection = $db;
  }

  /** Test existencie emailu
   * @param string $email
   * @return bool */
  public function testEmail(string $email): bool {
    return $this->findBy([self::COLUMN_EMAIL=>$email])->count() > 0 ? TRUE : FALSE;
  }
  
  /** Aktualizuje IP adresu posledneho prihlasenia
   * @param int $id
   * @param string $ip
   * @return boolean */
  public function logLastIp(int $id, string $ip): bool {
    return $this->find($id)->update([self::COLUMN_LAST_IP => $ip]);
  }
  
	/** Adds new user.
   * @return Nette\Database\Table\ActiveRow|int|bool
   * @throws DuplicateNameEmailException */
	public function add(string $meno, string $priezvisko, string $email, string $password, int $activated = 0, int $role = 0)	{
		try {
			$user_profiles = $this->connection->table('user_profiles')->insert([]); 
      return $this->pridaj([
        self::COLUMN_MENO             => $meno,
        self::COLUMN_PRIEZVISKO       => $priezvisko,
				self::COLUMN_PASSWORD_HASH    => $this->passwords->needsRehash($password),
				self::COLUMN_EMAIL            => $email,
        self::COLUMN_ID_USER_PROFILES => $user_profiles->id,
        self::COLUMN_ACTIVATED        => $activated,
        self::COLUMN_ID_USER_ROLES    => $role,
        self::COLUMN_CREATED          => date("Y-m-d H:i:s", Time()),
			]);
		} catch (Nette\Database\UniqueConstraintViolationException $e) {
      throw new DuplicateEmailException($e->getMessage());
		}
	}
  
  /**
   * @param Nette\Utils\ArrayHash $values
   * @return Nette\Database\Table\ActiveRow|int|bool
   * @throws Nette\Database\DriverException */
  public function saveUser(Nette\Utils\ArrayHash $values) {
    try {
      $id = $values->{self::COLUMN_ID};
      if (isset($values->{self::COLUMN_BANNED}) && !$values->{self::COLUMN_BANNED}) { $values->offsetSet("ban_reason", NULL); }
      if (isset($values->{self::COLUMN_TITUL_PRED}) && !strlen($values->{self::COLUMN_TITUL_PRED})) { $values->offsetSet(self::COLUMN_TITUL_PRED, NULL); }
      if (isset($values->{self::COLUMN_TITUL_ZA}) && !strlen($values->{self::COLUMN_TITUL_ZA})) { $values->offsetSet(self::COLUMN_TITUL_ZA, NULL); }
      
      unset($values->id);
      return $this->uloz($values, $id);
    } catch (\Exception $e) {
      throw new Nette\Database\DriverException('Chyba ulozenia: '.$e->getMessage());
    }
  }
  
  /**
   * Funkcia pre formulár na zostavenie zoznamu všetkých užívateľov
   * @return array Pole uzivatelov vo formate: id => "meno priezvisko" */
  public function uzivateliaForm(): array {
    $u = $this->findAll();
    $out = [];
    foreach ($u as $v) {
      $out[$v->{self::COLUMN_ID}] = $v->{self::COLUMN_MENO}." ".$v->{self::COLUMN_PRIEZVISKO};
    }
    return $out;
  }
  
  /**
   * Funkcia na zostavenie ratazca emailov podla urovne registracie pre odoslanie info mailu. 
   * @param int $id_user_roles Minimalna uroven registracie
   * @return string Retazec emailov oddelených ciarkami */
  public function emailUsersListStr(int $id_user_roles = 5): string {
    $cl = $this->findBy(['id_user_roles >='.$id_user_roles, 'user_profiles.news'=>'A']);
    $out = "";
    $sum = count($cl); $iter = 0;
    foreach ($cl as $c) {
      $iter++;
      $out .= $sum == $iter ? $c->email : $c->email.', '; 
    }
    return $out;
  }
  
  /**
   * Funkcia na zostavenie ratazca emailov podla urovne registracie pre odoslanie info mailu. 
   * @param int $id_user_roles Minimalna uroven registracie
   * @return array id=>email */
  public function emailUsersListArray(int $id_user_roles = 5): array {
    $cl = $this->findBy(['id_user_roles >='.$id_user_roles, 'user_profiles.news'=>'A']);
    $out = [];
    foreach ($cl as $c) {
      if ($c->email != '---') {
        $out[$c->id] = $c->email; 
      }
    }
    return $out;
  }
  
  /**
   * Najde id uzivatela podla parametrov 
   * @param array $param Pole parametrov
   * @return int */
  public function findIdBy(array $param = []): int {
    return ($tmp = $this->findOneBy($param)) !== FALSE ? $tmp->{self::COLUMN_ID} : 0;
  }

  public function getUser(int $id): ?Nette\Database\Table\ActiveRow {
    return $this->find($id);
  }
}

class DuplicateEmailException extends \Exception
{}