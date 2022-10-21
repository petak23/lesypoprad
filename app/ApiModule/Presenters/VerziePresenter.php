<?php

declare(strict_types=1);

namespace App\ApiModule\Presenters;

/**
 * Prezenter pre pristup k api verzií.
 * Posledna zmena(last change): 21.10.2022
 *
 * Modul: API
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.1
 */
class VerziePresenter extends BasePresenter
{

  /**
   * Vráti konkrétnu verziu
   * @param int $id Id verzie */
  public function actionGetVersion(int $id): void
  {
    $this->sendJson($this->verzie->find($id)->toArray());
  }
}
