<?php

namespace App\FrontModule\Forms\User;

use DbTable;
use Language_support;
use Nette\Application\UI\Form;
use Nette\Security;

/**
 * Formular pre vlozenie emailu v pripade zabudnuteho hesla
 * Posledna zmena 12.09.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.9
 */
class ForgottenPasswordFormFactory {
  /** @var Language_support\LanguageMain */
  private $texts;
  /** @var DbTable\User_main */
  public $user_main;
  /** @var Nette\Security\User */
  public $user;

  /** @param Security\User $user   */
  public function __construct(Security\User $user, Language_support\LanguageMain $language_main, DbTable\User_main $user_main) {
    $this->user = $user;
    $this->texts = $language_main;
    $this->user_main = $user_main;
	}

  /** @return Form */
  public function create(string $language)  {
    $this->texts->setLanguage($language);
    $form = new Form();
		$form->addProtection();
    $form->setTranslator($this->texts);
    $form->addEmail('email', 'Form_email')
         ->setHtmlAttribute('size', 0)->setHtmlAttribute('maxlength', 100)
         ->setHtmlAttribute('placeholder', 'Form_email_ph')
				 ->addRule(Form::EMAIL, 'Form_email_ar')
				 ->setRequired('Form_email_sr');
		$form->addSubmit('uloz', 'ForgottenPasswordForm_uloz')
         ->setHtmlAttribute('class', 'btn btn-success');
    $form->onValidate[] = [$this, 'validateForm'];
		return $form;
	}
  
  /** Vlastná validácia pre formular */
  public function validateForm(Form $form, \stdClass $values): void {    
    // Over, ci dany email existuje.
    if (!$this->user_main->testEmail($values->email)) {
      $form->addError(sprintf($this->texts->translate('forgot_pass_user_err'), $values->email));
    }
  }
}