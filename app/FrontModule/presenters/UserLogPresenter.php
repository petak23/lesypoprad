<?php
namespace App\FrontModule\Presenters;

use Nette\Application\UI\Form;
use Nette\Utils\Image;
use Nette\Utils\Html;
use Nette\Utils\Random;
use Nette\Security\Passwords;
use Nette\Mail\Message;
use Nette\Mail\SendmailMailer;
use Latte;
use DbTable, Language_support;

/**
 * Prezenter pre spravu uzivatela po prihlásení.
 * (c) Ing. Peter VOJTECH ml.
 * Posledna zmena(last change): 06.06.2017
 *
 *	Modul: FRONT
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.3
 */
class UserLogPresenter extends \App\FrontModule\Presenters\BasePresenter {
  
  /** 
   * @inject
   * @var DbTable\User_main */
	public $user_main;
    /** 
   * @inject
   * @var DbTable\User_profiles */
	public $user_profiles;
  /**
   * @inject
   * @var Language_support\UserLog */
  public $texty_presentera;
  
  /** @var \Nette\Database\Table\ActiveRow|FALSE */
  private $uzivatel;
  /** @var array Nastavenie zobrazovania volitelnych poloziek */
  private $user_view_fields;

	protected function startup() {
    parent::startup();
    if ($this->action != 'activateNewEmail') {
      if (!$this->user->isLoggedIn()) { //Neprihlaseneho presmeruj
        $this->flashRedirect(['User:', ['backlink'=>$this->storeRequest()]], $this->trLang('base_nie_je_opravnenie1').'<br/>'.$this->trLang('base_prihlaste_sa'), 'danger,n');
      }
    }
    // Kontrola ACL
    if (!$this->user->isAllowed($this->name, $this->action)) {
      $this->flashRedirect('Homepage:', sprintf($this->trLang('base_nie_je_opravnenie'), $this->action), 'danger');
    }
    //Najdem aktualne prihlaseneho clena
    $this->uzivatel = $this->user_main->find($this->user->getIdentity()->getId());
    $this->user_view_fields = $this->nastavenie['user_view_fields'];
	}
  
  public function actionDefault() {
    $this["userEditForm"]->setDefaults($this->uzivatel);
  }
  
  public function renderDefault() {
    $this->template->uzivatel = $this->uzivatel;
    $this->template->h2 = $this->trLang('h2');
    $this->template->pass_change = $this->trLang('default_pass_change');
    $this->template->zdroj_na_zmazanie = $this->trLang('zdroj_na_zmazanie');
    $this->template->default_delete = $this->trLang('default_delete');
    $this->template->default_email_change = $this->trLang('default_email_change');
    $this->template->user_view_fields = $this->user_view_fields;
  }

  /**
	 * Edit user form component factory.
	 * @return Nette\Application\UI\Form
	 */
	protected function createComponentUserEditForm() {
		$form = new Form();
		$form->addProtection();
    $form->addHidden('id');$form->addHidden('id_user_profiles');
		$form->addText('meno', $this->trLang('UserEditForm_meno'), 0, 50)
				 ->addRule(Form::MIN_LENGTH, $this->trLang('UserEditForm_meno_ar'), 3)
				 ->setRequired($this->trLang('UserEditForm_meno_sr'));
    $form->addText('priezvisko', $this->trLang('UserEditForm_priezvisko'), 0, 50)
				 ->addRule(Form::MIN_LENGTH, $this->trLang('UserEditForm_priezvisko_ar'), 3)
				 ->setRequired($this->trLang('UserEditForm_priezvisko_sr'));
    $form->addText('email', $this->trLang('default_email').":", 0)->setDisabled(TRUE);
    if ($this->user_view_fields["rok"]) {
      $form->addText('rok', $this->trLang('UserEditForm_rok'), 0, 5)->setRequired(FALSE)
           ->addRule(Form::RANGE, $this->trLang('UserEditForm_rok_ar'), [1900, StrFTime("%Y", Time())]);
    }
    if ($this->user_view_fields["telefon"]) { $form->addText('telefon', $this->trLang('UserEditForm_telefon'), 0, 20); }
    if ($this->user_view_fields["poznamka"]) { $form->addText('poznamka', $this->trLang('UserEditForm_poznamka'), 0, 250); }
    if ($this->user_view_fields["pohl"]) {
      $form->addSelect('pohl', $this->trLang('UserEditForm_pohl'),
                     ['M'=>$this->trLang('UserEditForm_m'),'Z'=>$this->trLang('UserEditForm_z')]);
    }
    if ($this->nastavenie['send_e_mail_news']) {
      $form->addSelect('news', $this->trLang('UserEditForm_news'),
                       ['A'=>$this->trLang('UserEditForm_news_a'),'N'=>$this->trLang('UserEditForm_news_n')]);
    }
    if ($this->user_view_fields["avatar"]) {
      $src = ($this->uzivatel->user_profiles->avatar && is_file('www/'.$this->uzivatel->user_profiles->avatar)) ? $this->uzivatel->user_profiles->avatar : 'ikonky/64/figurky_64.png';
      $form->addUpload('avatar', $this->trLang('UserEditForm_avatar').":")
         ->setOption('description', Html::el('p')->setHtml(
              Html::el('img')->src($this->template->basePath.'/www/'.$src)->alt('avatar').
              " ".$this->trLang('default_avatar_txt')))
         ->addCondition(Form::FILLED)
            ->addRule(Form::IMAGE, $this->trLang('UserEditForm_avatar_oi'))
            ->addRule(Form::MAX_FILE_SIZE, $this->trLang('UserEditForm_avatar_ar'), 300 * 1024 /* v bytech */);
    }
		$form->addSubmit('uloz', $this->trLang('base_save'))
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'userEditFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')->setAttribute('class', 'btn btn-default')
         ->setValidationScope([])
         ->onClick[] = function () { $this->redirect('UserLog:'); };
		return $this->_vzhladForm($form);
	}
  
  public function userEditFormSubmitted($button) {
		$values = $button->getForm()->getValues(TRUE); 	//Nacitanie hodnot formulara
		$id = $values['id']; // Ak je == 0 tak sa pridava

    $values['modified'] = StrFTime("%Y-%m-%d %H:%M:%S", Time());
    $user_profiles_data =[
      'rok' => $this->user_view_fields["rok"] ? $values["rok"] : NULL,
      'telefon'=> $this->user_view_fields["telefon"] ? $values["telefon"] : NULL,
      'poznamka'=> $this->user_view_fields["poznamka"] ? $values["poznamka"] : NULL,
      'pohl'=> $this->user_view_fields["pohl"] ? $values["pohl"] : 'M',
      'news'=> $this->nastavenie['send_e_mail_news'] ? $values["news"] : 'A',
    ];
    unset($values["rok"], $values["telefon"], $values["poznamka"], $values["pohl"], $values["news"]);
    if (isset($values['avatar']) && $values['avatar'] && $values['avatar']->name != "") {
      if ($values['avatar']->isImage()){
        $avatar_path = "files/".$id."/";
        $path = $this->context->parameters['wwwDir']."/www/".$avatar_path;
        $pi = pathinfo($values['avatar']->getSanitizedName());
        $ext = $pi['extension'];
        if (is_dir($path)) {
          foreach (glob("$path*.{jpg,jpeg,gif,png}", GLOB_BRACE) as $file) {
            @unlink($file);
          }
        }	else { mkdir($path, 0777); }
        $avatar_name = Random::generate(25).".".$ext;
        $values['avatar']->move($path.$avatar_name);
        $image = Image::fromFile($path.$avatar_name);
        $image->resize(75, 75, Image::SHRINK_ONLY);
        $image->save($path.$avatar_name, 90);
        $this->user_profiles->uloz(array_merge($user_profiles_data, ['avatar'=>$avatar_path.$avatar_name]), $values['id_user_profiles']);
      } else {
        $this->flashMessage($this->trLang('user_edit_avatar_err'), 'danger');
      }
    }
    unset($values['id'], $values['avatar']);
    $uloz = $this->user_main->uloz($values, $id);
    if (isset($uloz['id'])) { //Ulozenie v poriadku
      $this->flashRedirect('UserLog:', $this->trLang('user_edit_save_ok'),'success');
    } else {													//Ulozenie sa nepodarilo
      $this->flashMessage($this->trLang('user_edit_save_err'), 'danger');
    }
  }

  public function actionMailChange() {
    $this->template->h2 = sprintf($this->trLang('mail_change_h2'),$this->uzivatel->meno, $this->uzivatel->priezvisko);
    $this->template->email = sprintf($this->trLang('mail_change_txt'),$this->uzivatel->email);
	}

	/**
	 * Mail change component factory.
	 * @return Nette\Application\UI\Form
	 */
	protected function createComponentMailChangeForm() {
		$form = new Form();
		$form->addProtection();
    $form->addHidden('id', $this->uzivatel->id);
		$form->addPassword('heslo', $this->trLang('MailChangeForm_heslo'), 50, 80)
				 ->setRequired($this->trLang('MailChangeForm_heslo_sr'));
    $form->addText('email', $this->trLang('MailChangeForm_new_email'), 50, 80)
				 ->addRule(Form::EMAIL, $this->trLang('MailChangeForm_new_email_ar'))
				 ->setRequired($this->trLang('MailChangeForm_new_email_sr'));
    $form->addSubmit('uloz', $this->trLang('base_save'))
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'userMailChangeFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')
         ->setAttribute('class', 'btn btn-default')
         ->setValidationScope([])
         ->onClick[] = function () { $this->redirect('UserLog:');};
		return $this->_vzhladForm($form);
	}

	public function userMailChangeFormSubmitted($button) {
		$values = $button->getForm()->getValues(); 	//Nacitanie hodnot formulara
		if (!Passwords::verify($values->heslo, $this->uzivatel->password)) {
			$this->flashRedirect('this', $this->trLang('pass_incorect'), 'danger');
		}
    // Over, ci dany email uz existuje. Ak ano konaj.
    if ($this->user_main->testEmail($values->email)) {
      $this->flashMessage(sprintf($this->trLang('mail_change_email_duble'), $values->email), 'danger');
      return;
    }
    //Vygeneruj kluc pre zmenu e-mailu
    $email_key = Random::generate(25);//$this->hasser->HashPassword($values->email.StrFTime("%Y-%m-%d %H:%M:%S", Time()));
    $uzivatel = $this->user_main->find(1); //Najdenie odosielatela emailu
    $templ = new Latte\Engine;
    $params = [
      "site_name" => $this->nazov_stranky,
      "nadpis"    => sprintf($this->trLang('email_change_mail_nadpis'),$this->nazov_stranky),
      "email_change_mail_txt" => sprintf($this->trLang('email_change_mail_txt'),$this->nazov_stranky),
      "email_change_mail_txt1" => $this->trLang('email_change_mail_txt1'),
      "email_nefunkcny_odkaz" => $this->trLang('email_nefunkcny_odkaz'),
      "email_pozdrav" => $this->trLang('email_pozdrav'),
      "nazov"     => $this->trLang('mail_change'),
      "odkaz" 		=> 'http://'.$this->nazov_stranky.$this->link("UserLog:activateNewEmail", $this->uzivatel->id, $email_key),
    ];
    $mail = new Message;
    $mail->setFrom($this->nazov_stranky.' <'.$uzivatel->email.'>')
         ->addTo($values->email)
         ->setSubject($this->trLang('mail_change'))
         ->setHtmlBody($templ->renderToString(__DIR__ . '/templates/UserLog/email_change-html.latte', $params));
    try {
      $sendmail = new SendmailMailer;
      $sendmail->send($mail);
      $this->uzivatel->update(['new_email'=>$values->email, 'new_email_key'=>$email_key]);
      $this->flashRedirect('UserLog:', $this->trLang('mail_change_send_ok'), 'success');
    } catch (Exception $e) {
      $this->flashMessage($this->trLang('mail_change_send_err').$e->getMessage(), 'danger');
    } 
	}

  public function actionActivateNewEmail($id, $new_email_key) {
    $user_main_data = $this->user_main->find($id);
    if ($new_email_key == $user_main_data->new_email_key){ //Aktivacia prebeha v poriadku
      try {
        $this->user_main->uloz(['email'=>$user_main_data->new_email,
                                'new_email'=>NULL,
                                'new_email_key'=>NULL], $user_main_data->id);
        $this->flashMessage($this->trLang('activate_mail_ok').($this->user->isLoggedIn() ? '' : $this->trLang('activate_mail_login')), 'success');
      } catch (Exception $e) {
        $this->flashMessage($this->trLang('activate_mail_err').$e->getMessage(), 'danger,n');
      }
    } else { $this->flashMessage($this->trLang('activate_mail_err1'), 'danger'); } 	//Neuspesna aktivacia
    $this->redirect('Homepage:');
  }

  public function actionPasswordChange() {
    $this->template->h2 = sprintf($this->trLang('pass_change_h2'),$this->uzivatel->meno,$this->uzivatel->priezvisko);
	}

	/**
	 * Password change form component factory.
	 * @return Nette\Application\UI\Form
	 */
	protected function createComponentPasswordChangeForm() {
		$form = new Form();
		$form->addProtection();
    $form->addHidden('id', $this->uzivatel->id);
		$form->addPassword('heslo', $this->trLang('PasswordChangeForm_heslo'), 50, 80)
				 ->setRequired($this->trLang('PasswordChangeForm_heslo_sr'));
    $form->addPassword('new_heslo', $this->trLang('PasswordChangeForm_new_heslo'), 50, 80)
         ->addRule(Form::MIN_LENGTH, $this->trLang('PasswordChangeForm_new_heslo_ar'), 3)
				 ->setRequired($this->trLang('PasswordChangeForm_new_heslo_sr'));
		$form->addPassword('new_heslo2', $this->trLang('PasswordChangeForm_new_heslo2'), 50, 80)
         ->addRule(Form::EQUAL, $this->trLang('PasswordChangeForm_new_heslo2_ar'), $form['new_heslo'])
				 ->setRequired($this->trLang('PasswordChangeForm_new_heslo2_sr'));
    $form->addSubmit('uloz', $this->trLang('base_save'))
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'userPasswordChangeFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')
         ->setAttribute('class', 'btn btn-default')
         ->setValidationScope([])
         ->onClick[] = function () { $this->redirect('UserLog:');};
		return $this->_vzhladForm($form);
	}

	public function userPasswordChangeFormSubmitted($button) {
		$values = $button->getForm()->getValues(); 	//Nacitanie hodnot formulara
		if ($values->new_heslo != $values->new_heslo2) {
			$this->flashRedirect('this', $this->trLang('PasswordChangeForm_new_heslo2_ar'), 'danger');
		}
		if (!Passwords::verify($values->heslo, $this->uzivatel->password)) {
			$this->flashRedirect('this', $this->trLang('pass_incorect'), 'danger');
		}
		//Vygeneruj kluc pre zmenu hesla
		$new_password = Passwords::hash($values->new_heslo);
    unset($values->new_heslo, $values->new_heslo2);
    try {
      $this->uzivatel->update(['password'=>$new_password]);
			$this->flashMessage($this->trLang('pass_change_ok'), 'success');
		} catch (Exception $e) {
			$this->flashMessage($this->trLang('pass_change_err').$e->getMessage(), 'danger,n');
		}
    $this->redirect('UserLog:');
	}
  
  /*********** signal processing ***********/
	function confirmedDelete($id, $nazov) {
    if (!$this->user_view_fields['delete']) {
      $this->flashRedirect("User:", $this->trLang('base_nie_je_opravnenie1'), "danger");
      return;
    }
		$path = $this->context->parameters['wwwDir'] . "/files/".$id;
    if (is_dir($path)) { //Vymazanie adresaru s avatarom
      foreach (glob("$path*.{jpg,jpeg,gif,png}", GLOB_BRACE) as $file) {
        @unlink($file);
      }
      rmdir($path);
    }
    $uzivatel_id_up = $this->user_profiles->findOneBy(['id_user_main'=>$id])->id;
    try {
      $this->getUser()->logout();
      $this->user_profiles->delUser($uzivatel_id_up);
      $this->user_main->oprav($uzivatel_id_up, ['id_user_profiles'=>1]);
      $this->user_profiles->zmaz($uzivatel_id_up);
      $this->user_main->zmaz($id);
      
      $this->flashMessage(sprintf($this->trLang('delete_user_ok'),$nazov), 'success');
      
		} catch (Exception $e) {
			$this->flashMessage($this->trLang('delete_user_err').$e->getMessage(), 'danger');
		}
    if (!$this->isAjax()) { $this->redirect('User:'); }
	}
}
