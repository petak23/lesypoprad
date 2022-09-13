<?php

namespace App\FrontModule\Forms\User;

use DbTable;
use Language_support;
use Nette\Application\UI\Form;
use Nette\Security;

/**
 * Formular pre reset hesla
 * Posledna zmena 08.02.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.9
 */
class ResetPasswordFormFactory {
  /** @var User */
  private $user;
  /** @var Language_support\LanguageMain */
  private $texts;
  /** @var DbTable\User_main */
  private $user_main;
  /** @var Security\Passwords */
  private $passwords;

  /** @param Security\User $user   */
  public function __construct(Security\User $user, 
                              Language_support\LanguageMain $language_main, 
                              DbTable\User_main $user_main,
                              Security\Passwords $passwords) {
    $this->user = $user;
    $this->texts = $language_main;
    $this->user_main = $user_main;
    $this->passwords = $passwords;
	}
  
  /**
   * Prihlasovaci formular s*/
  public function create(string $language): Form  {
    $this->texts->setLanguage($language);
    $form = new Form();
		$form->addProtection();
    $form->setTranslator($this->texts);
    $form->addHidden('id');
    $form->addPassword('new_heslo', 'ResetPasswordForm_new_heslo')
         ->setAttribute('autofocus', 'autofocus')
				 ->setRequired('ResetPasswordForm_new_heslo_sr');
		$form->addPassword('new_heslo2', 'ResetPasswordForm_new_heslo2')
         ->addRule(Form::EQUAL, 'ResetPasswordForm_new_heslo2_ar', $form['new_heslo'])
				 ->setRequired('ResetPasswordForm_new_heslo2_sr')
         ->setOmitted(); // https://doc.nette.org/cs/3.1/form-presenter#toc-validacni-pravidla;
		$form->addSubmit('uloz', 'base_save');
    $form->onSuccess[] = [$this, 'userPasswordResetFormSubmitted'];
		return $form;
	}
  
  /** 
   * Overenie po odoslani */
  public function userPasswordResetFormSubmitted(Form $form, $values) {

    //Vygeneruj kluc pre zmenu hesla
    $new_password = $this->passwords->hash($values->new_heslo);
    unset($values->new_heslo); //Len pre istotu
    $this->user_main->find($values->id)
                    ->update(['password'=>$new_password, 
                              'new_password_key'=>NULL, 
                              'new_password_requested'=>NULL
                              ]);
	}
}
