<?php
namespace App\AdminModule\Presenters;

use Nette\Security\User;
use Nette\Application\UI;
use Nette\Http;
use DbTable, PeterVojtech;
/**
 * Zakladny presenter pre vsetky presentery v module ADMIN
 * 
 * Posledna zmena(last change): 23.06.2017
 *
 * Modul: ADMIN
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.2.1
 */
abstract class BasePresenter extends UI\Presenter {

  // -- DB
  /** @var DbTable\Admin_menu @inject */
  public $admin_menu;
  /** @var DbTable\Hlavne_menu @inject */
	public $hlavne_menu;
  /** @var DbTable\Lang @inject*/
	public $lang;
  /** @var DbTable\User_roles @inject */
	public $user_roles;
  /** @var DbTable\Udaje @inject */
	public $udaje;
  /** @var DbTable\Verzie @inject */
	public $verzie;
  
  /** @var string Adresar pre prilohy clankov */
  public $prilohy_adresar;
  
  // -- Komponenty
  /** @var \App\AdminModule\Components\Oznam\IAktualneOznamyControl @inject */
  public $aktualneOznamyControlFactory;
  /** @var \App\AdminModule\Components\User\IUserLastControl @inject */
  public $userLastControlFactory;
  /** @var \App\AdminModule\Components\Clanky\ZobrazKartyPodclankov\IZobrazKartyPodclankovControl @inject */
  public $zobrazKartyPodclankovControlFactory;
  
  // -- Premenne z o stareho CommonBasePresentera
  /** @persistent */
  public $language = 'sk';
  /** @persistent */
  public $backlink = '';
	
  /** @var Http\Request @inject*/
  public $httpRequest;
  
//  /** @var \WebLoader\Nette\LoaderFactory @inject */
//  public $webLoader;

  /** @var string kmenovy nazov stranky pre rozne ucely typu www.neco.sk*/
  public $nazov_stranky;
  /** @var int Uroven registracie uzivatela  */
	public $id_reg;
  /** @var int Maximalna uroven registracie uzivatela */
	public $max_id_reg = 0;
  
	/** @var string Specificky nazov casti */
	public $spec_nazov;

  /** @var array Pole s hlavnymi udajmi webu */
  public $udaje_webu;

  /** @var int */
  public $language_id = 1;
  
  /** @var array nastavenie z config-u */
  public $nastavenie;
	/** @var string - relatívna cesta pre avatar poloziek menu */
	public $avatar_path = "files/menu/";
  /** @var int Maximalna velkost suboru pre upload */
  public $upload_size = 0;
  // -- KONIEC Premenne z o stareho CommonBasePresentera
   
  /** @var array Hodnoty role=>id v DB tab user_roles */
  public $ur_reg = [];
	/** @var array - pole s chybami pri uploade */
  public $upload_error = [
          0=>"Bez chyby. Súbor úspešne nahraný.",
          1=>"Nahrávaný súbor je väčší ako systémom povolená hodnota!",
          2=>"Nahrávaný súbor je väčší ako je formulárom povolená hodnota!",
          3=>"Nahraný súbor bol nahraný len čiastočne...",
          4=>"Žiadny súbor nebol nahraný... Pravdepodobne ste vo formuláry žiaden nezvolili!",
          5=>"Upload error 5.",
          6=>"Chýbajúci dočasný priečinok!",
        ];  

  /** Vychodzie nastavenia */
  protected function startup() {
    parent::startup();
    // Sprava uzivatela
    $user = $this->getUser(); //Nacitanie uzivatela
    // Kontrola prihlasenia a nacitania urovne registracie
    $this->id_reg = ($user->isLoggedIn()) ? $user->getIdentity()->id_user_roles : 0;
    // Kontrola prihlasenia
    if ($this->id_reg) { //Prihlaseny uzivatel
      if (!$user->isAllowed($this->name, $this->action)) { //Kontrola ACL
        $this->flashRedirect('Homepage:', 'Na požadovanú akciu nemáte dostatočné oprávnenie!', 'danger');
      }
    } else { //Neprihlaseny
      if ($user->getLogoutReason() === User::INACTIVITY) {
        $backlink = $this->getApplication()->storeRequest();
        $this->flashRedirect([':Front:User:', ['backlink' => $backlink]], 'Boli ste príliš dlho neaktívny a preto ste boli odhlásený! Prosím, prihláste sa znovu.', 'danger');
      } else {
        $this->flashRedirect(':Front:User:in', 'Nemáte dostatočné oprávnenie na danú operáciu!', 'danger');
      }
    }
    // Nastavenie z config-u
    $this->nastavenie = $this->context->parameters;
    $modul_presenter = explode(":", $this->name);
    $this->language = 'sk';
    $this->language_id = 1;
    //Nacitanie a spracovanie hlavnych udajov webu
    $this->udaje_webu = $this->udaje->findAll()->fetchPairs('nazov', 'text');
    $vysledok = [];
    //Nacitanie len tych premennych, ktore platia pre danu jazykovu mutaciu
    foreach ($this->udaje_webu as $key => $value) { 
      $kluc = explode("-", $key);
      if (count($kluc) == 2 && $kluc[1] == $this->language) { $vysledok[substr($key, 0, strlen($key)-strlen($this->language)-1)] = $value; } 
      if (count($kluc) == 1) {$vysledok[$key] = $value;}
    }
    $this->udaje_webu = $vysledok;
    // Nacitanie pomocnych premennych
    $this->udaje_webu['meno_presentera'] = strtolower($modul_presenter[1]); //Meno aktualneho presentera
    $httpR = $this->httpRequest->getUrl();
    $this->nazov_stranky = $httpR->host.$httpR->scriptPath; // Nazov stranky v tvare www.nieco.sk
    $this->nazov_stranky = substr($this->nazov_stranky, 0, strlen($this->nazov_stranky)-1);
    // Priradenie hlavnych parametrov a udajov
    $this->max_id_reg = $this->user_roles->findAll()->max('id');//Najdi max. ur. reg.
    //Vypocet max. velkosti suboru pre upload
    $ini_v = trim(ini_get("upload_max_filesize"));
    $s = ['g'=> 1<<30, 'm' => 1<<20, 'k' => 1<<10];
    $this->upload_size =  intval($ini_v) * ($s[strtolower(substr($ini_v,-1))] ?: 1);
    
    $this->prilohy_adresar = "www/files/prilohy/";
    $this->ur_reg = $this->user_roles->vsetky_urovne_array();//Najdi max. ur. reg.
  }
  
  /** Nastevenie premennych pre vsetky sablony */
  public function beforeRender()  {
    $this->getComponent('menu')->selectByUrl($this->link(ucfirst($this->udaje_webu['meno_presentera']).":", isset($this->params["id"]) ? ["id"=>(int)$this->params["id"]] : []));
    $this->template->verzia = $this->verzie->posledna();
    $this->template->nazov_stranky = $this->nazov_stranky;
    $this->template->udaje = array_merge($this->udaje_webu, $this->hlavne_menu->getDBInfo());
    $this->template->urovregistr = $this->id_reg;
    $this->template->lang_menu = $this->lang->findAll();
    $this->template->language = $this->language;
    $this->template->avatar_path = $this->avatar_path;
    $this->template->admin_menu = $this->admin_menu->findAll();
    $this->template->nastavenie = $this->nastavenie;
  }

  //  ---- Komponenty ---- 
    
  /** @return CssLoader */
//  protected function createComponentCss(){
//    return $this->webLoader->createCssLoader('admin');
//  }

  /** @return JavaScriptLoader */
//  protected function createComponentJs(){
//    return $this->webLoader->createJavaScriptLoader('admin');
//  }
  
  /** Komponenta pre výpis css a js súborov
   * @return \PeterVojtech\Base\CssJsFilesControl */
  public function createComponentFiles() {
    return new PeterVojtech\Base\CssJsFilesControl($this->nastavenie['web_files'], $this->name, $this->action);
  }
  
  /** Vytvorenie komponenty pre vypisanie aktualnych oznamov
   * @return \App\AdminModule\Components\Oznam\AktualneOznamyControl */
	public function createComponentAktualne() {
    return $this->aktualneOznamyControlFactory->create();
	}
  
  /** Vytvorenie komponenty pre posledných 25 prihlásení
   * @return \App\AdminModule\Components\User\UserLastControl */
	public function createComponentLast() {
    return $this->userLastControlFactory->create();
	}
  
    /** 
   * Komponenta pre vykreslenie podclankov na kartach
   * @return \App\AdminModule\Components\Clanky\ZobrazKartyPodclankov\ZobrazKartyPodclankovControl */
  public function createComponentZobrazKartyPodclankov() {
    $servise = $this;
//		return new Multiplier(function ($id) use ($servise) {
			$odkaz = $servise->zobrazKartyPodclankovControlFactory->create();
//      $odkaz->setArticle($id, $servise->language_id);
			return $odkaz;
//		});
  }
  
  /** Vytvorenie komponenty pre hlavne menu
   * @return \App\AdminModule\Components\Menu\Menu
   */
  public function createComponentMenu() {
    $menu = new \App\AdminModule\Components\Menu\Menu;
    $hl_m = $this->hlavne_menu->getMenuAdmin($this->id_reg, $this->language_id);
    if ($hl_m !== FALSE) {
      $servise = $this;
      $menu->fromTable($hl_m, function($node, $row) use($servise){
        foreach (["name", "tooltip", "avatar", "anotacia", "node_class", "id", "poradie_podclankov", "datum_platnosti"] as $v) { 
          $node->$v = $row['node']->$v; 
        }
        $node->link = is_array($row['node']->link) ? $servise->link($row['node']->link[0], ["id"=>$row['node']->id]) : $servise->link($row['node']->link);
        return $row['nadradena'] ? $row['nadradena'] : null;
      });
    }
    return $menu;
  }
  
  /**
   * Komponenta Confirmation Dialog pre delete News
   * @return Nette\Application\UI\Form */
  public function createComponentConfirmForm() {
    $form = new PeterVojtech\Confirm\ConfirmationDialog($this->getSession('news'));
    $form->addConfirmer(
        'delete', // názov signálu bude confirmDelete!
        [$this, 'confirmedDelete'], // callback na funkciu pri kliknutí na YES
        [$this, 'questionDelete'] // otázka
    );
    return $form;
  }
  
  /**
   * Zostavenie otázky pre ConfDialog s parametrom
   * @param Nette\Utils\Html $dialog
   * @param array $params
   * @return string $question */
  public function questionDelete($dialog, $params) {
     $dialog->getQuestionPrototype();
     return sprintf("Naozaj chceš zmazať %s '%s'?",
                    isset($params['zdroj_na_zmazanie']) ? $params['zdroj_na_zmazanie'] : "položku",
                    isset($params['nazov']) ? $params['nazov'] : '');
  }
  
	/** 
   * Vypis spravy podla podmienky 
   * @param boolean $if
   * @param string $dobre
   * @param string $zle */
  public function _ifMessage($if, $dobre, $zle) {
    if ($if) { $this->flashMessage($dobre, 'success'); }
    else { $this->flashMessage($zle, 'danger'); }
  }
  
  /** Funkcia pre zjednodusenie vypisu flash spravy a presmerovania
   * @param array|string $redirect Adresa presmerovania
   * @param string $text Text pre vypis hlasenia
   * @param string $druh - druh hlasenia
   */
  public function flashRedirect($redirect, $text = "", $druh = "info") {
		$this->flashMessage($text, $druh);
    if (is_array($redirect)) {
      if (count($redirect) > 1) {
        $this->redirect($redirect[0], $redirect[1]);
      } elseif (count($redirect) == 1) { $this->redirect($redirect[0]);}
    } else { $this->redirect($redirect); }
	}
  /**
   * Funkcia pre zjednodusenie vypisu flash spravy a presmerovania aj pre chybovy stav
   * @param boolean $ok Podmienka
   * @param array|string $redirect Adresa presmerovania
   * @param string $textOk Text pre vypis hlasenia ak je podmienka splnena
   * @param string $textEr Text pre vypis hlasenia ak NIE je podmienka splnena
   */
  public function flashOut($ok, $redirect, $textOk = "", $textEr = "") {
    if ($ok) {
      $this->flashRedirect($redirect, $textOk, "success");
    } else {
      $this->flashMessage($textEr, 'danger');
    }
  }
  
    /**
   * Vytvorenie spolocnych helperov pre sablony
   * @param type $class
   * @return type
   */
  protected function createTemplate($class = NULL) {
    $servise = $this;
    $template = parent::createTemplate($class);
    $template->addFilter('hlmenuclass', function ($id, $id_user_roles, $hl_udaje) {
    	$polozka_class = $id_user_roles>2 ? 'adminPol' : '';
      //TODO $classPol .= ' zvyrazni';
      if ($id == $hl_udaje) { $polozka_class .= ' active'; }
      return $polozka_class;
    });
    $template->addFilter('nahodne', function ($max) { //Generuje nahodne cislo do template v rozsahu od 0 do max
      return (int)rand(0, $max);
    });
    $template->addFilter('uprav_email', function ($email) { //Upravi email aby sa nedal pouzit ako nema
      return Strings::replace($email, ['~@~' => '[@]', '~\.~' => '[dot]']);
    });
    $template->addFilter('textreg', function ($text, $id_user_roles, $max_id_reg) {
      for ($i = $max_id_reg; $i>=0; $i--) {
        $z_zac = "#REG".$i."#"; //Pociatocna znacka
        $z_alt = "#REG-A".$i."#"; //Alternativna znacka
        $z_kon = "#/REG".$i."#";//Koncova znacka
        if (($p_zac = strpos($text, $z_zac)) !== FALSE && ($p_kon = strpos($text, $z_kon)) !== FALSE && $p_zac < $p_kon) { //Ak som našiel začiatok a koniec a sú v správnom poradí
          $text = substr($text, 0, $p_zac) //Po zaciatocnu zancku
                  .(($p_alt = strpos($text, $z_alt)) === FALSE ? // Je alternativa
                   ($i < $id_user_roles ? substr($text, $p_zac+strlen($z_zac), $p_kon-$p_zac-strlen($z_zac)) : '') : // Bez alternativy
                   ($i < $id_user_roles ? substr($text, $p_zac+strlen($z_zac), $p_alt-$p_zac-strlen($z_zac)) : substr($text, $p_alt+strlen($z_alt), $p_kon-$p_alt-strlen($z_alt))))// S alternativou
                  .substr($text, $p_kon+strlen($z_kon)); //Od koncovej znacky
			  } 
      }
      return $text;
    });
    $template->addFilter('vytvor_odkaz', function ($row) use($servise){
      return isset($row->absolutna) ? $row->absolutna :
                          (isset($row->spec_nazov) ? $servise->link($row->druh->presenter.':default',$row->spec_nazov)
                                                   : $servise->link($row->druh->presenter.':default'));
    });
    $template->addFilter('menu_mutacia_nazov', function ($id) use($servise){
      $pom = $servise->hlavne_menu_lang->findOneBy(['id_hlavne_menu'=>$id, 'id_lang'=>$servise->language_id]);
      return $pom !== FALSE ? $pom->nazov : $id;
    });
    $template->addFilter('menu_mutacia_title', function ($id) use($servise){
      $pom = $servise->hlavne_menu_lang->findOneBy(['id_hlavne_menu'=>$id, 'id_lang'=>$servise->language_id]);
      return $pom !== FALSE ? ((isset($pom->view_name) && strlen ($pom->view_name)) ? $pom->view_name : $pom->menu_name) : $id;
    });
    $template->addFilter('menu_mutacia_h1part2', function ($id) use($servise){
      $pom = $servise->hlavne_menu_lang->findOneBy(['id_hlavne_menu'=>$id, 'id_lang'=>$servise->language_id]);
      return $pom !== FALSE ? $pom->h1part2 : $id;
    });
    return $template;
	}
  
  /**
   * Nastavenie vzhľadu formulara
   * @param \Nette\Application\UI\Form $form
   * @return \Nette\Application\UI\Form */
  public function _vzhladForm($form) {
    $renderer = $form->getRenderer();
    $renderer->wrappers['error']['container'] = 'div class="row"';
    $renderer->wrappers['error']['item'] = 'div class="col-md-6 col-md-offset-3 alert alert-danger"';
    $renderer->wrappers['controls']['container'] = NULL;
    $renderer->wrappers['pair']['container'] = 'div class=form-group';
    $renderer->wrappers['pair']['.error'] = 'has-error';
    $renderer->wrappers['control']['container'] = 'div class="col-sm-9 control-field"';
    $renderer->wrappers['label']['container'] = 'div class="col-sm-3 control-label"';
    $renderer->wrappers['control']['description'] = 'span class="help-block alert alert-info"';
    $renderer->wrappers['control']['errorcontainer'] = 'span class="help-block alert alert-danger"';
    // make form and controls compatible with Twitter Bootstrap
    $form->getElementPrototype()->class('form-horizontal');
    foreach ($form->getControls() as $control) {
      if ($control instanceof Controls\Button) {
        $control->getControlPrototype()->addClass(empty($usedPrimary) ? 'btn btn-primary' : 'btn btn-default');
        $usedPrimary = TRUE;
      } elseif ($control instanceof Controls\TextBase || $control instanceof Controls\SelectBox || $control instanceof Controls\MultiSelectBox) {
        $control->getControlPrototype()->addClass('form-control');
      } elseif ($control instanceof Controls\Checkbox || $control instanceof Controls\CheckboxList || $control instanceof Controls\RadioList) {
        $control->getSeparatorPrototype()->setName('div')->addClass($control->getControlPrototype()->type);
      }
    }
    return $form;
  }
  
}