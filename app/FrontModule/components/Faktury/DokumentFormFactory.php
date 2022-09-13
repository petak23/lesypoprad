<?php

declare(strict_types=1);

namespace App\FrontModule\Components\Faktury;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Database;

/**
 * Formular a jeho spracovanie pre zmenu vlastnika polozky.
 * Posledna zmena 12.09.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.3
 */
class DokumentFormFactory {
  /** @var DbTable\Faktury */
	private $faktury;
  
  /** @var string */
  private $filesDir = 'files/dokumenty';
  
  /** @var string */
  private $wwwDir;
  
  /**
   * @param DbTable\Faktury $faktury */
  public function __construct(DbTable\Faktury $faktury) {
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
  public function create(int $id_hlavne_menu, int $id_user_main, int $upload_size, 
                         string $wwwDir = "", string $filesDir = "www/files/dokumenty"): Form  {
    $zmluvy = $id_hlavne_menu == 25 ? TRUE : FALSE;
    $this->wwwDir = $wwwDir;
    $this->filesDir = $filesDir;
		$form = new Form();
		$form->addProtection();
    $form->addHidden('id');
    $form->addHidden('id_hlavne_menu', $id_hlavne_menu);
    $form->addHidden('id_user_main', $id_user_main);
    $form->addText('cislo', 'Číslo:', 20, 20);
    $form->addText('subjekt', $zmluvy ? "Zmluvná strana:" : "Dodávateľ:", 50, 200);
    if ($zmluvy) {
      $form->addText('nazov', "Názov", 50, 50);
    } else {
      $form->addHidden('nazov', "");
    }
    $form->addText('predmet', 'Predmet', 50, 200);
    $form->addText('cena', $zmluvy ? "Cena vrátane DPH" : "Suma")
         ->addRule(Form::FLOAT, 'Cena musí byť číslo')
         ->setRequired(FALSE);
    $form->addDatePicker('datum_vystavenia', $zmluvy ? "Dátum uzatvorenia zmluvy" : "Dátum vystavenia");
    if ($zmluvy) { $form->addDatePicker('datum_ukoncenia', 'Dátum ukončenia zmluvy'); } 
    $form->addUpload('subor', 'Dokument')
				 ->setOption('description', sprintf('Max. veľkosť dokumentu v bytoch %s kB', $upload_size/1024))
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
  public function dokumentFormSubmitted(\Nette\Forms\Controls\SubmitButton $button) {
		$values = $button->getForm()->getValues(TRUE); 	//Nacitanie hodnot formulara
    try {
      if ($values['subor'] && $values['subor']->name != "") {
        $values['subor'] = $this->_uploadPriloha($values);
      } else { unset($values['subor']);}
      $id_polozky = isset($values['id']) && $values['id'] ? $values['id'] : 0;
      unset($values['id']);
      $this->faktury->uloz($values, $id_polozky);
		} catch (Database\DriverException $e) {
			$button->addError($e->getMessage());
		}
  }
  
  /**
   * Upload prilohy
   * @param \Nette\Http\FileUpload $values
   * @return array */
  private function _uploadPriloha(\Nette\Http\FileUpload $values): array {
    $pr = $this->faktury->find($values['id']);//Zmazanie starej prílohy
    if ($pr !== FALSE && is_file($this->filesDir."/".$pr->subor)) { unlink($this->wwwDir."/".$this->filesDir."/".$pr->subor);}
    $fileName = $values['subor']->getSanitizedName();
		$pi = pathinfo($fileName);
		$file = $pi['filename'];
		$ext = $pi['extension'];
		$additionalToken = 0;
		//Najdi meno suboru
		if (file_exists($this->filesDir.$fileName)) {
			do { $additionalToken++;
			} while (file_exists($this->filesDir.$file.$additionalToken.".".$ext));
    }
		$finalFileName = ($additionalToken == 0) ? $fileName : $file.$additionalToken.".". $ext;
		//Presun subor na finalne miesto a ak je to obrazok tak vytvor nahlad
		$values['subor']->move($this->wwwDir."/".$this->filesDir."/".$finalFileName);
    return $finalFileName;
  }
}
