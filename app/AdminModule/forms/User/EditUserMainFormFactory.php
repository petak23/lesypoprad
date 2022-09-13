<?php

declare(strict_types=1);

namespace App\AdminModule\Forms\User;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Security\Passwords;
use Nette\Security\User;
use Nette\Utils\Html;

/**
 * Tovarnicka pre formular na editaciu uzivatela
 * Posledna zmena 20.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.1.1
 */
class EditUserMainFormFactory {
  /** @var DbTable\User_main */
	private $user_main;
  /** @var DbTable\User_categories */
	private $user_categories;
  /** @var DbTable\User_in_categories */
	private $user_in_categories;
  /** @var array */
  private $urovneReg;
  /** @var Passwords */
  private $passwords;

  /**
   * @param DbTable\User_categories $user_categories
   * @param DbTable\User_in_categories $user_in_categories
   * @param DbTable\User_main $user_main
   * @param DbTable\User_roles $user_roles
   * @param User $user */
  public function __construct(DbTable\User_categories $user_categories,
                              DbTable\User_in_categories $user_in_categories,
                              DbTable\User_main $user_main, 
                              DbTable\User_roles $user_roles, 
                              User $user,
                              Passwords $passwords) {
    $this->user_categories = $user_categories;
    $this->user_in_categories = $user_in_categories;
		$this->user_main = $user_main;
    $this->urovneReg = $user_roles->urovneReg(($user->isLoggedIn()) ? $user->getIdentity()->id_user_roles : 0); //Hodnoty id=>nazov pre formulare z tabulky user_roles
    $this->passwords = $passwords;
	}
  /**
   * Formular
   * @param array $user_view_fields Nastavenia z config.neon
   * @return Form */
  public function create(array $user_view_fields): Form  {
    $form = new Form();
		$form->addProtection();
    $form->addHidden('id');$form->addHidden('id_user_profiles');$form->addHidden('created');$form->addHidden('modified');
    $form->addGroup();
      if ($user_view_fields["titul_pred"]) { $form->addText('titul_pred', 'Titul pred menom:', 15, 15); }
      $form->addText('meno', 'Meno:', 50, 80)
           ->addRule(Form::MIN_LENGTH, 'Meno musí mať spoň %d znakov!', 3)
           ->setRequired('Meno musí byť zadané!');
      $form->addText('priezvisko', 'Priezvisko:', 50, 80)
           ->addRule(Form::MIN_LENGTH, 'Priezvisko musí mať spoň %d znakov!', 3)
           ->setRequired('Priezvisko musí byť zadané!');
      if ($user_view_fields["titul_za"]) { $form->addText('titul_za', 'Titul za menom:', 15, 15); }
      $form->addText('email', 'E-mailová adresa', 50, 50)
           ->setType('email')
           ->addRule(Form::EMAIL, 'Musí byť zadaná korektná e-mailová adresa(napr. janko@hrasko.sk)')
           ->setRequired('E-mailová adresa musí byť zadaná!');
      $form->addSelect('id_user_roles', 'Úroveň registrácie člena:', $this->urovneReg);
      $form->addCheckbox('activated', 'Aktivovaný užívateľ');
      $form->addCheckbox('banned', 'Blokovaný užívateľ')
           ->setDefaultValue(FALSE)
           ->addCondition(Form::EQUAL, TRUE)
            ->toggle("ban_reason", TRUE);
    $form->addGroup()->setOption('container', Html::el('fieldset')->id("ban_reason"));
      $form->addText('ban_reason', 'Dôvod blokovania:', 50, 255);
    $form->setCurrentGroup(NULL);
    $form->addGroup();
    $form->addCheckbox('change_password', 'Nastaviť nové heslo')
         ->setDefaultValue(FALSE)
         ->addCondition(Form::EQUAL, TRUE)
          ->toggle("ch_psswd", TRUE);
    $form->addGroup()->setOption('container', Html::el('fieldset')->id("ch_psswd"));
      $form->addPassword('heslo', 'Heslo', 50, 50)
           ->addCondition(Form::FILLED)
            ->addRule(Form::MIN_LENGTH, 'Heslo musí mať aspoň %s znakov', 5)
            ->setRequired('Heslo musí byť zadané!');
      $form->addPassword('heslo2', 'Zopakovanie hesla', 50, 50)
            ->addCondition(Form::FILLED)
            ->addRule(Form::EQUAL, 'Heslo a zopakované heslo musí byť rovnaké-1!', $form['heslo'])
            ->setRequired('Zopakované heslo musí byť zadané!');
            //->setOmitted(); // https://doc.nette.org/cs/3.1/form-presenter#toc-validacni-pravidla;
    $form->setCurrentGroup(NULL);
    if ($user_view_fields["categori"]) { $form->addCheckboxList('categori', 'Kategória', $this->user_categories->findAll()/*findBy(["main_category != 'B'"])*/->fetchPairs('id', 'name')); }
    $form->onValidate[] = [$this, 'validateEditUserForm'];
    $form->addSubmit('uloz', 'Ulož')
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'editUserFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')->setAttribute('class', 'btn btn-default')
         ->setValidationScope([]);
		return $form;
	}
  
  /** 
   * Vlastná validácia */
  public function validateEditUserForm(Form $form, \stdClass $values): void {
    if ($form['uloz']->isSubmittedBy()) {
      $user = $this->user_main->find($values->id);
      // Over, ci dany email uz existuje.
      $ue = $this->user_main->findOneBy(['email'=>$values->email]);
      if ($ue && ($user->id <> $ue->id)) {
        $form->addError(sprintf('Zadaný e-mail %s už existuje! Zvolte prosím iný!', $values->email));
      }
      if (strlen($values->heslo) && $values->heslo != $values->heslo2) {
        $form->addError("Zadané heslá nie sú rovnaké! Prosím, zadajte ich znovu.");
      }
    }
  }
  
  /** 
   * Spracovanie vstupov z formulara */
	public function editUserFormSubmitted(Form $form, $values) {
    try {
      if (isset($values->categori)) {
        $this->user_in_categories->saveMultiCategori($values->id, $values->categori);
        unset($values->categori);
      }
      if (strlen($values->heslo)) {
        $values->offsetSet("password", $this->passwords->hash($values->heslo));
      }
      unset($values->heslo, $values->heslo2, $values->change_password);
			$this->user_main->saveUser($values);
		} catch (Database\DriverException $e) {
			$form->addError($e->getMessage());
		}
	}
}