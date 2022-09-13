<?php
declare(strict_types=1);

namespace App\AdminModule\Components\Article\TitleArticle;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Database;

/**
 * Formular a jeho spracovanie pre zmenu vlastnika polozky.
 * Posledna zmena 30.09.2021
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2021 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.4
 */
class ZmenVlastnikaFormFactory {
  /** @var DbTable\Hlavne_menu */
	private $hlavne_menu;
  
  /** @var DbTable\User_main */
	private $user_main;
  
  public function __construct(DbTable\Hlavne_menu $hlavne_menu, DbTable\User_main $user_main) {
		$this->hlavne_menu = $hlavne_menu;
    $this->user_main = $user_main;
	}
  
  /**
   * Formular pre zmenu vlastnika polozky.
   * @param int $id Id polozky v hlavnom menu
   * @param int $id_user_profiles Id sucasneho vlastnika polozky
   * @return Form */  
  public function create(int $id, int $id_user_profiles = 0): Form  {
		$form = new Form();
		$form->addProtection();
    $form->addHidden("id", (string)$id);
    $form->addRadioList('id_user_main', 'Nový vlastník:', $this->user_main->uzivateliaForm())
         ->setDefaultValue($id_user_profiles);
    $form->addSubmit('uloz', 'Zmeň')
         ->setHtmlAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'zmenVlastnikaFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')
         ->setHtmlAttribute('class', 'btn btn-default')
         ->setHtmlAttribute('data-dismiss', 'modal')
         ->setHtmlAttribute('aria-label', 'Close')
         ->setValidationScope([]);
		return $form;
	}
  
  /** 
   * Spracovanie formulara pre zmenu vlastnika clanku.
   * @param \Nette\Forms\Controls\SubmitButton $button Data formulara */
  public function zmenVlastnikaFormSubmitted(\Nette\Forms\Controls\SubmitButton $button)  {
		$values = $button->getForm()->getValues(); 	//Nacitanie hodnot formulara
    try {
			$this->hlavne_menu->zmenVlastnika($values);
		} catch (Database\DriverException $e) {
			$button->addError($e->getMessage());
		}
  }
}