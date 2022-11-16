<?php

namespace App\AdminModule\Presenters;

use PeterVojtech\Email;

/**
 * Prezenter pre spravu verzii.
 * 
 * Posledna zmena(last change): 16.11.2022
 *
 *	Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.8
 */
class VerziePresenter extends BasePresenter
{
  // -- Components
  /** @var Email\EmailControl @inject */
  public $emailControl;

  public function renderDefault(): void
  {
    $this->template->verzie = $this->verzie->vsetky();
  }
  /** Akcia pre pridanie verzie */
  public function actionAdd(): void
  {
    $this->template->h2 = 'Pridanie verzie';
    $this->template->verzia_id = 0;
    $this->setView('edit');
  }

  /** 
   * Akcia pre editaciu verzie
   * @param int $id Id editovanej verzie */
  public function actionEdit(int $id): void
  {
    if (($verzia = $this->verzie->find($id)) === null) {
      $this->setView('notFound');
    } else {
      $this->template->h2 = 'Editácia verzie: ' . $verzia->cislo;
      $this->template->verzia_id = $verzia->id;
    }
  }

  /** 
   * Funkcia pre spracovanie signálu vymazavania
   * @param int $id Id polozky v hlavnom menu
   * @param string $nazov Text pre hlasenie - cislo verzie */
  function confirmedDelete($id, $nazov = ""): void
  {
    $this->flashOut($this->verzie->zmaz($id) == 1, 'Verzie:', 'Verzia ' . $nazov . ' bola úspešne vymazaná!', 'Došlo k chybe a verzia ' . $nazov . ' nebola vymazaná!');
  }

  /** Signal pre odoslanie informacneho emailu */
  public function handlePosliEmail($id): void
  {
    $values = $this->verzie->find($id);
    $params = [
      "site_name" => $this->nazov_stranky,
      "cislo"     => $values->cislo,
      "text"      => $this->texy->process($values->text),
      "odkaz"     => $this->link("Verzie:default"),
    ];
    try {
      $send = $this->emailControl->nastav(__DIR__ . '/../templates/Verzie/verzie-html.latte', 1, 4)
        ->send($params, 'Nová verzia stránky');
      $this->flashMessage('E-mail bol odoslany v poriadku na emaily: ' . $send, 'success');
    } catch (Email\SendException $e) {
      $this->flashMessage($e->getMessage(), 'danger');
    }
    $this->redirect('this');
  }
}
