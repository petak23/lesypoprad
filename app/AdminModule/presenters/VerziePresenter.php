<?php
namespace App\AdminModule\Presenters;

use App\AdminModule\Forms\Verzie;
use PeterVojtech\Email;

/**
 * Prezenter pre spravu verzii.
 * 
 * Posledna zmena(last change): 31.01.2022
 *
 *	Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.7
 */
class VerziePresenter extends BasePresenter {
  
  // -- Forms
  /** @var Verzie\EditVerzieFormFactory @inject*/
	public $editVerzieForm;
  
  // -- Components
  /** @var Email\EmailControl @inject */
  public $emailControl;
  
	public function renderDefault()	{
		$this->template->verzie = $this->verzie->vsetky();
	}
  /** Akcia pre pridanie verzie */
	public function actionAdd()	{
		$this->template->h2 = 'Pridanie verzie';
    $this["verzieEditForm"]->setDefaults([ 'id' => 0, 'id_user_main' => $this->getUser()->getId()]);
    $this->setView('edit');
	}

  /** 
   * Akcia pre editaciu verzie
   * @param int $id Id editovanej verzie */
	public function actionEdit(int $id)	{
    if (($verzia = $this->verzie->find($id)) === null) {
      $this->setView('notFound');
    } else {
      $this->template->h2 = 'Editácia verzie: '.$verzia->cislo;
      $this["verzieEditForm"]->setDefaults($verzia);
    }
	}

	/**
	 * Edit oznam form component factory.
	 * @return Nette\Application\UI\Form */
	protected function createComponentVerzieEditForm() {
    $form = $this->editVerzieForm->create();
    $form['uloz']->onClick[] = function ($button) { 
      $this->flashOut(!count($button->getForm()->errors), 'Verzie:', 'Verzia bola úspešne uložená!', 'Došlo k chybe a verzia sa neuložila. Skúste neskôr znovu...');
		};
    $form['cancel']->onClick[] = function () {
			$this->redirect('default');
		};
		return $this->_vzhladForm($form);
	}

  /** 
   * Funkcia pre spracovanie signálu vymazavania
	 * @param int $id Id polozky v hlavnom menu
	 * @param string $nazov Text pre hlasenie - cislo verzie */
	function confirmedDelete($id, $nazov = "")	{
    $this->flashOut($this->verzie->zmaz($id) == 1, 'Verzie:', 'Verzia '.$nazov.' bola úspešne vymazaná!', 'Došlo k chybe a verzia '.$nazov.' nebola vymazaná!');
  }
  
  /** Signal pre odoslanie informacneho emailu */
  public function handlePosliEmail($id) {
    $values = $this->verzie->find($id);
    $params = [ "site_name" => $this->nazov_stranky,
                "cislo" 		=> $values->cislo,
                "text"      => $this->texy->process($values->text),
                "odkaz" 		=> $this->link("Verzie:default"),
              ];
    try {
      $send = $this->emailControl->nastav(__DIR__.'/../templates/Verzie/verzie-html.latte', 1, 4)
                                 ->send($params, 'Nová verzia stránky');                                           
      $this->flashMessage('E-mail bol odoslany v poriadku na emaily: '.$send, 'success');
    } catch (Email\SendException $e) {
      $this->flashMessage($e->getMessage(), 'danger');
    }
		$this->redirect('this');
	}
}