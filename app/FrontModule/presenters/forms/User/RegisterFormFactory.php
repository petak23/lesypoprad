<?php

namespace App\FrontModule\Presenters\Forms\User;
use Nette\Application\UI\Form;
use Nette\Security\User;
use Language_support;
use DbTable;

/**
 * Registracny formular
 * Posledna zmena 06.06.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
class RegisterFormFactory {
  /** @var Security\User */
  protected $user;
  /** @var Language_support\LanguageMain */
  private $texts;
  /** @var DbTable\User_main */
  private $user_main;
  /** @var string */
  private $link_forgot;
  

  /**
   * @param User $user
   * @param Language_support\User $texts
   * @param DbTable\User_main $user_main */
  public function __construct(User $user, Language_support\LanguageMain $texts, DbTable\User_main $user_main) {
    $this->user = $user;
    $this->texts = $texts;
    $this->user_main = $user_main;
	}
  
  /** Vratenie textu pre dany kluc a jazyk
   * @param string $key - kluc daneho textu
   * @return string - hodnota pre dany text */
  private function trLang($key) {
    return $this->texts->translate($key);
  }
  
  /** Prihlasovaci formular
   * @return Nette\Application\UI\Form */
  public function create($user_view_fields, $link_forgot)  {
    $this->link_forgot = $link_forgot;
    $form = new Form();
		$form->addProtection();
    $form->addText('meno', $this->trLang('RegistraciaForm_meno'), 50, 50)
				 ->addRule(Form::MIN_LENGTH, $this->trLang('RegistraciaForm_meno_ar'), 2)
         ->setAttribute('autofocus', 'autofocus')
				 ->setRequired($this->trLang('RegistraciaForm_meno_sr'));
    $form->addText('priezvisko', $this->trLang('RegistraciaForm_priezvisko'), 50, 50)
				 ->addRule(Form::MIN_LENGTH, $this->trLang('RegistraciaForm_priezvisko_ar'), 3)
				 ->setRequired($this->trLang('RegistraciaForm_priezvisko_sr'));
    $form->addText('email', $this->trLang('Form_email'), 50, 50)
         ->setType('email')
				 ->addRule(Form::EMAIL, $this->trLang('Form_email_ar'))
				 ->setRequired($this->trLang('Form_email_sr'));
    $form->addPassword('heslo', $this->trLang('RegistraciaForm_heslo'), 50, 50)
				 ->addRule(Form::MIN_LENGTH, $this->trLang('RegistraciaForm_heslo_ar'), 5)
				 ->setRequired($this->trLang('RegistraciaForm_heslo_sr'));
    $form->addPassword('heslo2', $this->trLang('RegistraciaForm_heslo2'), 50, 50)
         ->addRule(Form::EQUAL, $this->trLang('RegistraciaForm_heslo2_ar'), $form['heslo'])
				 ->setRequired($this->trLang('RegistraciaForm_heslo2_sr'));
    if ($user_view_fields["pohl"]) {
      $form->addSelect('pohl', $this->trLang('RegistraciaForm_pohl'),
        							 ['M'=>$this->trLang('RegistraciaForm_m'),'Z'=>$this->trLang('RegistraciaForm_z')]);
    }
    $form->onValidate[] = [$this, 'validateRegisterForm'];
		$form->addSubmit('uloz', $this->trLang('RegistraciaForm_uloz'))
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'userRegisterFormSubmitted'];
		return $form;
	}
  
  /** Vlastná validácia pre RegisterForm
   * @param Nette\Application\UI\Form $button */
  public function validateRegisterForm($button) {
    $values = $button->getForm()->getValues();
    if ($button->isSubmitted()->name == 'uloz') {
      // Over, ci dany email uz existuje.
      if ($this->user_main->testEmail($values->email)) {
        $button->addError(sprintf($this->trLang('registracia_email_duble2'), $values->email, $this->link_forgot));
      }
    } 
  }
}