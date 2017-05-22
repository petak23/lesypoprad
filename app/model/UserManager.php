<?php

namespace DbTable;

use Nette;
use Nette\Security\Passwords;
use DbTable;

/**
 * Model starajuci sa o uzivatela
 * Posledna zmena(last change): 22.05.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */
class UserManager implements Nette\Security\IAuthenticator {
	use Nette\SmartObject;

	const
    // Mandatory columns for table user_main
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
    COLUMN_CREATED = 'created',
    // Mandatory columns for table user_profiles
    // Mandatory columns for table user_roles
  	COLUMN_ROLE = 'role';

  /** @var DbTable\User_main */
  private $user_main;
  /** @var DbTable\User_profiles */
  private $user_profiles;
  /** @var DbTable\User_prihlasenie */
  private $user_prihlasenie;
  /** @var Nette\Http\Request */
  private $httpres;
  
  /**
   * @param \App\Model\User_main $user_main
   * @param \App\Model\User_profiles $user_profiles
   * @param Nette\Http\Request $httpres  */
  public function __construct(DbTable\User_main $user_main, DbTable\User_profiles $user_profiles, DbTable\User_prihlasenie $user_prihlasenie, Nette\Http\Request $httpres) {
    $this->user_main = $user_main;
    $this->user_profiles = $user_profiles;
    $this->user_prihlasenie = $user_prihlasenie;
    $this->httpres = $httpres;
	}

	/**
	 * Performs an authentication.
	 * @return Nette\Security\Identity
	 * @throws Nette\Security\AuthenticationException */
	public function authenticate(array $credentials) {
		list($username, $password) = $credentials;
    
    $row = $this->user_main->testByUsernameOrEmail($username);
		if (!$row) {
			throw new Nette\Security\AuthenticationException("The username '$username' is incorrect. Užívateľské meno '$username' nie je správne!", self::IDENTITY_NOT_FOUND);
    } elseif (!$row[self::COLUMN_ACTIVATED]) {
			throw new Nette\Security\AuthenticationException("User '$username' not activated. Užívateľ '$username' ešte nie je aktivovaný!", self::FAILURE);
		} elseif ($row[self::COLUMN_BANNED]) {
			throw new Nette\Security\AuthenticationException("User '$username' is banned! Because: ".$row[self::COLUMN_BAN_REASON]." | Užívateľ '$username' je blokovaný! Lebo: ".$row[self::COLUMN_BAN_REASON], self::FAILURE);
		} elseif (!Passwords::verify($password, $row[self::COLUMN_PASSWORD_HASH])) {
			throw new Nette\Security\AuthenticationException('Invalid username or password. Chybné užívateľské meno alebo heslo!', self::INVALID_CREDENTIAL);
		} elseif (Passwords::needsRehash($row[self::COLUMN_PASSWORD_HASH])) {
			$row->update([
				self::COLUMN_PASSWORD_HASH => Passwords::hash($password),
			]);
		}
    $role = $row->user_roles->{self::COLUMN_ROLE};
		$arr = $row->toArray();
		unset($arr[self::COLUMN_PASSWORD_HASH], $password);
    $this->user_profiles->updateAfterLogIn($arr['id_user_profiles']);
    $this->user_main->logLastIp($row[self::COLUMN_ID], $this->httpres->getRemoteAddress());
    $this->user_prihlasenie->addLogIn($row[self::COLUMN_ID]);
		return new Nette\Security\Identity($row[self::COLUMN_ID], $role, $arr);
	}
}