<?php
namespace App\AdminModule\Components\Article\TitleArticle;

use App\AdminModule\Components\Clanky\Komponenty;
use DbTable;
use Nette;
use Nette\Application\UI\Form;

/**
 * Komponenta pre vytvorenie hlavičky polozky.
 * 
 * Posledna zmena(last change): 04.05.2022
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com> 
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.2.2
 */

class TitleArticleControl extends Nette\Application\UI\Control {
	/** @var DbTable\Hlavne_menu_lang */
	public $hlavne_menu_lang;
  
  /** @var Nette\Database\Table\ActiveRow|FALSE Nadradena polozka menu */
	public $hlavne_menu_nadradeny;
 
  /** @var Nette\Database\Table\ActiveRow $clanok Info o clanku */
  private $clanok;
  /** @var string $odkaz Odkaz */
  private $odkaz;
  /** @var bool $zobraz_anotaciu Zobrazenie anotacie polozky*/
  private $zobraz_anotaciu;
  /** @var bool $aktualny_projekt_enabled Povolenie aktualneho projektu */
  private $aktualny_projekt_enabled;
  /** @var bool $komentare Povolenie komentarov */
  private $komentare;
  /** @var bool $categori Povolenie zobrazenia kategorie */
  private $categori;

  /** @var ZmenVlastnikaFormFactory */
	public $zmenVlastnika;
  /** @var ZmenUrovenRegistracieFormFactory */
	public $zmenUrovenRegistracie;
  /** @var ZmenDatumPlatnostiFormFactory */
	public $zmenDatumPlatnosti;
  /** @var ZmenDlzkuNovinkyFormFactory */
	public $zmenDlzkuNovinky;
  /** @var ZmenOpravnenieNevlastnikovFormFactory */
	public $zmenOpravnenieNevlastnikov;
  /** @var ZmenOpravnenieKategoriaFormFactory */
	public $zmenOpravnenieKategoria;
  /** @var ZmenSablonuFormFactory */
	public $zmenSablonu;
  /** @var Komponenty\IKomponentyControl */
	public $komponentyControlFactory;

  /** 
   * @param bool $aktualny_projekt_enabled Povolenie aktualneho projektu - Nastavenie priamo cez servises.neon
   * @param bool $zobraz_anotaciu Povolenie zobrazenia anotacie - Nastavenie priamo cez servises.neon
   * @param bool $categori Povolenie zobrazenia kategorie - Nastavenie priamo cez servises.neon */
  public function __construct(bool $aktualny_projekt_enabled, bool $zobraz_anotaciu, bool $categori,
                              DbTable\Hlavne_menu_lang $hlavne_menu_lang, 
                              ZmenVlastnikaFormFactory $zmenVlastnikaFormFactory, 
                              ZmenUrovenRegistracieFormFactory $zmenUrovenRegistracieFormFactory,
                              ZmenDatumPlatnostiFormFactory $zmenDatumPlatnostiFormFactory,
                              ZmenDlzkuNovinkyFormFactory $zmenDlzkuNovinkyFormFactory,
                              ZmenOpravnenieKategoriaFormFactory $zmenOpravnenieKategoriaFormFactory,
                              ZmenOpravnenieNevlastnikovFormFactory $zmenOpravnenieNevlastnikovFormFactory,
                              ZmenSablonuFormFactory $zmenSablonuFormFactory,
                              Komponenty\IKomponentyControl $komponenty
                             ) {
    $this->hlavne_menu_lang = $hlavne_menu_lang;
    $this->zmenVlastnika = $zmenVlastnikaFormFactory;
    $this->zmenUrovenRegistracie = $zmenUrovenRegistracieFormFactory;
    $this->zmenDatumPlatnosti = $zmenDatumPlatnostiFormFactory;
    $this->zmenDlzkuNovinky = $zmenDlzkuNovinkyFormFactory;
    $this->zmenOpravnenieKategoria = $zmenOpravnenieKategoriaFormFactory;
    $this->zmenOpravnenieNevlastnikov = $zmenOpravnenieNevlastnikovFormFactory;
    $this->zmenSablonu = $zmenSablonuFormFactory;
    $this->aktualny_projekt_enabled = $aktualny_projekt_enabled;
    $this->zobraz_anotaciu = $zobraz_anotaciu;
    $this->categori = $categori;
    $this->komponentyControlFactory = $komponenty;
  }
  
  /** Nastavenie komponenty
   * @param Nette\Database\Table\ActiveRow $clanok
   * @param string $odkaz
   * @param bool $komentare Povolenie komentarov
   * @return TitleArticleControl */
  public function setTitle(Nette\Database\Table\ActiveRow $clanok, string $odkaz, bool $komentare = FALSE): TitleArticleControl {
    $this->clanok = $clanok;
    $this->odkaz = $odkaz;
    $this->komentare = $komentare;
    $this->hlavne_menu_nadradeny = $this->hlavne_menu_lang->findOneBy(["id_hlavne_menu" => $this->clanok->hlavne_menu->id_nadradenej]);
    return $this;
  }
  
  /** 
   * Render 
   * @param array $params Parametre komponenty - [admin_links]*/
	public function render(array $params): void {
    $this->template->clanok = $this->clanok;
    $this->template->odkaz = ":".$this->odkaz.":zmenVlastnika";
    $this->template->vlastnik = $params['admin_links']['vlastnik'];
    $this->template->admin_links = $params['admin_links'];
    $this->template->komentare_enabled = $this->komentare;
    $this->template->nadradeny = $this->clanok->hlavne_menu->id_nadradenej !== NULL ? $this->hlavne_menu_nadradeny->hlavne_menu : NULL;
    $this->template->aktualny_projekt_enabled = $this->aktualny_projekt_enabled;
    $this->template->zobraz_anotaciu = $this->zobraz_anotaciu;
    $this->template->categori = $this->categori;
    $this->template->komponentyCount = $this["komponenty"]->getKomponentyCount();
    $this->template->addFilter('border_x', function ($text){
      $pom = $text != null & strlen($text)>2 ? explode("|", $text) : ['#000000','0'];
      $xs = 'style="border: '.$pom[1].'px solid '.(strlen($pom[0])>2 ? $pom[0]:'inherit').'"';
      return $xs;
    });
		$this->template->render(__DIR__ . '/TitleArticle.latte');
	}
  
  /** 
   * Signal pre povolenie/zakazanie komentarov
   * @param int $volba Nastavenie  */
  public function handleKomentare(int $volba) {
    if ($this->presenter->udaje_webu["komentare"] && $volba>=0 && $volba<=1) {
			$this->clanok->hlavne_menu->update(['komentar'=>$volba]);
		} 
    if (!$this->presenter->isAjax()) {
      $this->presenter->redirect('this');
    } else {
      $this->redrawControl('zobrazClanok-komentare');
    }
  }
  
	/** 
   * Signal pre nastavenie/zrusenie aktualneho projektu 
   * @param int $volba Nastavenie  */
	public function handleAktualnyProjekt(int $volba) {
    if ($this->presenter->nastavenie["aktualny_projekt_enabled"] && $volba>=0 && $volba<=1) {
      $this->clanok->hlavne_menu->update(['aktualny_projekt'=>$volba]);
    }
    if (!$this->presenter->isAjax()) {
      $this->presenter->redirect('this');
    } else {
      $this->redrawControl('');
    }
	}
   
  /** Signal pre nastavenie priameho clanku */
  public function handlePriamyClanok() {
    $this->hlavne_menu_nadradeny->hlavne_menu->update([
      'redirect_id' => ($this->hlavne_menu_nadradeny->hlavne_menu->redirect_id && $this->clanok->id_hlavne_menu == $this->hlavne_menu_nadradeny->hlavne_menu->redirect_id) ? NULL : $this->clanok->id_hlavne_menu
    ]);
    if (!$this->presenter->isAjax()) {
      $this->presenter->redirect('this');
    } else {
      $this->redrawControl('');
    }
	}
  
  /** 
   * @param Form $form
   * @return Form */
  protected function _formMessage(Form $form): Form {
    $form['uloz']->onClick[] = function ($button) { 
      $this->presenter->flashOut(!count($button->getForm()->errors), 'this', 'Zmena bola úspešne uložená!', 'Došlo k chybe a zmena sa neuložila. Skúste neskôr znovu...');
		};
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
      /*if ($type === 'button') {
        $control->getControlPrototype()->addClass(empty($usedPrimary) ? 'btn btn-primary' : 'btn btn-secondary');
        $usedPrimary = true;

      } else*/if (in_array($type, ['text', 'textarea', 'select'], true)) {
        $control->getControlPrototype()->addClass('form-control');

      } elseif ($type === 'file') {
        $control->getControlPrototype()->addClass('form-control-file');

      } elseif (in_array($type, ['checkbox', 'radio'], true)) {
        if ($control instanceof Nette\Forms\Controls\Checkbox) {
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

  /** 
   * Komponenta formulara pre zmenu vlastnika.
   * @return Form */
  public function createComponentZmenUrovenRegistracieForm(): Form {
    return $this->_formMessage($this->zmenUrovenRegistracie->create($this->clanok->id_hlavne_menu, $this->clanok->hlavne_menu->id_user_roles));
  }
  
  /** 
   * Komponenta formulara pre zmenu urovne registracie.
   * @return Form */
  public function createComponentZmenVlastnikaForm(): Form {
    return $this->_formMessage($this->zmenVlastnika->create($this->clanok->id_hlavne_menu, $this->clanok->hlavne_menu->id_user_main));
  }
  
  /** 
   * Komponenta formulara pre zmenu datumu platnosti.
   * @return Form */
  public function createComponentZmenDatumPlatnostiForm(): Form {
    return $this->_formMessage($this->zmenDatumPlatnosti->create($this->clanok->id_hlavne_menu, $this->clanok->hlavne_menu->datum_platnosti));
  }
  
  /** 
   * Komponenta formulara pre zmenu opravnenia podla kategorie polozky.
   * @return Form */
  public function createComponentZmenOpravnenieKategoriaForm(): Form {
    return $this->_formMessage($this->zmenOpravnenieKategoria->create($this->clanok->hlavne_menu));
  }
  
  /** 
   * Komponenta formulara pre zmenu opravnenia nevlastnikov polozky.
   * @return Form */
  public function createComponentZmenOpravnenieNevlastnikovForm(): Form {
    return $this->_formMessage($this->zmenOpravnenieNevlastnikov->create($this->clanok->id_hlavne_menu, $this->clanok->hlavne_menu->id_hlavne_menu_opravnenie));
  }
  
  /** 
   * Komponenta formulara pre zmenu dlzky sledovania ako novinky.
   * @return Form */
  public function createComponentZmenDlzkuNovinkyForm(): Form {
    return $this->_formMessage($this->zmenDlzkuNovinky->create($this->clanok->id_hlavne_menu, $this->clanok->hlavne_menu->id_dlzka_novinky));
  }
  
  /** 
   * Komponenta formulara pre zmenu sablony.
   * @return Form */
  public function createComponentZmenSablonuForm(): Form {
    return $this->_formMessage($this->zmenSablonu->create($this->clanok->id_hlavne_menu, $this->clanok->hlavne_menu->id_hlavne_menu_template));
  }

    /**
   * Komponenta pre ukazanie komponent clanku.
   * @return \App\AdminModule\Components\Clanky\Komponenty\KomponentyControl */
	public function createComponentKomponenty() {
    $komponenty = $this->komponentyControlFactory->create();
    $komponenty->setTitle($this->clanok);
    return $komponenty;
  }
}

interface ITitleArticleControl {
  /** @return TitleArticleControl */
  function create();
}