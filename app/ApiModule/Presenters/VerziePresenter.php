<?php

declare(strict_types=1);

namespace App\ApiModule\Presenters;

/**
 * Prezenter pre pristup k api verzií.
 * Posledna zmena(last change): 16.11.2022
 *
 * Modul: API
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.3
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

  /** Uloženie verzie do DB 
   * @param int $id Id_hlavne_menu, ku ktorému ukladám dokument */
  public function actionSave(int $id)
  {
    $_post = json_decode(file_get_contents("php://input"), true);
    //dumpe($_post['to_save']);
    $sk = $this->verzie->uloz(['cislo' => $_post['to_save'][0], 'text' => $_post['to_save'][1]], $id);
    if ($sk !== null) {
      $upload = [
        'status'  => 200,
        'data'    => ['OK'],
      ];
    } else {
      $upload = [
        'status'  => 500,
        'data'    => null,
      ];
    }

    if ($this->isAjax()) {
      $this->sendJson($upload);
    } else {
      $this->redirect(':Admin:Verzie:');
    }
  }
}
