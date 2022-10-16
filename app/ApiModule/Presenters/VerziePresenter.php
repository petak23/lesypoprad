<?php

namespace App\ApiModule\Presenters;

use DbTable;

/**
 * Prezenter pre pristup k api verzií.
 * Posledna zmena(last change): 27.09.2022
 *
 * Modul: API
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.0
 */
class VerziePresenter extends BasePresenter
{

  // -- DB
  /* * @var DbTable\User_prihlasenie @inject */
  //public $user_prihlasenie;

  /**
   * Vráti posledné prihlásenia
   * @param int $count Počet zobrazených prihlásení */
  public function actionGetLastLogin(int $count = 25)
  {
    $this->sendJson($this->user_prihlasenie->getLastLogin($count, true));
  }

  /**
   * Vymaže všetky záznamy o prihlásení z DB tab. user_prihlasenie
   * Ak vracia 0 tak OK */
  public function actionDeleteAllLogin()
  {
    $this->sendJson(['result' => $this->user_prihlasenie->delAll()]);
  }
}