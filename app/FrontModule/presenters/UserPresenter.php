<?php
namespace App\FrontModule\Presenters;

use App\FrontModule\Forms\User;
use DbTable;
use Nette\Application\UI\Form;
use Nette\Security\Passwords;
use Nette\Utils\Random;
use PeterVojtech\Email;

/**
 * Prezenter pre prihlasenie, registraciu a aktiváciu uzivatela, obnovenie zabudnutého hesla a zresetovanie hesla.
 * Posledna zmena(last change): 22.09.2022
 *
 *	Modul: FRONT
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.2.8
 */
class UserPresenter extends BasePresenter {
	
  // -- DB
  /** @var DbTable\User_main @inject */
	public $user_main;
  /** @var DbTable\User_profiles @inject */
	public $user_profiles;                       
  
  // -- Forms
  /** @var User\SignInFormFactory @inject*/
  public $signInForm;
  /** @var User\RegisterFormFactory @inject*/
	public $registerForm;
  /** @var User\ResetPasswordFormFactory @inject*/
	public $resetPasswordForm;
  /** @var User\ForgottenPasswordFormFactory @inject*/
	public $forgottenPasswordForm;
 
  /** @var Passwords */
  private $passwords;

  /** @var Email\EmailControl @inject */
  public $myMailer;

  /** @var array Nastavenie zobrazovania volitelnych poloziek */
  private $user_view_fields;

  public function __construct($parameters, Passwords $passwords) {
    parent::__construct($parameters);
    $this->user_view_fields = $parameters['user_view_fields'];
    $this->passwords = $passwords;
	}
  
	protected function startup(): void {
    parent::startup();
    //Test prihlásenia
    if ($this->user->isLoggedIn()) { 
      $this->flashRedirect('Homepage:', $this->texty_presentera->translate('base_loged_in_bad'), 'danger');
    }
	}

  /** 
   * Formular pre prihlasenie uzivatela.
   * @return Nette\Application\UI\Form */
  protected function createComponentSignInForm() {
    $form = $this->signInForm->create($this->language);
    $form['login']->onClick[] = function () {
      $useri = $this->user->getIdentity();
      $this->myMailer->sendAdminMail("Prihlásenie", "Prihlásenie užívateľa:".$useri->meno." ". $useri->priezvisko);
      $this->flashMessage('base_login_ok', 'success');
      $this->restoreRequest($this->backlink);
      $this->redirect('Homepage:');
    };
    $form['forgottenPassword']->onClick[] = function ($button) {
      $this->redirect('User:forgottenPassword', [$button->getForm()->getHttpData()["email"]]);
    };
    return $this->_vzhladForm($form);
  }

  /** Akcia pre registráciu nového uzivatela */
  public function actionRegistracia(): void {
    if ($this->udaje->findOneBy(['nazov'=>'registracia_enabled'])->text != 1) {
      $this->flashRedirect('Homepage:', 'registracia_not_enabled', 'danger');
    }
  }
  
  /**
   * Akcia pre aktivaciu registrovaneho uzivatela 
   * @param int $id Id uzivatela
   * @param string $new_password_key Kontrolny retazec pre aktivaciu */
  public function actionActivateUser(int $id, string $new_password_key): void {
    $user_main_data = $this->user_main->find($id); // Najdi uzivatela
    if ($new_password_key == $user_main_data->new_password_key){ //Aktivacne data su v poriadku
      $user_main_data->update(['id_user_roles'=>1, 'activated'=>1, 'new_password_key'=>NULL]); // Aktivacia uzivatela
      $this->myMailer->sendAdminMail("Aktivácia", "Aktivácia užívateľa:".$user_main_data->meno." ". $user_main_data->priezvisko);
      $this->user_profiles->uloz(['news'=>'A', 'news_key'=>$this->passwords->hash($user_main_data->email."news=>A")], $user_main_data->id_user_profiles);	// Zapnutie posielania noviniek pri aktivacii
      $this->flashRedirect('User:', $this->texty_presentera->translate('activate_ok'), 'success');
    } else { //Neuspesna aktivacia
      $this->flashMessage($this->texty_presentera->translate('activate_err2'), 'danger'); 
    } 
    $this->redirect('Homepage:');
  }

  /** 
   * Akcia pre reset hesla pri zabudnutom hesle 
   * @param int $id Id uzivatela pre reset hesla
   * @param string $new_password_key Kontrolny retazec pre reset hesla */
  public function actionResetPassword(int $id, string $new_password_key): void {
    if (!isset($id) OR !isset($new_password_key)) {
      $this->flashRedirect('Homepage:', $this->texty_presentera->translate('reset_pass_err1'), 'danger');
    } else {
      $user_main_data = $this->user_main->find($id);
      if ($new_password_key == $user_main_data->new_password_key){ 
        $this->template->email = sprintf($this->texty_presentera->translate('reset_pass_email'), $user_main_data->email);
        $this["resetPasswordForm"]->setDefaults(["id"=>$id]); //Nastav vychodzie hodnoty
      } else { 
        $this->flashRedirect('Homepage:', $this->texty_presentera->translate('reset_pass_err'.($user_main_data->new_password_key == NULL ? '2' : '3')), 'danger');
      }
    }
  }
  
  /** 
   * Formular pre registraciu uzivatela.
	 * @return Nette\Application\UI\Form */
	protected function createComponentClenRegistraciaForm() {
    $form = $this->registerForm->create($this->user_view_fields, $this->link('User:forgotPassword'), $this->language);
    $form['uloz']->onClick[] = [$this, 'userRegisterFormSubmitted'];
    $form->getElementPrototype()->class = 'noajax';
		return $this->_vzhladForm($form);
	}

  /** 
   * Spracovanie reistracneho formulara */
  public function userRegisterFormSubmitted(Form $form, $values): void {
		// Inicializacia
    $new_password_key = Random::generate(25);
    if (($uloz_user_profiles = $this->user_profiles->uloz(['pohl' => isset($values->pohl) ? $values->pohl : 'Z'])) !== FALSE) { //Ulozenie v poriadku
      $uloz_user_main = $this->user_main->uloz([ 
        'id_user_profiles' => $uloz_user_profiles['id'],
        'meno'      => $values->meno,
        'priezvisko'=> $values->priezvisko,
        'password'  => $this->passwords->hash($values->heslo),
        'email'     => $values->email,
        'activated' => 0,
        'created'   => date("Y-m-d H:i:s", Time()),
      ]);
   }
   if ($uloz_user_main !== FALSE) { //Ulozenie v poriadku
      $this->flashMessage($this->texty_presentera->translate('base_save_ok'), 'success');
      $params = [
        "site_name" => $this->nazov_stranky,
        "nadpis"    => sprintf($this->texty_presentera->translate('email_activate_nadpis'),$this->nazov_stranky),
        "email_activate_txt" => $this->texty_presentera->translate('email_activate_txt'),
        "email_nefunkcny_odkaz" => $this->texty_presentera->translate('email_nefunkcny_odkaz'),
        "email_pozdrav" => $this->texty_presentera->translate('email_pozdrav'),
        "nazov"     => $this->texty_presentera->translate('register_aktivacia'),
        "odkaz" 		=> 'http://'.$this->nazov_stranky.$this->link("User:activateUser", $uloz_user_main['id'], $new_password_key),
      ];
      try {
        $this->myMailer->sendMail(1, $values->email, $this->texty_presentera->translate('register_aktivacia'), null, $params, __DIR__ . '/../templates/User/email_activate-html.latte');

        $this->user_main->find($uloz_user_main['id'])->update(['new_password_key'=>$new_password_key]);
        $this->flashMessage($this->texty_presentera->translate('register_email_ok'), 'success');
        $this->myMailer->sendAdminMail("Registrácia", "Registrácia užívateľa:".$uloz_user_main->meno." ". $uloz_user_main->priezvisko);
      } catch (Email\SendException $e) {
        $this->flashMessage($this->texty_presentera->translate('send_email_err').$e->getMessage(), 'danger,n');
      }
      $this->redirect('Homepage:');
    } else { $this->flashMessage($this->texty_presentera->translate('register_save_err'), 'danger');}	//Ulozenie sa nepodarilo
  }

  public function actionForgottenPassword(string $email = "") {
    $this["forgottenPasswordForm"]->setDefaults(["email"=>$email]);
  }

  /**
	 * Forgot password user form component factory.
	 * @return Nette\Application\UI\Form
	 */
	protected function createComponentForgottenPasswordForm() {
    $form = $this->forgottenPasswordForm->create($this->language);
    $form['uloz']->onClick[] = [$this, 'forgotPasswordFormSubmitted'];
		return $this->_vzhladForm($form, "noajax");
	}

  /** 
   * Spracovanie formulara zabudnuteho hesla
   * @param Nette\Application\UI\Form $button Data formulara */
  public function forgotPasswordFormSubmitted(Form $form, $values) {
		//Inicializacia
    $user_info = $this->user_main->findOneBy(['email'=>$values->email]);
 
    $new_password_key = Random::generate(25);
    if (isset($user_info->email) && $user_info->email == $values->email) { //Taky uzivatel existuje
      $params = [
        "site_name" => $this->nazov_stranky,
        "nadpis"    => sprintf($this->texty_presentera->translate('email_reset_nadpis'),$this->nazov_stranky),
        "email_reset_txt" => $this->texty_presentera->translate('email_reset_txt'),
        "email_nefunkcny_odkaz" => $this->texty_presentera->translate('email_nefunkcny_odkaz'),
        "email_pozdrav" => $this->texty_presentera->translate('email_pozdrav'),
        "nazov"     => $this->texty_presentera->translate('forgot_pass'),
        "odkaz" 		=> 'http://'.$this->nazov_stranky.$this->link("User:resetPassword", $user_info->id, $new_password_key),
      ];
      try {
        $this->myMailer->sendMail(1, $values->email, $this->texty_presentera->translate('forgot_pass'), null, $params, __DIR__ . '/../templates/User/forgot_password-html.latte');
        $user_forg = $this->user_main->find($user_info->id);
        $user_forg->update(['new_password_key'=>$new_password_key,
                            'new_password_requested'=>date("Y-m-d H:i:s", Time())
                          ]);
        $this->flashMessage($this->texty_presentera->translate('forgot_pass_email_ok'), 'success');
        $this->myMailer->sendAdminMail("Zabudnuté heslo", "Požiadavka na zabudnuté heslo užívateľa:".$user_forg->meno." ". $user_forg->priezvisko);
      } catch (Email\SendException $e) {
        $this->flashMessage($this->texty_presentera->translate('send_email_err').$e->getMessage(), 'danger,n');
      }
      $this->redirect('Homepage:');
    } else {													//Taky uzivatel neexzistuje
      $this->flashMessage(sprintf($this->texty_presentera->translate('forgot_pass_user_err'),$values->email), 'danger');
    }
  }

  /**
	 * Password reset form component factory.
	 * @return Nette\Application\UI\Form */
	protected function createComponentResetPasswordForm() {
    $form = $this->resetPasswordForm->create($this->language);  
    $form->onSuccess[] = function ($form) {
      $this->flashRedirect('User:', $this->texty_presentera->translate('reset_pass_ok'), 'success');
		};
		return $this->_vzhladForm($form);
	}

  /** 
   * Akcia pre vypnutie posialania noviniek
   * @param int $id_user_main
   * @param string $news_key */
  public function actionNewsUnsubscribe($id_user_main, $news_key) {
    $user_for_unsubscribe = $this->user_main->find($id_user_main);
    if ($user_for_unsubscribe !== FALSE && $user_for_unsubscribe->user_profiles->news_key == $news_key) {
      $user_for_unsubscribe->user_profiles->update(['news'=>"N", 'news_key'=>NULL]);
      $this->flashMessage(sprintf($this->texty_presentera->translate('unsubscribe_news_ok'), $user_for_unsubscribe->email), 'success');
      $this->myMailer->sendAdminMail("Zrušenie noviniek", "Odhlásenie z noviniek užívateľa:".$user_for_unsubscribe->meno." ". $user_for_unsubscribe->priezvisko);
    } else {
      $this->flashMessage($this->texty_presentera->translate('unsubscribe_news_err'), 'danger');
    }
    $this->redirect('Homepage:');
  }
}
