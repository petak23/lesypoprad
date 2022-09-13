<?php
declare(strict_types=1);

namespace App\AdminModule\Components\Article\TitleArticle;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Utils;

/**
 * Formular a jeho spracovanie pre zmenu datumu platnosti polozky.
 * Posledna zmena 20.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.4
 */
class ZmenDatumPlatnostiFormFactory {
  /** @var DbTable\Hlavne_menu */
	private $hlavne_menu;
  
  /**
   * @param DbTable\Hlavne_menu $hlavne_menu */
  public function __construct(DbTable\Hlavne_menu $hlavne_menu) {
		$this->hlavne_menu = $hlavne_menu;
	}
  
  /**
   * Formular pre zmenu datumu platnosti polozky.
   * @param int $id Id polozky v hlavnom menu
   * @param Utils\DateTime|null $datum_platnosti Datum platnosti polozky
   * @return Form */  
  public function create(int $id, ?Utils\DateTime $datum_platnosti): Form  {
		$form = new Form();
		$form->addProtection();
    $form->addHidden("id", (string)$id);
    $form->addGroup();
    $form->addCheckbox('platnost', ' Sledovanie aktuálnosti článku')
         ->setDefaultValue(isset($datum_platnosti) ? 1 : 0)
         ->setOption('description', 'Zaškrtnutím sa otvorí pole, v ktorom je možné zadať koniec platnosti článku.')
         ->addCondition(Form::EQUAL, TRUE)
         ->toggle("platnost-i", TRUE);
    $form->addGroup()->setOption('container', Utils\Html::el('fieldset')->id("platnost-i"));
		$idp = $form->addText('datum_platnosti', 'Dátum platnosti')
         ->setHtmlType('date');
    if ($datum_platnosti != null) {
      $idp->setDefaultValue($datum_platnosti->format('Y-m-d'));
    }     
    $idp->addConditionOn($form['platnost'], Form::EQUAL, TRUE)
        ->addRule(Form::FILLED, 'Je nutné vyplniť dátum platnosti!');
         
		$form->addGroup();
    $form->addSubmit('uloz', 'Zmeň')
         ->setAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'zmenDatumPlatnostiFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')
         ->setAttribute('class', 'btn btn-default')
         ->setAttribute('data-dismiss', 'modal')
         ->setAttribute('aria-label', 'Close')
         ->setValidationScope([]);
		return $form;
	}
  
  /** 
   * Spracovanie formulara pre zmenu vlastnika clanku.
   * @param \Nette\Forms\Controls\SubmitButton $button Data formulara */
  public function zmenDatumPlatnostiFormSubmitted(\Nette\Forms\Controls\SubmitButton $button) {
		$values = $button->getForm()->getValues(); 	//Nacitanie hodnot formulara
    try {
			$this->hlavne_menu->zmenDatumPlatnosti($values);
		} catch (Database\DriverException $e) {
			$button->addError($e->getMessage());
		}
  }
}