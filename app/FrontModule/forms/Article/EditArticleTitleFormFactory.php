<?php
declare(strict_types=1);

namespace App\FrontModule\Forms\Article;

use DbTable;
use Nette\Application\UI\Form;
use Nette\Database;

/**
 * Formular a jeho spracovanie pre zmenu nadpisu.
 * Posledna zmena 13.03.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
class EditArticleTitleFormFactory {
  // --- DB
  /** @var DbTable\Hlavne_menu_lang */
	private $hlavne_menu_lang;
  /** @var DbTable\Lang */
  public $lang;

  private $id_hlavne_menu169;
 
  public function __construct(DbTable\Hlavne_menu_lang $hlavne_menu_lang,
                              DbTable\Lang $lang) {
    $this->hlavne_menu_lang = $hlavne_menu_lang;
    $this->lang = $lang->findAll();
	}
  
  /**
   * Formular.
   * @param int $id Id polozky v hlavnom menu
   * @return Form */  
  public function create(int $id): Form  {
    $this->id_hlavne_menu169 = $id;
    $form = new Form();
		$form->addProtection();
    //$form->addHidden("id_hlavne_menu", $id);
    foreach ($this->lang as $j) {
      if ($this->lang->count() > 1) $form->addGroup('Časť pre jazyk: '.$j->nazov);
      $form->addText($j->skratka.'_view_name', 'Názov zobrazený v nadpise pre jazyk '.$j->nazov.":", 90, 255)
           ->addRule(Form::MIN_LENGTH, 'Popis musí mať spoň %d znaky!', 2)
           //->setOption('description', 'Podrobnejší popis položky slúži pre vyhľadávače a zároveň ako pomôcka pre užívateľa, keď príde ukazovateľom myši nad odkaz(bublinová nápoveda).')
           ->setRequired('Popis pre jazyk "'.$j->nazov.'" musí byť zadaný!');
      $form->addText($j->skratka.'_menu_name', 'Názov zobrazený v menu pre jazyk: '.$j->nazov.":", 30, 100)
           ->addRule(Form::MIN_LENGTH, 'Názov musí mať spoň %d znaky!', 2)
           ->setRequired('Názov  pre jazyk "'.$j->nazov.'" musí byť zadaný!');
      $form->addText($j->skratka.'_h1part2', 'Druhá časť nadpisu(podtitulok) pre jazyk: '.$j->nazov.":", 90, 100);
      $values = $this->hlavne_menu_lang->findOneBy(['id_hlavne_menu'=>$id, 'id_lang'=>$j->id]);
      if ($values != null) {
        $form->setDefaults([
          $j->skratka.'_menu_name'=> $values->menu_name,
          $j->skratka.'_h1part2'=> $values->h1part2,
          $j->skratka.'_view_name'=> $values->view_name,
        ]);
      }
		}
    if ($this->lang->count() > 1) $form->addGroup("");
    $form->addSubmit('uloz', 'Zmeň')
         ->setHtmlAttribute('class', 'btn btn-success')
         ->onClick[] = [$this, 'formSubmitted'];
    /*$form->addSubmit('cancel', 'Cancel')
         ->setHtmlAttribute('class', 'btn btn-default')
         ->setHtmlAttribute('data-dismiss', 'modal')
         ->setHtmlAttribute('aria-label', 'Close')
         ->setValidationScope([]);*/
		return $this->_vzhladForm($form);
	}
  
  /** 
   * Spracovanie formulara pre zmenu nadpisov. */
  public function formSubmitted(Form $form, $values) {
    try {
      //dumpe($this->id_hlavne_menu169, $values);
      foreach ($this->lang as $j) {
        $h = $this->hlavne_menu_lang->findOneBy(['id_hlavne_menu'=>$this->id_hlavne_menu169, 'id_lang' => $j->id]);
        $h1part2 = $values->{$h->lang->skratka.'_h1part2'};
        $data = [
          'menu_name' => $values->{$h->lang->skratka.'_menu_name'},
          'h1part2' => strlen($h1part2) ? $h1part2 : null,
          'view_name' => $values->{$h->lang->skratka.'_view_name'},
        ];
        $this->hlavne_menu_lang->uloz($data, $h->id);
      }
		} catch (Database\DriverException $e) {
			$form->addError($e->getMessage());
		}
  }

  /**
   * Nastavenie vzhľadu formulara
   * @param \Nette\Application\UI\Form $form
   * @return \Nette\Application\UI\Form */
  public function _vzhladForm($form) {
    $renderer = $form->getRenderer();
    // Vzhlad pre bootstrap 4 link: https://github.com/nette/forms/blob/96b3e90/examples/bootstrap4-rendering.php  
    $renderer->wrappers['controls']['container'] = null;
    $renderer->wrappers['pair']['container'] = 'div class="form-group row"';
    $renderer->wrappers['pair']['.error'] = 'has-danger';
    $renderer->wrappers['control']['container'] = 'div class=col-sm-9';
    $renderer->wrappers['label']['container'] = 'div class="col-sm-3 col-form-label"';
    $renderer->wrappers['control']['description'] = 'span class="form-text alert alert-info"';
    $renderer->wrappers['control']['errorcontainer'] = 'span class="form-control-feedback alert alert-danger"';
    $renderer->wrappers['control']['.error'] = 'is-invalid';

    foreach ($form->getControls() as $control) {
      $type = $control->getOption('type');
      if ($type === 'button') {
        $control->getControlPrototype()->addClass(empty($usedPrimary) ? 'btn btn-primary' : 'btn btn-secondary');
        $usedPrimary = true;

      } elseif (in_array($type, ['text', 'textarea', 'select'], true)) {
        $control->getControlPrototype()->addClass('form-control');

      } elseif ($type === 'file') {
        $control->getControlPrototype()->addClass('form-control-file');

      } elseif (in_array($type, ['checkbox', 'radio'], true)) {
        if ($control instanceof \Nette\Forms\Controls\Checkbox) {
          $control->getLabelPrototype()->addClass('form-check-label');
        } else {
          $control->getItemLabelPrototype()->addClass('form-check-label');
        }
        $control->getControlPrototype()->addClass('form-check-input');
        $control->getSeparatorPrototype()->setName('div')->addClass('form-check');
      }
    }
    return $form;
  }
}