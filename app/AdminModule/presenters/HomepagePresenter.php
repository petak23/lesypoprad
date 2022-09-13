<?php
namespace App\AdminModule\Presenters;
use DbTable;
/**
 * Domovský preseter administracie.
 *
 * Posledna zmena(last change): 18.05.2022
 *
 *	Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.8
 */
class HomepagePresenter extends BasePresenter {
  
  // -- DB
  /** @var DbTable\Hlavne_menu_cast @inject */
  public $hlavne_menu_cast;
  
  /** Vychodzi render  pre zobrazenie základného panela */
  public function renderDefault() {
    $this->template->parts = $this->hlavne_menu_cast->findAll();
    $this->template->useri = $this->user_main->getUser($this->user->id);
  }

  /** Pre zobrazenie článokv v časti menu 
   * @param int $id Id casti hlavneho menu ako zaporne cislo */
  public function renderSection(int $id = 0) {

    if ($id == 0) $this->redirect("Homepage:"); // Ak nie je id zadané
    
    $user = $this->user;
    $this->template->id_menu = -1*$id;
    $this->template->view_add_link = $user->isAllowed('Admin:Menu', 'addpol') && 
                                     ($user->isInRole("admin") ? TRUE :	$this->nastavenie['add_uroven0']) &&
                                     $this->id_reg >= $this->hlavne_menu_cast->find(-1*$id)->id_user_roles;
  }
}