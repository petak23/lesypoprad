<?php
namespace App\AdminModule\Components\Oznam\TitleOznam;

use Nette;
use DbTable;

/**
 * Komponenta pre vytvorenie hlavičky ponuky oznamov.
 * 
 * Posledna zmena(last change): 06.11.2020
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2020 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.3
 */

class TitleOznamControl extends Nette\Application\UI\Control {

  // --- DB ---
  /** @var DbTable\Hlavne_menu_lang */
	public $hlavne_menu_lang;
  /** @var DbTable\Udaje */
	public $udaje;
  
  // --- Forms ---
  /** @var ZmenPresmerovanieFormFactory */
	public $zmenPresmerovanie;


  /**
   * @param DbTable\Hlavne_menu_lang $hlavne_menu_lang
   * @param DbTable\Udaje $udaje
   * @param ZmenPresmerovanieFormFactory $zmenPresmerovanieFormFactory */
  public function __construct(DbTable\Hlavne_menu_lang $hlavne_menu_lang, 
                              DbTable\Udaje $udaje,
                              ZmenPresmerovanieFormFactory $zmenPresmerovanieFormFactory
                             ) {
    $this->hlavne_menu_lang = $hlavne_menu_lang;
    $this->udaje = $udaje;
    $this->zmenPresmerovanie = $zmenPresmerovanieFormFactory;
  }
  
  /** 
   * Render 
   * @param array $params Parametre komponenty - [admin_links]*/
	public function render(/*$params*/) {
    $this->template->setFile(__DIR__ . '/TitleOznam.latte');
    $this->template->por_oznamy = $this->udaje->getOznamUsporiadanie();
    $this->template->oznamy_nastav = $this->udaje->getDruh("Oznam", 0);
    $this->template->clanok_presmerovanie = ($id = $this->udaje->getUdajInt('oznam_presmerovanie')) > 0 ? $this->hlavne_menu_lang->find($id) : FALSE;
		$this->template->render();
	}
 
  /** 
   * Komponenta formulara pre zmenu urovne registracie.
   * @return Nette\Application\UI\Form */
  public function createComponentZmenPresmerovanieForm() {
    $form = $this->zmenPresmerovanie->create();
    $form['uloz']->onClick[] = function ($button) { 
      $this->presenter->flashOut(!count($button->getForm()->errors), 'this', 'Zmena bola úspešne uložená!', 'Došlo k chybe a zmena sa neuložila. Skúste neskôr znovu...');
		};
    return $form;
  }
  
  /** Signal pre zmenu zoradenia podclanokv podla poradia od 9 do 1 */
  public function handleOznamyZoradenie() {
    $this->udaje->editKey('oznam_usporiadanie', 1 - (int)$this->udaje->getOznamUsporiadanie());
		if (!$this->presenter->isAjax()) {
      $this->redirect('this');
    } else {
      $this->redrawControl('');
    }
	}
}

interface ITitleOznamControl {
  /** @return TitleOznamControl */
  function create();
}