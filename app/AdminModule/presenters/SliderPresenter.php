<?php

namespace App\AdminModule\Presenters;

use App\AdminModule\Forms\Slider;
use DbTable;

/**
 * Prezenter pre administraciu slider-u.
 * 
 * Posledna zmena(last change): 04.06.2022
 *
 * Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.7
 */

class SliderPresenter extends BasePresenter
{
  // -- DB
  /** @var DbTable\Slider @inject */
  public $slider;

  // -- Forms
  /** @var Slider\EditSliderFormFactory @inject*/
  public $editSliderForm;

  public function __construct(array $parameters)
  {
    // Nastavenie z config-u
    $this->nastavenie = $parameters;
  }

  public function startup()
  {
    parent::startup();
    if (isset($this->nastavenie['slider'])) {
      $this->template->slider_i = $this->nastavenie['slider'];
    }
  }

  public function renderDefault()
  {
    $this->template->allways = $this->slider->findBy(["zobrazenie" => null]);
    $this->template->slider_data = $this->slider->findAll()->order('poradie ASC');
    $this->template->dir_to_images = $this->nastavenie['dir_to_images'];
  }

  /** Akcia pre pridanie položky slideru */
  public function actionAdd()
  {
    $this["sliderEditForm"]->setDefaults(['poradie' => $this->slider->getNextCounter()]);
    $this->setView('edit');
  }

  /**
   * Akcia pre editaciu polozky slider-u
   * @param int $id id editovanej polozky
   */
  public function actionEdit(int $id)
  {
    if (($pol_slider = $this->slider->find($id)) === null) {
      $this->setView('notFound');
    } else {
      $this->template->sucasny = $pol_slider;
      if ($pol_slider->zobrazenie !== null) { // Test, ci vsetky polozky existuju. Ak nie vypustia sa.
        $zobraz = [];
        foreach (explode(',', $pol_slider->zobrazenie) as $z) {
          if ($this->hlavne_menu->find($z) !== null) {
            $zobraz[] = $z;
          }
        }
        $zobraz = count($zobraz) ? $zobraz : null; //Aby nebolo prázdne pole
      } else {
        $zobraz = null;
      }
      $this["sliderEditForm"]->setDefaults($pol_slider);
      $this["sliderEditForm"]->setDefaults([
        'zobrazenie_null' => $zobraz == null ? 1 : 0,
        'zobrazenie_1'    => $zobraz,
      ]);
    }
  }

  /** Edit Slider form component factory for admin.
   * @return Nette\Application\UI\Form
   */
  public function createComponentSliderEditForm()
  {
    $form = $this->editSliderForm->create($this->nastavenie, $this->getComponent('menu'));
    $form['uloz']->onClick[] = function ($button) {
      $this->flashOut(!count($button->errors), 'Slider:', 'Položka bola uložená!', 'Došlo k chybe a položka sa neuložila. Skúste neskôr znovu...');
    };
    $form['cancel']->onClick[] = function () {
      $this->redirect('Slider:');
    };
    return $this->_vzhladForm($form);
  }
}
