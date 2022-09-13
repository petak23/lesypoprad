<?php
namespace App\AdminModule\Presenters;
use App\AdminModule\Forms\User;
use DbTable;
use Nette\Database\DriverException;

/**
 * Prezenter pre spravu uzivatela.
 * 
 * Posledna zmena(last change): 31.05.2022
 *
 *	Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.8
 */
class UserPresenter extends BasePresenter {
  
  // -- DB
  /** @var DbTable\User_main @inject */
	public $user_main;
  /** @var DbTable\User_categories @inject */
	public $user_categories;
  /** @var DbTable\User_in_categories @inject */
	public $user_in_categories;
  /** @var DbTable\User_profiles @inject */
	public $user_profiles;
  
  // -- Forms
  /** @var User\AddUserFormFactory @inject*/
	public $addUserForm;
  /** @var User\EditUserMainFormFactory @inject*/
	public $editUserMainForm;
  /** @var User\EditUserProfilesFormFactory @inject*/
	public $editUserProfilesForm;
  /** @var User\EditCategoriFormFactory @inject*/
	public $editCategoriForm;
  
  protected function startup() {
    parent::startup();
    // Nastavenie zobrazovania volitelnych poloziek 
    $this->template->user_view_fields = $this->nastavenie['user_view_fields'];
	}

  public function renderDefault(): void
  {
    $this->template->users_data = $this->user_main->findAll()->order('id ASC');
    $this->template->poc_pr_udaje = $this->user_profiles->getPocetPr();
    $this->template->dir_to_user = $this->nastavenie['dir_to_user'];
    $this->template->user_in_categories = $this->user_in_categories;
    $this->template->items_per_page = [1 => "10", 2 => "20", 3 => "50", -1 => "Všetky"];
  }

  /** 
   * Akcia pre editáciu užívateľa
   * @param int $id Id editovaného užívateľa */
  public function actionEdit(int $id): void {
    if (($user_e = $this->user_main->find($id)) === null) {
			$this->setView('notFound');
		} else {
      $this["editUserMainForm"]->setDefaults($user_e);
      $categori = $this->user_in_categories->findBy(['id_user_main'=> $id])->fetchPairs('id', 'id_user_categories');
      $this["editUserMainForm"]->setDefaults(['categori'=>$categori]);
      $this["editUserProfilesForm"]->setDefaults($user_e->user_profiles);
    }
	}
  
  /**
   * Formulár pre editáciu užívateľských dát
   * @return \Nette\Application\UI\Form */
	protected function createComponentEditUserMainForm() {
    $form = $this->editUserMainForm->create($this->nastavenie['user_view_fields']);
    $form['uloz']->onClick[] = function ($button) { 
      $this->flashOut(!count($button->getForm()->errors), 'User:', 'Údaje boli uložené!', 'Došlo k chybe a údaje sa neuložili. Skúste neskôr znovu...');
		};
    $form['cancel']->onClick[] = function () {
			$this->redirect('User:');
		};
		return $this->_vzhladForm($form);
	}
  
  /**
   * Formulár pre editáciu profilu užívateľa
   * @return \Nette\Application\UI\Form */
	protected function createComponentEditUserProfilesForm() {
    $form = $this->editUserProfilesForm->create($this->nastavenie['user_view_fields']);
    $form['uloz']->onClick[] = function ($button) { 
      $this->flashOut(!count($button->getForm()->errors), 'User:', 'Údaje boli uložené!', 'Došlo k chybe a údaje sa neuložili. Skúste neskôr znovu...');
		};
    $form['cancel']->onClick[] = function () {
			$this->redirect('User:');
		};
		return $this->_vzhladForm($form);
	}
  
  /** Formular pre pridanie uzivatela.
	 * @return Nette\Application\UI\Form
	 */
	protected function createComponentAddUserForm() {
    $form = $this->addUserForm->create();
    $form['uloz']->onClick[] = function ($button) { 
      $this->flashOut(!count($button->getForm()->errors), 'User:', 'Nový užívateľ bol uložený!', 'Došlo k chybe a údaje sa neuložili. Skúste neskôr znovu...');
		};
    $form['cancel']->onClick[] = function () {
			$this->redirect('User:');
		};
		return $this->_vzhladForm($form);
	}

  /** 
   * Funkcia pre spracovanie signálu vymazavania užívateľa
   * @param int $id Id užívateľa */
	function handleConfirmedDeleteUser(int $id)	{
    $path = $this->nastavenie["wwwDir"].$this->nastavenie["dir_to_user"].$id;
    try {
      if (is_dir($path)) { //Vymazanie adresaru s avatarom
        foreach (glob("$path*.{jpg,jpeg,gif,png}", GLOB_BRACE) as $file) {
          @unlink($file);
        }
        rmdir($path);
      }
      $user_d =$this->user_main->find($id);
      $meno = $user_d->meno." ".$user_d->priezvisko;
      $this->user_main->repair($id, ['id_user_profiles'=>1]);
      $this->user_profiles->delUser($user_d->id_user_profiles);
      $this->user_in_categories->findBy(['id_user_main'=>$id])->delete();
      $this->user_main->zmaz($id);
      $this->flashMessage('Užívateľ '.$meno.' bol zmazaný!', 'success');
    } catch (DriverException $e) {
      $this->flashMessage('Došlo k chybe pri vymazávaní. Skúste neskôr znovu...'.$e->getMessage(), 'danger');
    }
    if ($this->isAjax()) {
      $this->redrawControl();
      $this['usersGrid']->reload();
    } else {
      $this->redirect('User:');
    }
  }

  /* --------------------------------- KATEGORIE -------------------------------------------------------- */
  public function renderCategories() {
    $this->template->categories = $this->user_categories->findAll();
  }
  
  public function actionEditCategori($id = 0) {
    if ($id && ($categ = $this->user_categories->find($id)) === FALSE) {
			$this->setView('notFound');
		} elseif ($id) {
      $this["editCategoriForm"]->setDefaults($categ);
    }
  }
  
  /**
   * Edit categori form component factory. Tovarnicka na formular pre editaciu kategorie
   * @return \Nette\Application\UI\Form */
	protected function createComponentEditCategoriForm() {
    $form = $this->editCategoriForm->create();
    $form['uloz']->onClick[] = function ($button) { 
      $this->flashOut(!count($button->getForm()->errors), 'User:categories', 'Kategória bola uložená!', 'Došlo k chybe a kategória sa neuložila. Skúste neskôr znovu...');
		};
    $form['cancel']->onClick[] = function () {
			$this->redirect('User:categories');
		};
		return $this->_vzhladForm($form);
	}
  
  /** Funkcia pre spracovanie signálu vymazavania
	  * @param int $id - id polozky v hlavnom menu
		* @param string $nazov - nazov polozky z hl. menu - na zrusenie?
		* @param string $druh - blizsia specifikacia, kde je to potrebne
		*/
	function confirmedDelete($id, $nazov, $druh = "")	{
    if ($druh === "categori") {
      try {
        $this->user_categories->zmaz($id);
        $this->flashMessage('Kategória bola zmazaná!', 'success');
      } catch (DriverException $e) {
        $this->flashMessage('Došlo k chybe pri vymazávaní. Skúste neskôr znovu...'.$e->getMessage(), 'danger');
      }
      if (!$this->isAjax()) { $this->redirect('User:categories'); }
    }
  }
}