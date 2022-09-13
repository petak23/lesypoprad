<?php
declare(strict_types=1);

namespace App\AdminModule\Components\Clanky\PrilohyClanok;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Database;
use Nette\Security\User;
use Nette\Utils\Image;
use Nette\Utils\Strings;

/**
 * Formular a jeho spracovanie pre pridanie a editaciu prilohy polozky.
 * Posledna zmena 20.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.1.7
 */
class EditPrilohyFormFactory {
  
  /**
   * Formular pre pridanie prilohy a editaciu polozky.
   * @return Form  */
  public function create(int $id_hlavne_menu, String $basePath): Form  {
    //Vypocet max. velkosti suboru pre upload
    $ini_v = trim(ini_get("upload_max_filesize"));
    $s = ['g'=> 1<<30, 'm' => 1<<20, 'k' => 1<<10];
    $upload_size =  intval($ini_v) * ($s[strtolower(substr($ini_v,-1))] ?: 1);
    $form = new Form();
		$form->addProtection();
    $form->addHidden("id");
    $form->addHidden("id_user_roles");
    $form->addRadioList('type', 'Typ prílohy:', [1=>"Iné", 2=>"Obrázok", 3=>"Video",4=>"Audio"])
          ->setDefaultValue(1)
          ->addCondition(Form::NOT_EQUAL, 2)
          ->toggle("thumb_field");
    $form->addUpload('priloha', 'Pridaj prílohu')
          ->setOption('description', sprintf('Max veľkosť prílohy v bytoch %s kB', $upload_size/1024))
          ->setRequired(FALSE)
          ->addCondition(Form::FILLED)
            ->addRule(Form::MAX_FILE_SIZE, 'Max veľkosť prílohy v bytoch %d B', $upload_size)
          ->endCondition()
          ->addConditionOn($form['type'], Form::EQUAL, 2)
            ->addRule(Form::IMAGE, 'Príloha musí byť obrázok!')
            ->endCondition();
    $form->addText('name', 'Nadpis prílohy:', 55, 255)
          ->setOption('description', sprintf('Nadpis by mal mať aspoň %s znakov. Inak nebude akceptovaný a bude použitý názov súboru!', 2));
    $form->addUpload('thumb', 'Pridaj náhľadový obrázok:')
          ->setOption('id', 'thumb_field')
          ->setHtmlAttribute('accept', 'image/*')
          ->setRequired(FALSE)
          ->addRule(Form::IMAGE, 'Náhľadový obrázok musí byť obrázok!');
    $form->addText('description', 'Podrobnejší popis prílohy:', 55, 255)
          ->setOption('description', sprintf('Popis by mal mať aspoň %s znakov. Inak nebude akceptovaný!', 2));
		$form->addSubmit('uloz', 'Ulož')
          ->setHtmlAttribute('class', 'btn btn-success');
    $form->addSubmit('cancel', 'Cancel')
          ->setHtmlAttribute('class', 'btn btn-default')
          ->setHtmlAttribute('data-dismiss', 'modal')
          ->setHtmlAttribute('aria-label', 'Close')
          ->setValidationScope([]);
    $form->setAction($basePath.'/api/documents/save/'.$id_hlavne_menu);
    $form->setMethod('POST');
    $form->setHtmlAttribute('class', 'ajax');
		return $form;
	}
}