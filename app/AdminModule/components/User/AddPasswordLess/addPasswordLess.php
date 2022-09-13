<?php
declare(strict_types=1);

namespace App\AdminModule\Components\User\AddPasswordLess;

use Nette\Application\UI\Control;

/**
 * Komponenta pre vytvorenie pridanie užívateľa bez oprávnenia.
 * 
 * Posledna zmena(last change): 13.05.2020
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2020 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.1
 */
class AddPasswordLessControl extends Control {
  /** @var AddPasswordLessFormFactory */
	public $addPasswordLessFormFactory;

  /**
   * @param \App\AdminModule\Components\User\AddPasswordLess\AddPasswordLessFormFactory $addPasswordLessFormFactory */
  public function __construct(AddPasswordLessFormFactory $addPasswordLessFormFactory) {
    $this->addPasswordLessFormFactory = $addPasswordLessFormFactory;
  }
  
  /** 
   * Render */
	public function render() {
    $this->template->setFile(__DIR__ . '/addPasswordLess.latte');
		$this->template->render();
	}

  /** 
   * Komponenta formulara pre zmenu vlastnika.
   * @return Nette\Application\UI\Form */
  public function createComponentAddPasswordLessForm() {
    $form = $this->addPasswordLessFormFactory->create();
    $form['uloz']->onClick[] = function ($button) { 
      $this->presenter->flashOut(!count($button->getForm()->errors), 'this', 'Zmena bola úspešne uložená!', 'Došlo k chybe a zmena sa neuložila. Skúste neskôr znovu...');
		};
    return $this->presenter->_vzhladForm($form);
  }
  
}

interface IAddPasswordLessControl {
  /** @return AddPasswordLessControl */
  function create();
}