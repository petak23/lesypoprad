<?php
declare(strict_types=1);

namespace App\AdminModule\Components\Article\TitleArticle;

use DbTable;
use Nette\Application\UI;
use Nette\Database;

/**
 * Formular a jeho spracovanie pre zmenu dlzky sledovania ako novinky polozky.
 * Posledna zmena 04.05.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
class ZmenDlzkuNovinkyFormFactory {
  /** @var DbTable\Hlavne_menu */
	private $hlavne_menu;
  
  /** @var array Hodnoty id=>nazov pre formulare z tabulky dlzka_novinky*/
	private $dlzka_novinky;
  
  /**
   * @param DbTable\Hlavne_menu $hlavne_menu
   * @param DbTable\Dlzka_novinky $dlzka_novinky */
  public function __construct(DbTable\Hlavne_menu $hlavne_menu, DbTable\Dlzka_novinky $dlzka_novinky) {
		$this->hlavne_menu = $hlavne_menu;
    $this->dlzka_novinky = $dlzka_novinky->dlzkaNovinkyForm();
	}
  
  /**
   * Formular pre zmenu dlzky sledovania ako novinky.
   * @param int $id Id polozky v hlavnom menu
   * @param int $id_dlzka_novinky Sucasna dlzka sledovania ako novinky
   * @return UI\Form */  
  public function create(int $id = 0, int $id_dlzka_novinky = 0): UI\Form {
		$form = new UI\Form();
		$form->addProtection();
    $form->addHidden("id", (string)$id);
    $form->addRadioList('id_dlzka_novinky', 'Nová dĺžka sledovania ako novinky:', $this->dlzka_novinky)
         ->setDefaultValue($id_dlzka_novinky)
         ->setOption('description', 'Dĺžka času (v dňoch), za ktorý je článok považovaný za novinku od jeho poslednej zmeny.');
    $form->addSubmit('uloz', 'Zmeň')
         ->setHtmlAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'zmenUrovenRegistracieFormSubmitted'];
    $form->addSubmit('cancel', 'Cancel')
         ->setHtmlAttribute('class', 'btn btn-default')
         ->setHtmlAttribute('data-dismiss', 'modal')
         ->setHtmlAttribute('aria-label', 'Close')
         ->setValidationScope([]);
		return $form;
	}
  
  /** 
   * Spracovanie formulara pre dlzky sledovania ako novinky.*/
  public function zmenUrovenRegistracieFormSubmitted(UI\Form $form, $values) {
    try {
			$this->hlavne_menu->zmenDlzkuNovinky($values);
		} catch (Database\DriverException $e) {
			$form->addError($e->getMessage());
		}
  }
}