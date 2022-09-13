<?php
declare(strict_types=1);

namespace App\FrontModule\Forms\UserLog;

use DbTable;
use Language_support;
use Nette;
use Nette\Application\UI\Form;
use Nette\Database\Table;
use Nette\Security;
use Nette\Utils;
use PeterVojtech\News_key;

/**
 * Formular editacie prihlaseneho uzivatela
 * Posledna zmena 12.03.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.9
 */
class UserEditFormFactory {
  /** @var Language_support\LanguageMain */
  private $texts;

  /** @var DbTable\User_profiles */
  public $user_profiles;
  
  /** @var DbTable\User_main */
  public $user_main;
  
  /** @var Nette\Security\User */
  public $user;
  
  /** @var string */
  private $wwwDir;
  /** @var string */
  private $dir_to_user;
  /** @var array */
  private $user_view_fields;
  /** @var String */
  private $dir_to_icons;
  /** @var bool */
  private $send_e_mail_news;

  /** @var string */
  private $avatar_path;
  
  /** @var Table\ActiveRow|FALSE */
  private $clen;
  /** @var News_key\NewsKeyControl */
  private $news_key;

  public function __construct(String $wwwDir,
                              String $dir_to_user,
                              array $user_view_fields,
                              String $dir_to_icons,
                              bool $send_e_mail_news,
                              Security\User $user, 
                              Language_support\LanguageMain $language_main, 
                              DbTable\User_profiles $user_profiles, 
                              DbTable\User_main $user_main,
                              News_key\NewsKeyControl $news_key) {
    $this->wwwDir = $wwwDir;
    $this->dir_to_user = $dir_to_user;
    $this->user_view_fields = $user_view_fields;
    $this->dir_to_icons = $dir_to_icons;
    $this->send_e_mail_news = $send_e_mail_news;
    $this->user = $user;
    $this->texts = $language_main;
    $this->user_profiles = $user_profiles;
    $this->user_main = $user_main;
    $this->news_key = $news_key;
	}

  /**
   * Formular pre editaciu prihlaseneho pouzivatela
   * @param string $basePath
   * @param Nette\Database\Table\ActiveRow $clen
   * @return Form  */
  public function create(string $basePath, string $language): Form  {
    $this->clen = $this->user_main->find($this->user->getIdentity()->id);
    $this->avatar_path = $this->dir_to_user.$this->user->getIdentity()->id."/";
    $this->texts->setLanguage($language);
    $form = new Form();
		$form->addProtection();
    $form->setTranslator($this->texts);
    $form->addHidden('id');
		$form->addText('meno', 'UserEditForm_meno', 30, 50)
				 ->addRule(Form::MIN_LENGTH, 'UserEditForm_meno_ar', 3)
				 ->setRequired('UserEditForm_meno_sr');
    $form->addText('priezvisko', 'UserEditForm_priezvisko', 30, 50)
				 ->addRule(Form::MIN_LENGTH, 'UserEditForm_priezvisko_ar', 3)
				 ->setRequired('UserEditForm_priezvisko_sr');
    $form->addText('email', 'default_email', 30)->setDisabled(TRUE);
    if ($this->user_view_fields["pohl"]) {
      $form->addSelect('pohl', 'UserEditForm_pohl',
                     ['M'=>'UserEditForm_m','Z'=>'UserEditForm_z']);
    }
    if ($this->send_e_mail_news) {
      $form->addSelect('news', 'UserEditForm_news',
                       ['A'=>'UserEditForm_news_a','N'=>'UserEditForm_news_n']);
    }
    if ($this->user_view_fields["avatar"]) {
      $user_avatar = $this->avatar_path.$this->clen->user_profiles->avatar;
      $form->addUpload('avatar', 'UserEditForm_avatar')
           ->setHtmlAttribute('accept', 'image/*')
           ->setOption('description', Utils\Html::el('p')->setHtml(
              Utils\Html::el('img')->src($basePath."/".(is_file($user_avatar) ? $user_avatar : $this->dir_to_icons."64/figurky_64.png"))->alt('avatar').
              "<br>".$this->texts->trText('default_avatar_txt')))
           ->addCondition(Form::FILLED)
            ->addRule(Form::IMAGE, 'UserEditForm_avatar_oi')
            ->addRule(Form::MAX_FILE_SIZE, 'UserEditForm_avatar_ar', 300 * 1024 /* v bytech */);
    }
		$form->addSubmit('uloz', 'base_save')
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'userEditFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')->setAttribute('class', 'btn btn-default')
         ->setValidationScope([]);
		return $form;
	}
  
  /** 
   * Spracovanie formulara */
	public function userEditFormSubmitted(Form $form, $values): void {
		$id = $values->id;
    $news = isset($values->news) ? $values->news : false;
    $pohl = isset($values->pohl) ? $values->pohl : null;
    try {
      if (isset($values->avatar) && $values->avatar != null) {
        $this->_saveAvatar($values->avatar, $id);
      }
      unset($values->id, $values->avatar, $values->news, $values->pohl);
      $this->user_main->uloz($values, $id);
      if ($pohl != null) $this->user_profiles->uloz(['pohl'=>$pohl], $this->user->getIdentity()->id_user_profiles); 
      if ($this->clen->user_profiles->news != $news) { //Ak doslo k zmene v posielani noviniek
        $this->news_key->Spracuj($news == "A", $id);
      } 
    } catch (Security\AuthenticationException $e) {
      $form->addError($e->getMessage());
    } catch (Utils\ImageException $e) {
      $form['avatar']->addError($e->getMessage());
      $form->addError();
    }
	}
  
  /**
   * Funkcia pre ulozenie avatara
   * @param Nette\Http\FileUpload $avatar
   * @param string $id
   * @throws Utils\ImageException */
  protected function _saveAvatar(Nette\Http\FileUpload $avatar, string $id) {
    if ($avatar->hasFile()) {
      if ($avatar->isImage()){
        $avatar_path = "files/".$id."/";
        $path = $this->wwwDir."/".$avatar_path;
        $pi = pathinfo($avatar->getSanitizedName());
        $ext = $pi['extension'];
        $this->_delUserImages($path);
        $avatar_name = Utils\Random::generate(25).".".$ext;
        $avatar->move($path.$avatar_name);
        $image = Utils\Image::fromFile($path.$avatar_name);
        $image->resize(75, 75, Utils\Image::SHRINK_ONLY);
        $image->save($path.$avatar_name, 90);
        $this->user_profiles->oprav($id, ['avatar'=>$avatar_name]);
      } else {
        throw new Utils\ImageException('user_edit_avatar_err');
      }
    }
  }
  
  /**
   * Zmazanie uzivatelskych avatarov|vytvorenie uzivatelskeho priecinka
   * @param string $path */
  private function _delUserImages(string $path) {
    if (is_dir($path)) {
      foreach (glob("$path*.{jpg,jpeg,gif,png}", GLOB_BRACE) as $file) {
        @unlink($file);
      }
    }	else { mkdir($path, 0777); }
  } 
}