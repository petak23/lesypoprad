<?php
declare(strict_types=1);

namespace App\FrontModule\Components\Clanky\Attachments;

use DbTable;
use Language_support;
use Nette\Application\Responses\FileResponse;
use Nette\Application\Responses\RedirectResponse;
use Nette\Application\UI\Control;
use Nette\Database\Table;

/**
 * Komponenta pre zobrazenie príloh clanku pre FRONT modul
 * 
 * Posledna zmena(last change): 13.05.2020
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2020 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.1.4
 */
class AttachmentsControl extends Control {

  /** @var DbTable\Dokumenty */
  private $prilohy;
  /** @var Language_support\LanguageMain */
  public $texts;
  /** @var int */
  private $article;
  /** @var string */
  private $avatar_path;
  /** @var Nette\Database\Table\Selection|FALSE */
  private $attachments = NULL;

  /**
   * @param string $dir_to_menu Cesta k adresaru pre ukladanie obrazkov menu od www adresara - Nastavenie priamo cez servises.neon
   * @param DbTable\Dokumenty $dokumenty
   * @param Language_support\LanguageMain $texts */
  public function __construct(string $dir_to_menu, DbTable\Dokumenty $dokumenty, Language_support\LanguageMain $texts) {
    $this->prilohy = $dokumenty;
    $this->texts = $texts;
    $this->avatar_path = $dir_to_menu;
  }

  /** 
   * Nastavenie id polozky, ku ktorej patria prilohy
   * @param Nette\Database\Table\ActiveRow $article Polozka menu ku ktorej je priradeny
   * @param string $language Skratka jazyka
   * @return \App\FrontModule\Components\Clanky\PrilohyClanok\PrilohyClanokControl  */
  public function setNastav(Table\ActiveRow $article, string $language) {
    $this->article = $article;
    $this->texts->setLanguage($language);
    return $this;
  }

  /** 
   * Render
   * @param array $params Parametre
   * @param string $template Druh template */
  public function render(array $params = [], string $template = '') {
    $template = ($template != '' ? "_" : "").$template;
    $template_f = isset($params['templateFile']) ? $params['templateFile'] : "Attachments";
    $template_file = (is_file(__DIR__ ."/".$template_f.$template.".latte") ? $template_f.$template : "Attachments_default");
    $this->template->setFile(__DIR__ . "/".$template_file.".latte");
    $this->template->prilohy = $this->attachments != NULL ? $this->attachments : $this->prilohy->getViditelnePrilohy($this->article->id_hlavne_menu);
    $this->template->texts = $this->texts;
    $this->template->setTranslator($this->texts);
    $this->template->avatar_path = $this->avatar_path;
    $this->template->id_hlavne_menu_lang = $this->article->id;
    $this->template->big_img_id = isset($params['big_img_id']) ? $params['big_img_id'] : 0;
    $this->template->render();
  }
  
  /**
   * Render pre obrazky
   * @param array $params */
  public function renderImages(array $params = []) {
    $this->attachments = $this->prilohy->getVisibleImages($this->article->id_hlavne_menu);
    $this->render($params, 'images');
  }
  
  /**
   * Render pre ostatne typy suborov
   * @param array $params */
  public function renderOthers(array $params = []) {
    $this->attachments = $this->prilohy->getVisibleOther($this->article->id_hlavne_menu);
    $this->render($params, 'others');
  }
  
  /**
   * Render pre videa
   * @param array $params */
  public function renderVideos(array $params = []) {
    $this->attachments = $this->prilohy->getVisibleVideos($this->article->id_hlavne_menu);
    $this->render($params, 'videos');
  }
  
  /** 
   * Render pre audio subory
   * @param array $params */
  public function renderAudios(array $params = []) {
    $this->attachments = $this->prilohy->getVisibleAudios($this->article->id_hlavne_menu);
    $this->render($params, 'audios');
  }

  /**
   * Signal pre odoslanie súboru na stiahnutie
   * @param int $id Id dokumentu */
  public function handleFileDownload(int $id) {
    if (($dokument = $this->prilohy->find($id)) === FALSE) {
      $this->error($this->texts->translate('dokument_not_found')); 
    }
    if (!is_file($dokument->main_file)) {
      $this->error($this->texts->translate('dokument_not_found'));
    }
		$dokument->update(['pocitadlo'=>$dokument->pocitadlo + 1]);
    try {
      $response = new FileResponse($dokument->main_file, $dokument->name.".".$dokument->pripona, 'application/'.$dokument->pripona);
      $this->presenter->sendResponse($response);
    } catch (\Nette\Application\BadRequestException $ex) {
      $this->presenter->flashMessage('dokument_not_found', "danger");
    }  
  }
  
  /**
   * Signal pre odoslanie súboru na zobrazenie
   * @param int $id Id dokumentu */
  public function handleFileView(int $id) {
    if (($dokument = $this->prilohy->find($id)) === FALSE) {
      $this->error($this->texts->translate('dokument_not_found')); 
    }
    if (!is_file($dokument->main_file)) {
      $this->error($this->texts->translate('dokument_not_found'));
    }
		$dokument->update(['pocitadlo'=>$dokument->pocitadlo + 1]);
    try {
      $response = new RedirectResponse("http://".$this->presenter->nazov_stranky."/".$dokument->main_file);
      $this->presenter->sendResponse($response);
    } catch (\Nette\Application\BadRequestException $ex) {
      $this->presenter->flashMessage('dokument_not_found', "danger");
    }
  }
}

interface IAttachmentsControl {
  /** @return AttachmentsControl */
  function create();
}
