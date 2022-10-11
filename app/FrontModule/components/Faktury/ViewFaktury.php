<?php

namespace App\FrontModule\Components\Faktury;

use DbTable;
use Nette;
use Nette\Utils\Json;

/**
 * Komponenta pre zobrazenie casti faktur pre FRONT modul
 * 
 * Posledna zmena(last change): 20.09.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.5
 */
class ViewFakturyControl extends Nette\Application\UI\Control
{

  /** @var DbTable\Faktury */
  private $faktury;

  /** @var FakturyFormFactory */
  public $fakturyFormFactory;
  /** @var int */
  private $skupina;
  /** @var boolean */
  private $zmluvy = FALSE;
  /** @var Nette\Security\User */
  private $user;
  /** @var int Id dokumentu */
  private $id_dokument = 0;

  /** @var string */
  private $filesDir;
  /** @var string */
  private $wwwDir;

  public function __construct(string $wwwDir, string $filesDir, DbTable\Faktury $faktury, FakturyFormFactory $fakturyFormFactory, Nette\Security\User $user)
  {
    $this->wwwDir = $wwwDir;
    $this->filesDir = $filesDir;
    $this->faktury = $faktury;
    $this->fakturyFormFactory = $fakturyFormFactory;
    $this->user = $user;
  }

  /**
   * Nastavenie skupiny
   * @param int $skupina */
  public function setSkupina($skupina)
  {
    $this->skupina = $skupina;
    if ($this->skupina == 25) {
      $this->zmluvy = TRUE;
    }
  }

  /** 
   * Render 
   * @see Nette\Application\Control#render() */
  public function render()
  {
    $toIdDocument = explode("=", $this->presenter->httpRequest->getUrl()->query);
    if (isset($toIdDocument[1]) && $toIdDocument[0] == 'viewFaktury-id_dokument') {
      $this->id_dokument = $toIdDocument[1];
      $this->template->id_dokument = $this->id_dokument;
      $this["fakturyForm"]->setDefaults($this->faktury->find($this->id_dokument));
    }
    $this->template->setFile(__DIR__ . '/ViewFaktury.latte');
    $this->template->skupina = $this->skupina;
    $this->template->id_dokument = $this->id_dokument;
    $this->template->faktury = $this->faktury->findBy(['id_hlavne_menu' =>  $this->skupina])->order('datum_vystavenia DESC');
    $this->template->zmluvy = $this->zmluvy;
    $this->template->admin_links = Json::encode([
      /*"alink" => [
        "druh_opravnenia" => 2,
        "link"    => "",
        "text"    => "Pridaj"
      ],*/
      "alink" => $this->user->isAllowed('Front:Faktury', 'edit'),
      "elink" => $this->user->isAllowed('Front:Faktury', 'edit'),
      "dlink" => $this->user->isAllowed('Front:Faktury', 'del'),
      "vlastnik" => true
    ]);
    $this->template->render();
  }

  /* * Grid * /
  public function createComponentFakturyGrid($name) {
		$grid = new DataGrid($this, $name);
		$grid->setDataSource($this->faktury->findBy(['id_hlavne_menu'=>  $this->skupina])->order('datum_vystavenia DESC'));
		$grid->addColumnText('cislo', 'Číslo');
    if ($this->zmluvy) { 
      $grid->addColumnText('subjekt', "Zmluvná strana");
      $grid->addColumnText('nazov', 'Názov');
    }
    $grid->addColumnText('predmet', 'Predmet');
    if ($this->zmluvy) {
      $grid->addColumnNumber('cena', $this->zmluvy ? "Cena vrátane DPH" : "Suma")->setFormat(2,',','');
    }
    $grid->addColumnDateTime('datum_vystavenia', $this->zmluvy ? "Dátum uzatvorenia zmluvy" : "Dátum vystavenia");
    if ($this->zmluvy) { $grid->addColumnDateTime('datum_ukoncenia', 'Dátum ukončenia zmluvy');}
    $grid->addColumnLink('subor', 'Detail', 'dokumentOpen', 'subor', ['subor'])->setOpenInNewTab();
    if ($this->user->isAllowed('Front:Faktury', 'edit')) {
      $grid->addAction('id', 'Edit', 'Edit')->setIcon('pencil');
    }
    if ($this->user->isAllowed('Front:Faktury', 'del')) {
      $grid->addAction('delete', '', 'delete!')
      ->setIcon('trash')
      ->setTitle('Delete')
      ->setClass('btn btn-xs btn-danger')
      //->setConfirm('Naozaj chcete zmezať položku %s?', 'predmet')
      ;
    }
    //$grid->setTranslator($this->translator);
	}*/

  /**
   * Signál pre otvorenie položky
   * @param int $subor Id otváranej položky */
  public function handleDokumentOpen($subor)
  {
    $this->presenter->redirectUrl("http://" . $this->presenter->nazov_stranky . "/" . $this->wwwDir . "/" . $this->filesDir . $subor);
    exit;
  }

  /**
   * Signál pre editovanie položky
   * @param int $id Id editovanej položky */
  public function handleEdit($id)
  {
    $pr = $this->faktury->find($id);
    $this['fakturyForm']->setDefaults($pr);
    $this->redirect('this', ['id_dokument' => $id]);
  }

  /**
   * Signál pre mazanie položky
   * @param int $id Id mazanej položky */
  public function handleDelete(int $id): void
  {
    $pr = $this->faktury->find($id); //najdenie faktúry
    if ($pr !== null) {
      $vysledok = is_file($this->filesDir . $pr->subor) ? unlink($this->wwwDir . "/" . $this->filesDir . $pr->subor) : FALSE;
      if ($vysledok ? $pr->delete() : FALSE) {
        $this->flashMessage('Položka bola vymazaná!', 'success');
      } else {
        $this->flashMessage('Došlo k chybe a položka nebola vymazaná!', 'danger');
      }
    } else {
      $this->flashMessage('Došlo k chybe. Požadovaná položka sa nenašla a teda nebola vymazaná!', 'danger');
    }
    $this->redirect('this');
  }

  /** 
   * Komponenta formulara pre pridanie a editaciu dokumentu.
   * @return Nette\Application\UI\Form */
  public function createComponentFakturyForm()
  {
    $form = $this->fakturyFormFactory->create($this->skupina, $this->user->getId(), $this->presenter->upload_size);
    $form['uloz']->onClick[] = function ($form) {
      if (!count($form->errors)) $this->id_dokument = 0;
      $this->flashMessage('Zmena bola úspešne uložená!', 'success');
      $this->redirect('this');
    };
    $form['cancel']->onClick[] =  function () {
      $this->id_dokument = 0;
      $this->redirect('this');
    };
    return $this->presenter->_vzhladForm($form);
  }
}
