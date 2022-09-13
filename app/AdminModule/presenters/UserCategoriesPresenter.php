<?php
namespace App\AdminModule\Presenters;
use DbTable;
use Nette\Database\DriverException;
use Ublaboo\DataGrid\DataGrid;
use Ublaboo\DataGrid\Localization\SimpleTranslator;
/**
 * Prezenter pre spravu kategorii uzivatelov.
 * 
 * Posledna zmena(last change): 30.05.2022
 * @actions default
 *
 *	Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.5
 */
class UserCategoriesPresenter extends BasePresenter {
  // --- Models ---
  /** @var DbTable\User_categories @inject */
	public $user_categories;
  /** @var DbTable\User_profiles @inject */
	public $user_profiles;
  
  /** @var array */
  private $grid_lang = [
      'ublaboo_datagrid.no_item_found_reset' => 'Žiadné položky sa nenašli. Filter môžete vynulovať...',
      'ublaboo_datagrid.no_item_found' => 'Žiadné položky sa nenašli.',
      'ublaboo_datagrid.here' => 'tu',
      'ublaboo_datagrid.items' => 'Položky',
      'ublaboo_datagrid.all' => 'všetky',
      'ublaboo_datagrid.from' => 'z',
      'ublaboo_datagrid.reset_filter' => 'Zresetovať filter',
      'ublaboo_datagrid.group_actions' => 'Hromadné akcie',
      'ublaboo_datagrid.show_all_columns' => 'Zobraziť všetky stĺpce',
      'ublaboo_datagrid.hide_column' => 'Skryť stĺpec',
      'ublaboo_datagrid.action' => 'Akcie',
      'ublaboo_datagrid.previous' => 'Predošlí',
      'ublaboo_datagrid.next' => 'Ďaľší',
      'ublaboo_datagrid.choose' => 'Vyberte',
      'ublaboo_datagrid.execute' => 'Spraviť',
      'ublaboo_datagrid.save' => 'Uložiť',
      'ublaboo_datagrid.cancel' => 'Zrušiť',
      'ublaboo_datagrid.add' => 'Pridať kategóriu',
      'ublaboo_datagrid.edit' => 'Upraviť kategóriu',
    ];
  
  /**
   * Datagrid pre kategoriu
   * @param type $name
   * @return DataGrid */
  public function createComponentCategoriesGrid($name) {
		$grid = new DataGrid($this, $name);
    $sthis = $this;
    $grid->setDataSource($this->user_categories->findAll());
    $grid->addColumnNumber('id', 'Id')->setDefaultHide();
    $grid->addColumnText('shortcut', 'Skratka')->setSortable()->setRenderer(function($item) { return mb_strtoupper($item->shortcut);});
    $grid->addColumnText('name', 'Názov', 'name')->setSortable();
    if ($this->user->isAllowed($this->name, 'edit')) {
      $grid->addInlineEdit()->setClass('btn btn-xs btn-info ajax')
                            ->setIcon('pencil-alt')
                            ->onControlAdd[] = function($container) {
          $container->addText('id', '')->setAttribute('readonly');
          $container->addText('name', '');
          $container->addText('shortcut', '');
        };
      $grid->getInlineEdit()->onSetDefaults[] = function($container, $item) {
        $container->setDefaults([
          'id' => $item->id,
          'name' => $item->name,
          'shortcut' => $item->shortcut,
        ]);
      };
      $grid->getInlineEdit()->onSubmit[] = function($id, $values) use ($sthis){
        $values->offsetSet('id', $id);
        $sthis->user_categories->saveCategori($values);
        $sthis->flashMessage("Kategória $values->name bola v poriadku uložená!", 'success');
        $sthis->redrawControl('flashes');
      };
      $grid->getInlineEdit()->onCustomRedraw[] = function() use ($grid) {
        $grid->redrawControl();
      };
    }
    if ($this->user->isAllowed($this->name, 'del')) {      
      $grid->addAction('delete', '', 'confirmedDeleteCategory!')
            ->setIcon('trash-alt')->setText('Zmazať kategóriu')->setTitle('Zmazať kategóriu')->setClass('btn btn-xs btn-danger ajax')
            ->setConfirm(function($item) { return "Naozaj chceš zmazať kategóriu: '".$item->name."'?";});
    }
    if ($this->user->isAllowed($this->name, 'add')) {            
      $grid->addInlineAdd()->setPositionTop(FALSE)->setText('Pridať kategóriu')->setClass('btn btn-xs btn-success')
                           ->onControlAdd[] = function($container) {
          $container->addText('id', '')->setAttribute('readonly');
          $container->addText('name', '');
          $container->addText('shortcut', '');
        };
      $grid->getInlineAdd()->onSubmit[] = function($values) use ($sthis) {
        $values->offsetSet('id', 0);
        $sthis->user_categories->saveCategori($values);
        $sthis->flashMessage("Kategória $values->name bola v poriadku pridaná!<br> Do tabuľky je vložená na koniec.", 'success,n');
        $sthis->redrawControl('flashes');
//        $sthis->redrawControl('categoriesGrid-grid');
      };
    }
    $grid->setTranslator(new SimpleTranslator($this->grid_lang));
    return $grid;
	}
  
  /** 
   * Funkcia pre spracovanie signálu vymazavania kategórie
   * @param int $id Id kategorie */
	function handleConfirmedDeleteCategory($id)	{
    try {
      $this->user_categories->zmaz($id);
      $this->flashMessage('Kategória bola zmazaná!', 'success');
    } catch (DriverException $e) {
      $this->flashMessage('Došlo k chybe pri vymazávaní. Skúste neskôr znovu...'.$e->getMessage(), 'danger');
    }
    if ($this->isAjax()) {
      $this->redrawControl();
      $this['categoriesGrid']->reload();
    } else {
      $this->redirect('UserCategories:');
    }
  }
}