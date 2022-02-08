<?php
declare(strict_types=1);

namespace App\Model;

use DbTable;
use Nette;
use Nette\Security\SimpleIdentity;


/**
 * Model starajuci sa o uzivatela
 * 
 * Posledna zmena(last change): 13.01.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.9
 */
class UserManager implements Nette\Security\Authenticator {
	use Nette\SmartObject;

	const
    // Mandatory columns for table user_main
		COLUMN_ID = 'id',
    COLUMN_ID_USER_ROLES = 'id_user_roles',
    COLUMN_ID_USER_PROFILES = 'id_user_profiles',
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
  /** @var Nette\Security\Passwords */
  private $passwords;
  
  /**
   * @param DbTable\User_main $user_main
   * @param DbTable\User_profiles $user_profiles
   * @param DbTable\User_prihlasenie $user_prihlasenie
   * @param Nette\Http\Request $httpres
   * @param Security\Passwords $passwords */
  public function __construct(DbTable\User_main $user_main, 
                              DbTable\User_profiles $user_profiles, 
                              DbTable\User_prihlasenie $user_prihlasenie, 
                              Nette\Http\Request $httpres,
                              Nette\Security\Passwords $passwords) {
    $this->user_main = $user_main;
    $this->user_profiles = $user_profiles;
    $this->user_prihlasenie = $user_prihlasenie;
    $this->httpres = $httpres;
    $this->passwords = $passwords;
	}

	/**
	 * Performs an authentication.
   * @param array $credentials
	 * @return Nette\Security\Identity
	 * @throws Nette\Security\AuthenticationException 
   *  IDENTITY_NOT_FOUND = 1
   *  INVALID_CREDENTIAL = 2
   *  FAILURE = 3
   *  NOT_APPROVED = 4 */
	public function authenticate(string $username, string $password): SimpleIdentity {
		$email = $username;
    
    $row = $this->user_main->findOneBy([self::COLUMN_EMAIL => $email]);
		if (!$row) {
			throw new Nette\Security\AuthenticationException("The email '$email' is incorrect. Užívateľský email '$email' nie je správny!", self::IDENTITY_NOT_FOUND);
    } elseif (!$row[self::COLUMN_ACTIVATED]) {
			throw new Nette\Security\AuthenticationException("User with email '$email' not activated. Užívateľ s email-om '$email' ešte nie je aktivovaný!", 4);
		} elseif ($row[self::COLUMN_BANNED]) {
			throw new Nette\Security\AuthenticationException("User with email '$email' is banned! Because: ".$row[self::COLUMN_BAN_REASON].". Užívateľ s email-om '$email' je blokovaný! Lebo: ".$row[self::COLUMN_BAN_REASON], 3);
		} elseif (!$this->passwords->verify($password, $row[self::COLUMN_PASSWORD_HASH])) {
			throw new Nette\Security\AuthenticationException('Invalid email or password. Chybný užívateľský email alebo heslo!', self::INVALID_CREDENTIAL);
		} elseif ($this->passwords->needsRehash($row[self::COLUMN_PASSWORD_HASH])) {
			$row->update([
				self::COLUMN_PASSWORD_HASH => $this->passwords->hash($password),
			]);
		}
    $role = $row->user_roles->{self::COLUMN_ROLE};
    $profil = $row->user_profiles->toArray();
		$arr = array_merge($row->toArray(), $profil, ['user_role' => $role]);
		unset($arr[self::COLUMN_PASSWORD_HASH], $password);
    $this->user_profiles->updateAfterLogIn($arr['id_user_profiles']);
    $this->user_main->logLastIp($row[self::COLUMN_ID], $this->httpres->getRemoteAddress());
    $this->user_prihlasenie->addLogIn($row[self::COLUMN_ID]);
		return new SimpleIdentity($row[self::COLUMN_ID], $role, $arr);
	}
}
