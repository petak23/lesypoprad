<?php

declare(strict_types=1);

namespace App\AdminModule\Forms\User;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Security\User;

/**
 * Tovarnicka pre formular na editaciu profilu uzivatela
 * Posledna zmena 13.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.5
 */
class EditUserProfilesFormFactory {
  /** @var DbTable\User_profiles */
	private $user_profiles;
  
  /**
   * @param DbTable\User_profiles $user_profiles
   * @param DbTable\User_roles $user_roles
   * @param User $user */
  public function __construct(DbTable\User_profiles $user_profiles, DbTable\User_roles $user_roles, User $user) {
    $this->user_profiles = $user_profiles;
    $this->urovneReg = $user_roles->urovneReg(($user->isLoggedIn()) ? $user->getIdentity()->id_user_roles : 0); //Hodnoty id=>nazov pre formulare z tabulky user_roles
	}
  /**
   * Formular
   * @param array $user_view_fields Nastavenia z config.neon
   * @return Form */
  public function create(array $user_view_fields): Form  {
    $form = new Form();
		$form->addProtection();
    $form->addHidden('id');
    if ($user_view_fields["rok"]) {
      $form->addText('rok', 'Rok narodenia:', 4, 5)
           ->addRule(Form::RANGE, 'Rok narodenia musí byť v rozsahu od %d do %d', [1900, date("Y", Time())])
           ->setRequired(FALSE);
    }
    if ($user_view_fields["telefon"]) { $form->addText('telefon', 'Telefón:', 20, 20); }
    if ($user_view_fields["poznamka"]) { $form->addText('poznamka', 'Poznámka:', 50, 250); }
    if ($user_view_fields["pohl"]) { $form->addSelect('pohl', 'Pohlavie:', ['M'=>'Muž','Z'=>'Žena']); }
    $form->addSubmit('uloz', 'Ulož')
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'editUserFormSubmitted'];;
    $form->addSubmit('cancel', 'Cancel')->setAttribute('class', 'btn btn-default')
         ->setValidationScope([]);
		return $form;
	}
  
  /** 
   * Spracovanie vstupov z formulara
   * @param \Nette\Forms\Controls\SubmitButton $button Data formulara */
	public function editUserFormSubmitted(\Nette\Forms\Controls\SubmitButton $button)	{
    $values = $button->getForm()->getValues();
    try {
			$this->user_profiles->saveUser($values);
		} catch (Database\DriverException $e) {
			$button->addError($e->getMessage());
		}
	}
}