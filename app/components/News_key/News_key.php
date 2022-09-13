<?php
declare(strict_types=1);

namespace PeterVojtech\News_key;

use DbTable;
use Nette\Application\UI;
use Nette\Security;

/**
 * Komponenta pre pracu s klucom pre novinky v odkaze
 * Posledna zmena(last change): 10.02.2022
 * 
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.3
 */

class NewsKeyControl extends UI\Control {
  
  /** @var DbTable\User_profiles */
  public $user_profiles;
  /** @var Security\Identity */
  public $user_identity;
  /** @var Security\Passwords */
  private $passwords;

  public function __construct(DbTable\User_profiles $user_profiles, 
                              Security\User $user,
                              Security\Passwords $passwords) {
    $this->user_profiles = $user_profiles;
    $this->user_identity = $user->getIdentity();
    $this->passwords = $passwords;
  }
  
  /** Generuje news_key a uloží k danému uzivatelovi */
  public function Generate() {
    $this->user_profiles->find($this->user_identity->id_user_profiles)
                        ->update(['news_key'=>$this->passwords->hash($this->user_identity->email."news=>A"), 'news'=>"A"]);
  }
  
  /** Vymaze news_key konkretneho uzivatela */
  public function Delete() {
    $this->user_profiles->find($this->user_identity->id_user_profiles)->update(['news_key'=>NULL, 'news'=>"N"]);
  }
  
  /**
   * Rozhodne co urobit
   * @param string $news Volba posielania novinky */
  public function Spracuj($news) {
    if ($news == "A") {
      $this->Generate();
    } else {
      $this->Delete();
    }
  }
}