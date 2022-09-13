<?php
namespace App\AdminModule\Presenters;

use App\AdminModule\Forms\Slider;
use DbTable;
use PeterVojtech;
use Ublaboo\DataGrid\DataGrid;
use Ublaboo\DataGrid\Column\Action\Confirmation;
use Ublaboo\DataGrid\Localization\SimpleTranslator;

/**
 * Prezenter pre administraciu slider-u.
 * 
 * Posledna zmena(last change): 25.03.2022
 *
 * Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.5
 */

class SliderPresenter extends BasePresenter {
  // -- DB
  /** @var DbTable\Slider @inject */
  public $slider;

  /** @var array Nastavenie slider-u */
  private $slider_i;
  /** @var array */
  private $texts_for_translator;
  
  // -- Forms
  /** @var Slider\EditSliderFormFactory @inject*/
	public $editSliderForm;
  
  public function __construct(array $texts_for_translator,
                              array $parameters) {
    // Nastavenie z config-u
    $this->nastavenie = $parameters;
    $this->texts_for_translator = $texts_for_translator;
  }

  protected function startup() {
		parent::startup();
		if (isset($this->nastavenie['slider'])) {
			$this->slider_i = $this->nastavenie['slider'];
      $this->template->slider_i = $this->slider_i;
		}
	}

  public function renderDefault() {
    $this->template->allways = $this->slider->findBy(["zobrazenie"=>null]);
  }

  /** Akcia pre pridanie položky slideru */
	public function actionAdd() {
    $this["sliderEditForm"]->setDefaults(['poradie' => $this->slider->getNextCounter()]);
    $this->setView('edit');
	}

  /**
   * Akcia pre editaciu polozky slider-u
   * @param int $id id editovanej polozky
   */
	public function actionEdit(int $id) {
    if (($pol_slider = $this->slider->find($id)) === FALSE) {
      $this->setView('notFound');
		} else {
      $this->template->sucasny = $pol_slider;
      if ($pol_slider->zobrazenie !== null) { // Test, ci vsetky polozky existuju. Ak nie vypustia sa.
        $zobraz = [];
        foreach (explode(',', $pol_slider->zobrazenie) as $z) {
          if ($this->hlavne_menu->find($z) !== null) { $zobraz[] = $z; }
        }
        $zobraz = count($zobraz) ? $zobraz : null; //Aby nebolo prázdne pole
      } else { $zobraz = null; }
			$this["sliderEditForm"]->setDefaults($pol_slider);
      $this["sliderEditForm"]->setDefaults(['zobrazenie_null' => $zobraz == null ? 1 : 0,
                                            'zobrazenie_1'    => $zobraz,
                                            ]);
    }
	}
  
  public function createComponentSliderGrid($name) {
		$grid = new DataGrid($this, $name);

		$grid->setDataSource($this->slider->findAll());
    $grid->setTemplateFile(__DIR__ . '/../templates/Slider/custom_datagrid_template.latte');
    $grid->setSortable();
    $grid->setDefaultSort(['poradie' => 'ASC']);
    $grid->addColumnText('subor', 'Subor')
          //->setSortable()
          ->setTemplate(__DIR__ . '/../templates/Slider/grid.subor.latte', 
                        ['popis' => FALSE, 
                        'slider_dir' => $this->nastavenie['slider']['dir'],
                        'dir_to_images' => $this->nastavenie['dir_to_images'],
                        ]);
    $grid->addColumnText('subor1', 'Subor', 'subor');
		$grid->addColumnText('poradie', 'Poradie')->setDefaultHide();
    $grid->addColumnText('nadpis', 'Nadpis')
          //->setSortable()
          ->setRenderer(function($item) {
            return ($item->nadpis !== NULL ? $item->nadpis : 'Bez nadpisu');
          });
    $grid->addColumnText('zobrazenie', 'Zobrazenie')
          ->setRenderer(function($item) {
            return ($item->zobrazenie !== NULL ? $item->zobrazenie : 'Vždy okrem...');
          });
    $grid->addAction('edit', '')
          ->setIcon('pencil-alt fa-2x')
          ->setClass('btn btn-xs btn-default edit-ikon')
          ->setTitle('Editácia položky');
    $grid->addAction('delete', '', 'confirmedDelete!')
          ->setIcon('trash-alt fa-2x')
          ->setClass('btn btn-xs btn-default del-ikon')
          ->setTitle('Vymazanie položky')
          ->setConfirmation(
            new Confirmation\StringConfirmation('Naozaj chceš zmazať obrázok %s?', 'subor')
          );
    $grid->setTranslator(new SimpleTranslator($this->texts_for_translator));
    $grid->setRememberState(false);
	}

	/** Edit Slider form component factory for admin.
	 * @return Nette\Application\UI\Form
	 */
	public function createComponentSliderEditForm() {
    $form = $this->editSliderForm->create($this->nastavenie, $this->getComponent('menu'));  
    $form['uloz']->onClick[] = function ($button) {
      $this->flashOut(!count($button->errors), 'Slider:', 'Položka bola uložená!', 'Došlo k chybe a položka sa neuložila. Skúste neskôr znovu...');
		};
    $form['cancel']->onClick[] = function () {
			$this->redirect('Slider:');
		};
		return $this->_vzhladForm($form);
	}

  /** 
   * Spracovanie signálu vymazavania
	 * @param int $id Id polozky */
	function handleConfirmedDelete(int $id): void	{
    $temp_del = $this->slider->find($id);
    if (is_file($this->nastavenie['slider']['dir'].$temp_del->subor)) { 
      unlink($this->nastavenie["wwwDir"].'/'.$this->nastavenie['slider']['dir'].$temp_del->subor); 
    }
    $this->_ifMessage($temp_del->delete() == 1, 'Položka bola úspešne vymazaná!', 'Došlo k chybe a položka nebola vymazaná!');
    if (!$this->isAjax()) {
      $this->redirect('Slider:');
    } else {
      $this->redrawControl('flashes');
      $this['sliderGrid']->reload();
    }
  }
  
  /**
   * Spracovanie signalu pri zmene poradia
   * @param int $item_id Prvok, ktoreho poradie sa meni
   * @param int $prev_id Za ktory prvok sa vklada
   * @param int $next_id Pred ktory prvok sa vklada */
  public function handleSort($item_id, $prev_id, $next_id) {
    $this->slider->sortItem($item_id, $prev_id, $next_id);
//    $this->flashMessage("Poradie bolo zmenené."/*"Id: $item_id, Previous id: $prev_id, Next id: $next_id"*/, 'success');
    $this->redrawControl('flashes');
    $this['sliderGrid']->redrawControl();
  }
}	