<?php
declare(strict_types=1);

namespace App\AdminModule\Components\Article\TitleArticle;

use DbTable;
use Nette\Application\UI;
use Nette\Database;
use Nette\Security\User;
/**
 * Formular a jeho spracovanie pre zmenu urovne registracie polozky.
 * Posledna zmena 04.05.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.5
 */
class ZmenUrovenRegistracieFormFactory {
  /** @var DbTable\Hlavne_menu */
	private $hlavne_menu;
  
  /** @var array */
	private $user_roles;
  
  /**
   * @param DbTable\Hlavne_menu $hlavne_menu
   * @param DbTable\User_roles $user_roles
   * @param User $user */
  public function __construct(DbTable\Hlavne_menu $hlavne_menu, DbTable\User_roles $user_roles, User $user) {
		$this->hlavne_menu = $hlavne_menu;
    $this->user_roles = $user_roles->urovneReg($user->getIdentity()->id_user_roles);
	}
  
  /**
   * Formular pre zmenu urovne registracie polozky.
   * @param int $id Id polozky v hlavnom menu
   * @param int $id_user_roles Sucasna uroven registracie polozky
   * @return UI\Form */  
  public function create(int $id, int $id_user_roles): UI\Form  {
		$form = new UI\Form();
		$form->addProtection();
    $form->addHidden("id", (string)$id);
    $form->addRadioList('id_user_roles', 'Nová úroveň:', $this->user_roles)
         ->setDefaultValue($id_user_roles);
    $form->addSubmit('uloz', 'Zmeň')
         ->setHtmlAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'zmenUrovenRegistracieFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')
         ->setHtmlAttribute('class', 'btn btn-default')
         ->setHtmlAttribute('data-dismiss', 'modal')
         ->setHtmlAttribute('aria-label', 'Close')
         ->setValidationScope([]);
		return $form;
	}
  
  /** 
   * Spracovanie formulara pre zmenu vlastnika clanku. */
  public function zmenUrovenRegistracieFormSubmitted(UI\Form $form, $values) {		
    try {
			$this->hlavne_menu->zmenUrovenRegistracie($values);
		} catch (Database\DriverException $e) {
			$form->addError($e->getMessage());
		}
  }
}