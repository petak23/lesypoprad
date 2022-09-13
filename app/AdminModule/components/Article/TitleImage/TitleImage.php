<?php
declare(strict_types=1);

namespace App\AdminModule\Components\Article\TitleImage;

use DbTable;
use Nette;
use PeterVojtech;

/**
 * Komponenta pre titulku polozky(titulny obrazok a nadpis).
 * 
 * Posledna zmena(last change): 13.03.2022
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.9
 */

class TitleImageControl extends Nette\Application\UI\Control {

  /** @var Nette\Database\Table\ActiveRow $clanok Info o clanku */
  private $clanok;
  /** @var string Cesta k adresaru pre ukladanie obrazkov menu od www adresara */
  private $dir_to_menu;
  /** @var string WWW adresar */
  private $www_dir;
  /** @var array */
  private $admin_links = ['edit'=>FALSE, 'dlink'=>FALSE, 'vlastnik'=>FALSE];
  /** @var Nette\Security\User */
  private $user;
  /** @var DbTable\Hlavne_menu */
  private $hlavne_menu;
  
  /** @var EditTitleImageFormFactory */
	public $editTitleImage;

  /**
   * @param string $dir_to_menu Cesta k adresaru pre ukladanie obrazkov menu od www adresara - Nastavenie priamo cez servises.neon
   * @param string $www_dir WWW adresar - Nastavenie priamo cez servises.neon
   * @param \App\AdminModule\Components\Article\TitleImage\EditTitleImageFormFactory $editTitleImageFormFactory
   * @param Nette\Security\User $user
   * @param DbTable\Hlavne_menu $hlavne_menu */
  public function __construct(string $dir_to_menu, 
                              string $www_dir,
                              EditTitleImageFormFactory $editTitleImageFormFactory, 
                              Nette\Security\User $user, 
                              DbTable\Hlavne_menu $hlavne_menu) {
    $this->editTitleImage = $editTitleImageFormFactory;
    $this->user = $user;
    $this->hlavne_menu = $hlavne_menu;
    $this->dir_to_menu = $dir_to_menu;
    $this->www_dir = $www_dir;
  }
  
  /** 
   * Nastavenie komponenty
   * @param Nette\Database\Table\ActiveRow $clanok
   * @param string $name
   * @return \App\AdminModule\Components\Article\TitleImage\TitleImageControl */
  public function setTitle(Nette\Database\Table\ActiveRow $clanok, string $name): TitleImageControl {
    $this->clanok = $clanok;
    //Test opravneni
    $hlm = $this->clanok->hlavne_menu; // Pre skratenie zapisu
    //Vlastnik je admin a autor clanku
    $vlastnik = $this->user->isInRole('admin') ? TRUE : $this->user->getIdentity()->id == $hlm->id_user_main;
    //Opravnenie mam ak som vlastnik alebo mi to vlastnik povolil
    $opravnenie = $vlastnik ? TRUE : (boolean)($hlm->id_hlavne_menu_opravnenie & 2);
    $this->admin_links = [
      "edit" => $opravnenie && $this->user->isAllowed($name, 'edit'),
      "del"  => $opravnenie && $this->user->isAllowed($name, 'del'),
      "vlastnik" => $vlastnik,
    ];
    return $this;
  }
  
  /** Render */
	public function render() {
    $this->template->setFile(__DIR__ . '/TitleImage.latte');
    $this->template->dir_to_menu = $this->dir_to_menu;
    $this->template->clanok = $this->clanok;
    $this->template->admin_links = $this->admin_links;
		$this->template->render();
	}
  
  /** 
   * Komponenta formulara pre zmenu vlastnika.
   * @return Nette\Application\UI\Form */
  public function createComponentEditTitleImageForm(): Nette\Application\UI\Form {
    $form = $this->editTitleImage->create();
    $form->setDefaults(["id" => $this->clanok->id_hlavne_menu,
                        "old_avatar" => $this->clanok->hlavne_menu->avatar,
                        "ikonka"=> $this->clanok->hlavne_menu->ikonka,
                       ]);
    $form['uloz']->onClick[] = function ($button) { 
      $this->presenter->flashOut(!count($button->getForm()->errors), 'this', 'Zmena bola úspešne uložená!', 'Došlo k chybe a zmena sa neuložila. Skúste neskôr znovu...');
		};
    return $this->presenter->_vzhladForm($form);
  }

  /**
   * Komponenta Confirmation Dialog pre delete News
   * @return Nette\Application\UI\Form */
  public function createComponentConfirmForm() {
    $form = new PeterVojtech\Confirm\ConfirmationDialog($this->presenter->getSession('news'));
    $form->addConfirmer(
        'delete', // názov signálu bude confirmDelete!
        [$this, 'confirmedDelete'], // callback na funkciu pri kliknutí na YES
        "Naozaj chceš zmazať titulný obrázok?"
    );
    return $form;
  }

  /** 
   * Funkcia pre spracovanie signálu vymazavania */
	function confirmedDelete(array $params)	{
		$uloz = $params['id'] > 0 ? $this->hlavne_menu->zmazTitleImage((int)$params['id'], $this->dir_to_menu, $this->www_dir) : false;
    $this->presenter->flashOut($uloz !== FALSE, 'this', 'Titulný obrázok bol vymazaný!', 'Došlo k chybe a titulný obrázok nebol vymazaný!');
  }
}

interface ITitleImageControl {
  /** @return TitleImageControl */
  function create();
}