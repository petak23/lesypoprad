<?php
declare(strict_types=1);

namespace App\ApiModule\Presenters;

use App\AdminModule\Components\Menu;
use DbTable;
use Nette\Application\Responses\TextResponse;
use Texy;

/**
 * Prezenter pre pristup k api hlavneho menu a pridružených vecí ako je aj obsah článku.
 * Posledna zmena(last change): 10.05.2022
 *
 * Modul: API
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.6
 * 
 * @help 1.) https://forum.nette.org/cs/28370-data-z-post-request-body-reactjs-appka-se-po-ceste-do-php-ztrati
 */
class MenuPresenter extends BasePresenter {

  // -- DB
  /** @var DbTable\Admin_menu @inject */
  public $admin_menu;
  /** @var DbTable\Hlavne_menu_lang @inject */
	public $hlavne_menu_lang;

  /** @var Texy\Texy @inject */
	public $texy;

  /**
   * Vráti kompletné menu v json */
  public function actionGetMenu(): void { 
    $menu = new Menu\Menu;
    $menu->setNastavenie($this->nastavenie);
    $hl_m = $this->hlavne_menu->getMenuAdmin(1);
    if (count($hl_m)) {
      $servise = $this;
      $menu->fromTable($hl_m, function($node, $row) use($servise){
        foreach (["name", "tooltip", "avatar", "anotacia", "node_class", "id", "datum_platnosti"] as $v) { 
          $node->$v = $row['node']->$v; 
        }
        $node->link = is_array($row['node']->link) ? 
                      $servise->link(":Admin:".$row['node']->link[0], ["id"=>$row['node']->id]) : 
                      $servise->link(":Admin:".$row['node']->link);
        return $row['nadradena'] ? $row['nadradena'] : null;
      });
    }
    $this->sendJson($menu->getApiMenu());
  }

  /** 
   * Akcia vráti konkrétne submenu pre nadradenú položku
   * @param int $id Id nadradenej polozky
   * @param String $lmodule Modul, pre ktorý sa vatvárajú odkazy v submenu */
  public function actionGetSubmenu(int $id, String $lmodule = "Admin"): void {
    $tmp = $this->hlavne_menu_lang
                ->findBy(['hlavne_menu.id_nadradenej'=>$id, 'id_lang'=>1])
                ->order('poradie ASC');
    $out = [];
    foreach ($tmp as $v) {
      $p = $lmodule == "front" && $v->hlavne_menu->druh->presenter == "Menu" ? "Clanky" : $v->hlavne_menu->druh->presenter;
      $out[$v->hlavne_menu->poradie] = [
        'id'		=> $v->id_hlavne_menu,
        'order'	=> $v->hlavne_menu->poradie,
        'name'	=> $v->menu_name,
        'link'	=> $this->link(":".ucfirst($lmodule).":$p:", $v->id_hlavne_menu), 
        'avatar'=> $v->hlavne_menu->avatar,
        'node_class' => ($v->hlavne_menu->ikonka !== null && strlen($v->hlavne_menu->ikonka)>2) ? $v->hlavne_menu->ikonka : null,
        ];
    }
    $this->sendJson($out);
	}

  /**
   * Uloženie zmeny v poradí submenu */
  public function actionSaveOrderSubmenu(?int $id = null): void {
    $_post = json_decode(file_get_contents("php://input"), true); // @help 1.)

    $this->sendJson([
      'result' => $this->hlavne_menu->saveOrderSubmenu($_post['items']) ? 'OK' : 'ERR'
    ]);
  }

  /** Vráti administračné menu podľa úrovne registrácie */
  public function actionGetAdminMenu(): void {
    $am = $this->admin_menu->getAdminMenu($this->id_reg);
    
    foreach ($am as $k => $v) {
      $am[$k]['link'] = $this->link(':Admin:'.$v['link']);
    }
    
    $this->sendJson($am);
  }

  /** Vráti jednu položku hlavne_menu_lang */
  /*public function actionGetOneMenuArticle(?int $id = null): void {
    $tmp = $this->hlavne_menu_lang->getOneArticleId($id, 1, $this->id_reg);
    $this->sendJson($tmp->toArray());
  }*/

  /** Akcia uloží editovaný text článku */
  public function actionTexylaSave(int $id): void {
    $_post = json_decode(file_get_contents("php://input"), true); // @help 1.)
    
    $this->sendJson([
      'result' => $this->hlavne_menu_lang->saveText($id, $this->lang->getLngId($this->language), $_post['texy']) ? 'OK' : 'ERR'
    ]);
  }

  /** Vráti jednu položku hlavne_menu */
  public function actionGetOneHlavneMenuArticle(?int $id = null): void {
    $tmp = $this->hlavne_menu->findOneBy(['id' => $id, 'id_user_roles <='.$this->id_reg]);
    //dumpe($tmp->toArray());
    $this->sendJson($tmp->toArray());
  }

  /** Akcia uloží okrajové rámčeky pre položku */
  public function actionSaveBorder(int $id): void {
    $_post = json_decode(file_get_contents("php://input"), true); // @help 1.)

    $this->sendJson([
      'result' => $this->hlavne_menu->changeBorders($_post['borders'], $id)->toArray(),
    ]);
  }
}