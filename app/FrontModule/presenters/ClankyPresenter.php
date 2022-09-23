<?php
declare(strict_types=1);

namespace App\FrontModule\Presenters;

use App\FrontModule\Components;
use App\FrontModule\Forms;
use DbTable;
use Nette;
use Nette\Application\UI\Multiplier;
use PeterVojtech;

/**
 * Prezenter pre vypisanie clankov.
 * 
 * Posledna zmena(last change): 22.09.2022
 *
 *	Modul: FRONT
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.4.6
 */

class ClankyPresenter extends BasePresenter {

  use PeterVojtech\Clanky\ZobrazKartyPodclankov\zobrazKartyPodclankovTrait;
  use PeterVojtech\Clanky\OdkazNaClanky\odkazNaClankyTrait;
  
	/** @var DbTable\Clanok_komponenty @inject*/
	public $clanok_komponenty;
  
  // -- Komponenty
  /** @var Components\Clanky\Attachments\IAttachmentsControl @inject */
  public $attachmentsClanokControlFactory;
  /** @var Components\Faktury\ViewFakturyControl @inject */
  public $viewFakturyControlFactory;

  // -- Forms
  /** @var Forms\Article\EditArticleTitleFormFactory @inject */
  public $editArticleTitleFormControlFactory;
  
  /** @var Nette\Database\Table\ActiveRow */
	public $zobraz_clanok;
  /** @var string */
  private $kotva = "";
  
  /** 
   * Zobrazenie konkretneho clanku
   * @param int $id Id hlavneho menu clanku
   * @param string $kotva
   * @return type */
	public function actionDefault(int $id = 0, string $kotva = "") {
		// Vsuvka pre presmerovanie ak nemam ziadnu aktualitu
		if (in_array("aktualne", $this->clanok_komponenty->getKomponentyName($id)) &&  //Mam k clanku priradenu komponentu aktualne
				isset($this["aktualne"]) && 																							 //Mam je vytvorenu
				is_array($re = $this["aktualne"]->getPresmerovanie())) {									 //Je nastavene presmerovanie
			$this->flashRedirect(['Clanky:', $re['id']], $re['txt'], 'info');
		}
    
    $this->kotva = $kotva;
    
		try { //Find article
      $this->zobraz_clanok = $this->hlavne_menu_lang->getOneArticleId($id, $this->language_id, $this->id_reg); // Najdi clanok
    } catch (DbTable\ArticleMainMenuException $e) {
      if ($e->getCode() == 2) { //Article missing permissions
        $this->flashRedirect(["User:", ['backlink' => $this->storeRequest()]], 'clanky_najdeny_neprihlaseny', "warning");
      } else {                  //Article not found
        $this->setView("notFound"); 
      }  
      return;
    }

    if ($this->zobraz_clanok->hlavne_menu->redirect_id) { //Ak mám presmerovanie na podclanok
      $this->redirect("Clanky:", $this->zobraz_clanok->hlavne_menu->redirect_id);              
    } elseif ($this->zobraz_clanok->hlavne_menu->id_nadradenej !== NULL) { //Ak mam v nadradenej polozke zobrazovanie podclankov na kartach
      $nadr = $this->clanok_komponenty->findBy(['id_hlavne_menu' => $this->zobraz_clanok->hlavne_menu->id_nadradenej, 'spec_nazov' => 'zobrazKartyPodclankov']);
      if (count($nadr)) {
        $this->redirect("Clanky:", [$this->zobraz_clanok->hlavne_menu->id_nadradenej, $this->zobraz_clanok->hlavne_menu->spec_nazov]);
      } else {
        $this->setView($this->zobraz_clanok->hlavne_menu->hlavne_menu_template->name);
      }
    } else {
      $this->setView($this->zobraz_clanok->hlavne_menu->hlavne_menu_template->name);
    }
  }
  
  /** Render pre zobrazenie clanku */
	public function beforeRender() {
    parent::beforeRender();
    if ($this->zobraz_clanok !== FALSE) {
      $this->getComponent('menu')->selectByUrl($this->link('Clanky:', ["id"=>$this->zobraz_clanok->id_hlavne_menu]));
      $this->template->komentare_povolene =  $this->udaje_webu["komentare"] && ($this->user->isAllowed('Front:Clanky', 'komentar') && $this->zobraz_clanok->hlavne_menu->komentar) ? $this->zobraz_clanok->id_hlavne_menu : 0;
      $this->template->article = $this->zobraz_clanok;
      $this->template->uroven = $this->zobraz_clanok->hlavne_menu->uroven + 2;
      $this->template->avatar = $this->zobraz_clanok->hlavne_menu->avatar;
      $this->template->podclanky = $this->hlavne_menu->maPodradenu($this->zobraz_clanok->id);
      $this->template->view_submenu = $this->zobraz_clanok->hlavne_menu->id_hlavicka < 3;
      $this->template->viac_info = $this->texty_presentera->translate('clanky_viac_info');
      //Zisti, ci su k clanku priradene komponenty
      $this->template->komponenty = $this->clanok_komponenty->getKomponenty($this->zobraz_clanok->id_hlavne_menu, $this->nastavenie["komponenty"]);
      $this->template->id_hlavne_menu_lang = $this->zobraz_clanok->id;
      $this->template->article_hlavicka = $this->udaje->getValByName("clanok_hlavicka");
      $this->template->this_link = $this->link('this');

      $servise = $this;
      $this->template->addFilter('odkazdo', function ($id) use($servise){
        $serv = $servise->link("Dokumenty:default", ["id"=>$id]);
        return $serv;
      });
      $this->template->addFilter('tojson', function ($data){
        return Nette\Utils\Json::encode($data);
      });
    }
	}

  /** Render v prípade nenájdenia článku */
  public function renderNotFound() {
    $this->getHttpResponse()->setCode(\Nette\Http\IResponse::S404_NOT_FOUND);
  }
  
  /** 
   * Komponenta pre komentare k clanku
   * @return Multiplier */
	public function createComponentKomentar() {
		return new Multiplier(function ($id_hlavne_menu) {
      $komentar = $this->komentarControlFactory->create();
      $komentar->setParametre($id_hlavne_menu);
			return $komentar;
		});
	}

  /**
   * Komponenta pre zobrazenie clanku
   * @return Components\Clanky\ZobrazClanok\ZobrazClanokControl */
  public function createComponentUkazTentoClanok() {
    $ukaz_clanok = $this->zobrazClanokControlFactory->create();
    $ukaz_clanok->setArticle($this->zobraz_clanok)
                ->setLanguage($this->language_id)
                ->setClanokHlavicka($this->udaje_webu['clanok_hlavicka']);
    return $ukaz_clanok;
  }

  /** 
   * Komponenta pre zobrazenie priloh
   * @return Components\Clanky\Attachments\AttachmentsControl */
  public function createComponentAttachments() {
    $attachments = $this->attachmentsClanokControlFactory->create();
    $attachments->setNastav($this->zobraz_clanok, $this->language);
    return $attachments;
  }
  
  /** 
   * Komponenta pre zobrazenie faktur
   * @return Components\Faktury\ViewFakturyControl */
  public function createComponentViewFaktury() {
    $viewFaktury = $this->viewFakturyControlFactory;
    $viewFaktury->setSkupina($this->zobraz_clanok->id_hlavne_menu);
    return $viewFaktury;
  }
  
  /* * 
   * Komponenta pre vykreslenie podclankov na kartach
   * @return Components\Clanky\ZobrazKartyPodclankov\ZobrazKartyPodclankovControl */
  /*public function createComponentZobrazKartyPodclankov() {
    $odkaz = $this->zobrazKartyPodclankovControlFactory->create();
    $odkaz->setArticle($this->zobraz_clanok->id_hlavne_menu, $this->language_id, $this->kotva);
    return $odkaz;
  }*/

  /** 
   * Komponenta pre vykreslenie podclankov na kartach
   * @return Components\Clanky\ZobrazKartyPodclankov\ZobrazKartyPodclankovControl */
  public function createComponentEditArticleTitleForm() {
    $form = $this->editArticleTitleFormControlFactory->create($this->zobraz_clanok->id_hlavne_menu);
    $form['uloz']->onClick[] = function () { 
      $this->flashMessage('Položka menu bola uložená!', 'success');
      $this->redirect('this');
    };
		return $form;
  }
}
