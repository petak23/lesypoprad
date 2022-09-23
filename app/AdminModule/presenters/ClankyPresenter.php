<?php

namespace App\AdminModule\Presenters;

use App\AdminModule\Components;
use DbTable;
use Nette\Application\UI\Form;

/**
 * Prezenter pre spravu clankov.
 * 
 * Posledna zmena(last change): 16.06.2022
 *
 *	Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.4.1
 */

class ClankyPresenter extends ArticlePresenter
{

  // -- Komponenty
  /** @var Components\Clanky\IZobrazClanokAControl @inject */
  public $zobrazClanokControlFactory;

  /** @var string */
  protected $nadpis_h2 = "";

  /** @persistent */
  public $tabs_clanky = 'prilohy-tab';

  /** Vychodzie nastavenia */
  protected function startup()
  {
    parent::startup();
    $this->template->jazyky = $this->lang->findAll();
  }

  /** Render pre defaultnu akciu */
  public function renderDefault()
  {
    parent::renderDefault();
    //Kontrola jedinecnych komponent. Ak uz su priradene tak sa vypustia
    $this->template->zoznam_komponent = $this->clanok_komponenty->testJedinecnosti($this->nastavenie["komponenty"], $this->zobraz_clanok->id_hlavne_menu);
    $this->template->tabs = isset($this->params["tab"]) ? $this->params["tab"] : "prilohy-tab";
  }

  /** 
   * Akcia pre 1. krok pridania clanku - udaje pre hl. menu.
   * @param int $id - id nadradenej polozky
   * @param int $uroven - uroven menu */
  public function actionAdd(int $id, int $uroven)
  {
    $this->menuformuloz = ["text" => "Ulož základ a pokračuj na texty >>", "redirect" => "Clanky:edit2"];
    parent::actionAdd($id, $uroven);
  }

  /** 
   * Akcia pre 1. krok editovania clanku - udaje pre hl. menu.
   * @param int $id - id editovanej polozky */
  public function actionEdit(int $id)
  {
    $this->menuformuloz = ["text" => "Ulož", "redirect" => "Clanky:default"];
    parent::actionEdit($id);
  }

  /** 
   * Akcia pre 2. krok editovania clanku - udaje pre clanok.
   * @param int $id - id editovaneho clanku v hl. menu */
  public function actionEdit2(int $id)
  {
    //Najdi pozadovany clanok
    try {
      $this->zobraz_clanok = $this->hlavne_menu_lang->getOneArticleId($id, $this->language_id, $this->id_reg);
    } catch (DbTable\ArticleMainMenuException $th) {
      $this->setView("notFound");
      return;
    }

    $this->nadpis_h2 = 'Editácia textov k článku: ';
    $vychodzie = [];
    foreach ($this->jaz as $j) {
      $pom = $this->hlavne_menu_lang->findOneBy(["id_lang" => $j->id, "id_hlavne_menu" => $id]);
      $la = $j->skratka . "_";
      $vychodzie = array_merge($vychodzie, [ //Nastav vychodzie hodnoty
        $la . 'id'        => $pom->id, //hlavne_menu_lang -> id
        $la . 'text'      => $pom->text,
        $la . 'anotacia'  => $pom->anotacia,
      ]);
    }
    $this["clankyEditForm"]->setDefaults($vychodzie);
    $this->setView("krok2");
  }

  /** Render pre 2. krok editacie clanku. */
  public function renderKrok2()
  {
    $this->template->h2 = $this->nadpis_h2 . $this->zobraz_clanok->view_name;
  }

  /** 
   * Formular pre editaciu clanku.
   * @return Nette\Application\UI\Form */
  protected function createComponentClankyEditForm()
  {
    $form = new Form();
    $form->addProtection();
    $form->addGroup();
    $form->addGroup();
    foreach ($this->jaz as $j) {
      $form->addHidden($j->skratka . '_id'); // hlavne_menu_lang -> id
      if ($this->nastavenie['clanky']['zobraz_anotaciu']) {
        $form->addText($j->skratka . '_anotacia', 'Anotácia článku pre jazyk ' . $j->nazov . ':', 0, 255);
      }
      $form->addTextArea($j->skratka . '_text', 'Text článku pre jazyk ' . $j->nazov . ':')
        ->setHtmlAttribute('cols', 0)
        ->setHtmlAttribute('rows', 20)
        ->getControlPrototype()->class("texyla");
    }
    $form->addGroup();
    $form->addSubmit('uloz', 'Ulož článok')->setHtmlAttribute('class', 'btn btn-success');
    $form->onSuccess[] = [$this, 'clankyEditFormSubmitted'];
    $form = $this->_vzhladForm($form);
    $renderer = $form->getRenderer();
    $renderer->wrappers['pair']['.odd'] = 'r1';
    $renderer->wrappers['control']['container'] = 'div class="col-sm-12 control-field"';
    $renderer->wrappers['label']['container'] = 'div class="col-sm-12 control-label control-label-clanky"';
    return $form;
  }

  /** 
   * Spracovanie formulara pre editaciu clanku. */
  public function clankyEditFormSubmitted(Form $form, $values)
  {
    $this->hlavne_menu_lang->ulozTextClanku($values);
    $this->flashRedirect(['Clanky:default', $this->zobraz_clanok->id_hlavne_menu], 'Váš článok bol úspešne uložený!', 'success');
  }

  /** 
   * Komponenta pre ukazanie obsahu clanku.
   * @return \App\AdminModule\Components\Clanky\ZobrazClanokControl */
  public function createComponentZobrazClanok()
  {
    $zobrazClanok = $this->zobrazClanokControlFactory->create();
    $zobrazClanok->setZobraz($this->zobraz_clanok->id_hlavne_menu);
    return $zobrazClanok;
  }

  public function actionKonvertuj($id = 0)
  {
    $cl = $this->hlavne_menu_lang->findBy(['id_clanok_lang IS NOT NULL']);
    foreach ($cl as $c) {
      $c->update([
        'text' => $c->clanok_lang->text,
        'anotacia' => $c->clanok_lang->anotacia
      ]);
    }
    $this->flashRedirect("Homepage:", 'OK!', "success");
  }
}
