<?php
namespace App\AdminModule\Components\Article\TitleImage;

use Nette;
use DbTable;

/**
 * Komponenta pre titulku polozky(titulny obrazok a nadpis).
 * 
 * Posledna zmena(last change): 29.05.2017
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.2
 */

class TitleImageControl extends Nette\Application\UI\Control {

  /** @var Nette\Database\Table\ActiveRow $clanok Info o clanku */
  private $clanok;
  /** @var string $avatar_path */
  private $avatar_path;
  /** @var string $www_dir */
  private $www_dir;
  /** @var array */
  private $admin_links;
  /** @var Nette\Security\User */
  private $user;
  /** @var DbTable\Hlavne_menu */
  private $hlavne_menu;
  
  /** @var EditTitleImageFormFactory */
	public $editTitleImage;

  /**
   * @param DbTable\Hlavne_menu_lang $hlavne_menu_lang
   * @param EditTitleImageFormFactory $editTitleImageFormFactory */
  public function __construct(EditTitleImageFormFactory $editTitleImageFormFactory, Nette\Security\User $user, DbTable\Hlavne_menu $hlavne_menu) {
    parent::__construct();
    $this->editTitleImage = $editTitleImageFormFactory;
    $this->user = $user;
    $this->hlavne_menu = $hlavne_menu;
  }
  
  /** Nastavenie komponenty
   * @param Nette\Database\Table\ActiveRow $clanok
   * @param string $avatar_path
   * @return \App\AdminModule\Components\Article\TitleArticleControl */
  public function setTitle(Nette\Database\Table\ActiveRow $clanok, $avatar_path, $www_dir, $name) {
    $this->clanok = $clanok;
    $this->avatar_path = $avatar_path;
    $this->www_dir = $www_dir;
    
    $hlm = $this->clanok->hlavne_menu; // Pre skratenie zapisu
    $vlastnik = $this->user->isInRole('admin') ? TRUE : $this->user->getIdentity()->id == $hlm->id_user_main;//$this->vlastnik($hlm->id_user_main);
    // Test opravnenia na pridanie podclanku: Si admin? Ak nie, si vlastnik? Ak nie, povolil vlastnik pridanie, editaciu? A mám dostatocne id reistracie?
    $opravnenie_add = $vlastnik ? TRUE : (boolean)($hlm->povol_pridanie & 1);
    $opravnenie_edit = $vlastnik ? TRUE : (boolean)($hlm->povol_pridanie & 2);
    $opravnenie_del = $vlastnik ? TRUE : (boolean)($hlm->povol_pridanie & 4);
    // Test pre pridanie a odkaz: 0 - nemám oprávnenie; 1 - odkaz bude na addpol; 2 - odkaz bude na Clanky:add
    $druh_opravnenia = $opravnenie_add ? ($this->user->isAllowed($name, 'addpol') ? 1 : $this->user->isAllowed($this->name, 'add') ? 2 : 0) : 0;
    $this->admin_links = [
      "alink" => ["druh_opravnenia" => $druh_opravnenia,
                  "link"    => $druh_opravnenia ? ($druh_opravnenia == 1 ? ['main'=>$this->presenter->name.':addpol']
                                                                         : ['main'=>'Clanky:add', 'uroven'=>$hlm->uroven+1]) : NULL,
                  "text"    => "Pridaj podčlánok"
                 ],
      "elink" => $opravnenie_edit && $this->user->isAllowed($name, 'edit'),
      "dlink" => $opravnenie_del && $this->user->isAllowed($name, 'del') && !$this->hlavne_menu->maPodradenu($this->clanok->id_hlavne_menu),
      "vlastnik" => $vlastnik,
    ];
    return $this;
  }
  
  /** 
   * Render 
   * @param array $params Parametre komponenty - [admin_links, komentare, aktualny_projekt_enabled, zobraz_anotaciu]*/
	public function render() {
    $this->template->setFile(__DIR__ . '/TitleImage.latte');
    $this->template->clanok = $this->clanok;
    $this->template->admin_links = $this->admin_links;
		$this->template->render();
	}
  
  /** 
   * Komponenta formulara pre zmenu vlastnika.
   * @return Nette\Application\UI\Form */
  public function createComponentEditTitleImageForm() {
    $form = $this->editTitleImage->create($this->avatar_path, $this->www_dir);
    $form->setDefaults(["id" => $this->clanok->id_hlavne_menu,
                        "old_avatar" => $this->clanok->hlavne_menu->avatar]);
    $form['uloz']->onClick[] = function ($button) { 
      $this->presenter->flashOut(!count($button->getForm()->errors), 'this', 'Zmena bola úspešne uložená!', 'Došlo k chybe a zmena sa neuložila. Skúste neskôr znovu...');
		};
    return $this->presenter->_vzhladForm($form);
  }
}

interface ITitleImageControl {
  /** @return TitleImageControl */
  function create();
}