<?php
namespace App\AdminModule\Components\Clanky\PrilohyClanok;

use Nette;
use Nette\Security\User;
use DbTable;

/**
 * Komponenta pre spravu priloh clanku.
 * 
 * Posledna zmena(last change): 01.06.2017
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.4
 */

class PrilohyClanokControl extends Nette\Application\UI\Control {

  /** @var DbTable\Dokumenty $clanok Info o clanku */
  public $dokumenty;
  /** @var string $nazov_stranky */
  private $nazov_stranky;
  /** @var Nette\Database\Table\ActiveRow $clanok Info o clanku */
  private $clanok;
  /** @var int */
  private $upload_size;
  /** @var string */
  private $prilohy_adresar;
  /** @var array */
  private $prilohy_images;
  /** &var EditPrilohyFormFactory */
  public $editPrilohyForm;
  /** @var array */
  private $admin_links;
  /** @var Nette\Security\User */
  private $user;
  /** @var DbTable\Hlavne_menu */
  private $hlavne_menu;

  /**
   * @param DbTable\Dokumenty $dokumenty
   * @param EditPrilohyFormFactory $editPrilohyFormFactory */
  public function __construct(DbTable\Dokumenty $dokumenty, EditPrilohyFormFactory $editPrilohyFormFactory, User $user, DbTable\Hlavne_menu $hlavne_menu) {
    parent::__construct();
    $this->dokumenty = $dokumenty;
    $this->editPrilohyForm = $editPrilohyFormFactory;
    $this->user = $user;
    $this->hlavne_menu = $hlavne_menu;
  }
  
  /** 
   * Nastavenie komponenty
   * @param Nette\Database\Table\ActiveRow $clanok
   * @param string $nazov_stranky
   * @param int $upload_size
   * @param string $prilohy_adresar
   * @param array $prilohy_images Nastavenie obrazkov pre prilohy
   * @return \App\AdminModule\Components\Clanky\PrilohyClanok\PrilohyClanokControl */
  public function setTitle(Nette\Database\Table\ActiveRow $clanok, $nazov_stranky, $upload_size, $prilohy_adresar, $prilohy_images, $name) {
    $this->clanok = $clanok;
    $this->nazov_stranky = $nazov_stranky;
    $this->upload_size = $upload_size;
    $this->prilohy_adresar = $prilohy_adresar;
    $this->prilohy_images = $prilohy_images;
    
    $hlm = $this->clanok->hlavne_menu; // Pre skratenie zapisu
    $vlastnik = $this->user->isInRole('admin') ? TRUE : $this->user->getIdentity()->id == $hlm->id_user_main;//$this->vlastnik($hlm->id_user_main);
    // Test opravnenia na pridanie podclanku: Si admin? Ak nie, si vlastnik? Ak nie, povolil vlastnik pridanie, editaciu? A mám dostatocne id reistracie?
    $opravnenie_add = $vlastnik ? TRUE : (boolean)($hlm->id_hlavne_menu_opravnenie & 1);
    $opravnenie_edit = $vlastnik ? TRUE : (boolean)($hlm->id_hlavne_menu_opravnenie & 2);
    $opravnenie_del = $vlastnik ? TRUE : (boolean)($hlm->id_hlavne_menu_opravnenie & 4);
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
   * Render */
	public function render() {
    $this->template->setFile(__DIR__ . '/PrilohyClanok.latte');
    $this->template->clanok = $this->clanok;
    $this->template->admin_links_prilohy = $this->admin_links;
    $this->template->dokumenty = $this->dokumenty->findBy(['id_hlavne_menu'=>$this->clanok->id_hlavne_menu]);
		$this->template->render();
	}
  
  /** 
   * Komponenta formulara pre pridanie a editaciu prílohy polozky.
   * @return Nette\Application\UI\Form */
  public function createComponentEditPrilohyForm() {
    $form = $this->editPrilohyForm->create($this->upload_size, $this->prilohy_adresar, $this->prilohy_images);
    $form->setDefaults(["id"=>0, "id_hlavne_menu"=>$this->clanok->id_hlavne_menu, "id_user_roles"=>$this->clanok->hlavne_menu->id_user_roles]);
    $form['uloz']->onClick[] = function ($button) { 
      $this->presenter->flashOut(!count($button->getForm()->errors), 'this', 'Príloha bola úspešne uložená!', 'Došlo k chybe a zmena sa neuložila. Skúste neskôr znovu...');
		};
    return $this->presenter->_vzhladForm($form);
  }
  
  public function handleEditPriloha($id) {
    $this->presenter->redirect('Dokumenty:edit', $id);
  }
  
  public function handleShowInText($id) {
    $priloha = $this->dokumenty->find($id);
    $priloha->update(['zobraz_v_texte'=>(1 - $priloha->zobraz_v_texte)]);
		if (!$this->presenter->isAjax()) {
      $this->redirect('this');
    } else {
      $this->redrawControl('prilohy');
    }
  }
}

interface IPrilohyClanokControl {
  /** @return PrilohyClanokControl */
  function create();
}