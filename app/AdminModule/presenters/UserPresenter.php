<?php

namespace App\AdminModule\Presenters;

use DbTable;

/**
 * Prezenter pre spravu uzivatela.
 * 
 * Posledna zmena(last change): 18.02.2022
 *
 *	Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.2
 */
class UserPresenter extends BasePresenter {
  // --- Models ---
  /** @var DbTable\User_main @inject */
	public $user_main;
  /** @var DbTable\User_categories @inject */
	public $user_categories;
  /** @var DbTable\User_in_categories @inject */
	public $user_in_categories;
  /** @var DbTable\User_profiles @inject */
	public $user_profiles;
  
  // --- Forms ---
  /** @var Forms\User\AddUserFormFactory @inject*/
	public $addUserForm;
  /** @var Forms\User\EditUserMainFormFactory @inject*/
	public $editUserMainForm;
  /** @var Forms\User\EditUserProfilesFormFactory @inject*/
	public $editUserProfilesForm;
  /** @var Forms\User\EditCategoriFormFactory @inject*/
	public $editCategoriForm;

  /** @var Nette\Database\Table\ActiveRow Udaje konkretneho clena*/
  private $clen;
  /** @var array Nastavenie zobrazovania volitelnych poloziek */
  private $user_view_fields;

  protected function startup() {
    parent::startup();
    $this->user_view_fields = $this->nastavenie['user_view_fields'];
    $this->template->user_view_fields = $this->user_view_fields;
	}
  
  /** Render pre default-nu akciu */
  public function renderDefault() {
		$this->template->poc_pr_udaje = $this->user_profiles->getPocetPr();		//Zistenie max a sum prihlásenia
		$this->template->clenovia = $this->user_main->findAll()->order('id ASC');
	}

  /** 
   * Akcia pre editaciu clena
   * @param int $id Id editovaneho clena */
  public function actionEdit($id) {
    if (($this->clen = $this->user_main->find($id)) === FALSE) {
			$this->setView('notFound');
		} else {
      $this["editUserMainForm"]->setDefaults($this->clen);
      $this["editUserProfilesForm"]->setDefaults($this->clen->user_profiles);
    }
	}
  
  /**
   * Edit user form component factory. Tovarnicka na formular pre editaciu clena
   * @return \Nette\Application\UI\Form */
	protected function createComponentEditUserMainForm() {
    $form = $this->editUserMainForm->create();
    $form['uloz']->onClick[] = function ($button) { 
      $this->flashOut(!count($button->getForm()->errors), 'User:', 'Údaje boli uložené!', 'Došlo k chybe a údaje sa neuložili. Skúste neskôr znovu...');
		};
    $form['cancel']->onClick[] = function () {
			$this->redirect('User:');
		};
		return $this->_vzhladForm($form);
	}
  
  /**
   * Edit user form component factory. Tovarnicka na formular pre editaciu clena
   * @return \Nette\Application\UI\Form */
	protected function createComponentEditUserProfilesForm() {
    $form = $this->editUserProfilesForm->create($this->user_view_fields);
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

  public function beforeRender()  {
    parent::beforeRender;
    $this->template->addFilter('clenclass', function ($pocet, $max) {
    	$pok=100*$pocet/$max;
      return "vyb".($pok>70 ? 1 : ($pok>45 ? 2 : ($pok>30 ? 3 : ($pok>0 ? 4 : 5))));
    });
    return $template;
	}
  
    /** Funkcia pre spracovanie signálu vymazavania
	  * @param int $id - id polozky v hlavnom menu
		* @param string $nazov - nazov polozky z hl. menu - na zrusenie?
		* @param string $druh - blizsia specifikacia, kde je to potrebne
		*/
	function confirmedDelete($id, $nazov, $druh = "")	{
    if ($druh === "admin") { 
      $path = $this->context->parameters["wwwDir"] . "/www/files/".$id;
      if (is_dir($path)) { //Vymazanie adresaru s avatarom
        foreach (glob("$path*.{jpg,jpeg,gif,png}", GLOB_BRACE) as $file) {
          @unlink($file);
        }
        rmdir($path);
      }
      $clen =$this->user_main->find($id);
      $clen_id_user_profiles = $clen->id_user_profiles;
      $meno = $clen->meno." ".$clen->priezvisko;
      try {
        $this->user_main->oprav($id, ['id_user_profiles'=>NULL]);
        $this->user_profiles->delUser($clen_id_user_profiles);
        $this->user_main->zmaz($id);
        $this->flashMessage('Užívateľ '.$meno.' bol zmazaný!', 'success');
      } catch (Exception $e) {
        $this->flashMessage('Došlo k chybe pri vymazávaní. Skúste neskôr znovu...'.$e->getMessage(), 'danger');
      }
      if (!$this->isAjax()) { $this->redirect('User:'); }
    } elseif ($druh === "categori") {
      try {
        $this->user_categories->zmaz($id);
        $this->flashMessage('Kategória bola zmazaná!', 'success');
      } catch (Exception $e) {
        $this->flashMessage('Došlo k chybe pri vymazávaní. Skúste neskôr znovu...'.$e->getMessage(), 'danger');
      }
      if (!$this->isAjax()) { $this->redirect('User:categories'); }
    }
  }
}