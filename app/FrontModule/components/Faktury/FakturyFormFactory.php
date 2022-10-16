<?php

declare(strict_types=1);

namespace App\FrontModule\Components\Faktury;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Database;
use Nette\Utils;

/**
 * Formular a jeho spracovanie pre zmenu vlastnika polozky.
 * Posledna zmena 12.10.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.7
 */
class FakturyFormFactory
{
  /** @var DbTable\Faktury */
  private $faktury;

  /** @var string */
  private $filesDir;

  /** @var string */
  private $wwwDir;

  /**
   * @param DbTable\Faktury $faktury */
  public function __construct(string $wwwDir, string $filesDir, DbTable\Faktury $faktury)
  {
    $this->wwwDir = $wwwDir;
    $this->filesDir = $filesDir;
    $this->faktury = $faktury;
  }

  /**
   * Formular pre pridanie dokumentu.
   * @param int $id_hlavne_menu
   * @param int $id_user_main
   * @param int $upload_size
   * @param string $wwwDir
   * @param string $filesDir
   * @return Form */
  public function create(int $id_hlavne_menu, int $id_user_main, int $upload_size): Form
  {
    $zmluvy = $id_hlavne_menu == 25 ? true : false;
    $form = new Form();
    $form->addProtection();
    $form->addHidden('id')->setDefaultValue(0);
    $form->addHidden('id_hlavne_menu', $id_hlavne_menu);
    $form->addHidden('id_user_main', $id_user_main);
    $form->addText('cislo', 'Číslo:', 20, 20);
    $form->addText('subjekt', $zmluvy ? "Zmluvná strana:" : "Dodávateľ:", 50, 200);
    if ($zmluvy) {
      $form->addText('nazov', "Názov", 50, 50)
        ->setRequired('Názov musí byť zadaný');
    } else {
      $form->addHidden('nazov', "");
    }
    $form->addText('predmet', 'Predmet', 50, 200);
    $form->addText('cena', $zmluvy ? "Cena vrátane DPH" : "Suma")
      ->addRule(Form::FLOAT, 'Cena musí byť číslo')
      ->setRequired(FALSE);
    $form->addText('datum_vystavenia', $zmluvy ? "Dátum uzatvorenia zmluvy" : "Dátum vystavenia")
      ->setHtmlType('date');
    if ($zmluvy) {
      $form->addText('datum_ukoncenia', 'Dátum ukončenia zmluvy')->setHtmlType('date');
    }
    $form->addUpload('subor', 'Dokument')
      ->setOption('description', sprintf('Max. veľkosť dokumentu v bytoch %s kB', $upload_size / 1024))
      ->addCondition(Form::FILLED)
      ->addRule(Form::MAX_FILE_SIZE, 'Prekročená maximálna veľkosť dokumentu v bytoch %d B', $upload_size);
    $form->addSubmit('uloz', 'Ulož')
      ->setHtmlAttribute('class', 'btn btn-success')
      ->onClick[] = [$this, 'dokumentFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')
      ->setHtmlAttribute('class', 'btn btn-default')
      ->setHtmlAttribute('data-dismiss', 'modal')
      ->setHtmlAttribute('aria-label', 'Close')
      ->setValidationScope(null);
    return $form;
  }

  /** 
   * Spracovanie formulara pre zmenu vlastnika clanku.
   * @param \Nette\Forms\Controls\SubmitButton $button Data formulara */
  public function dokumentFormSubmitted(Form $form, $values): void
  {
    //dumpe($values);
    try {
      if ($values->subor->hasFile()) {
        $values->subor = $this->_uploadPriloha($values);
      } else {
        unset($values->subor);
      }
      $id_polozky = (int)$values->id ? (int)$values->id : 0;
      unset($values->id);
      $this->faktury->uloz($values, $id_polozky);
    } catch (Database\DriverException $e) {
      $form->addError($e->getMessage());
    }
  }

  /**
   * Upload prilohy
   * @param Utils\ArrayHash $values
   * @return array */
  private function _uploadPriloha(Utils\ArrayHash $values): string
  {
    $pr = $this->faktury->find((int)$values->id); //Zmazanie starej prílohy
    if ($pr !== null && is_file($this->filesDir . $pr->subor)) {
      unlink($this->wwwDir . "/" . $this->filesDir . $pr->subor);
    }
    $fileName = $values->subor->getSanitizedName();
    $pi = pathinfo($fileName);
    $file = $pi['filename'];
    $ext = $pi['extension'];
    $additionalToken = 0;
    //Najdi meno suboru
    if (file_exists($this->filesDir . $fileName)) {
      do {
        $additionalToken++;
      } while (file_exists($this->filesDir . $file . $additionalToken . "." . $ext));
    }
    $finalFileName = ($additionalToken == 0) ? $fileName : $file . $additionalToken . "." . $ext;
    //Presun subor na finalne miesto a ak je to obrazok tak vytvor nahlad
    $values->subor->move($this->wwwDir . "/" . $this->filesDir . $finalFileName);
    return $finalFileName;
  }
}
