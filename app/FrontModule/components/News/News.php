<?php
namespace App\FrontModule\Components\News;
use Nette;
use DbTable;
use Language_support;

/**
 * Komponenta pre zobrazenie aktualnych noviniek pre FRONT modul
 * Posledna zmena(last change): 27.11.2019
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2019 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.2
 */
class NewsControl extends Nette\Application\UI\Control {
  /** @var \Nette\Database\Table\Selection */
  private $news;
  /** @var Language_support\LanguageMain Prednastavene texty pre komponentu */
  private $texty;

  /**
   * @param DbTable\News $news
   * @param DbTable\Lang $lang */
  public function __construct(DbTable\News $news, DbTable\Lang $lang) {
    parent::__construct();
    $this->news = $news->findAll()->order("created DESC")->limit(5);
    $this->texty = new Language_support\LanguageMain($lang);
  }
  
  /** Nastavenie aktualneho jazyka
   * @param string|int $language Skratka jazyka alebo jeho id */
  public function setLanguage($language) {
    // Nacitanie základných textov z neon suboru podla jazyka
    $this->texty->setLanguage($language);
    return $this;
  }

  public function render() {
    $this->template->setFile(__DIR__ . '/News.latte');
    $this->template->news = $this->news;
    $this->template->setTranslator($this->texty);
    $this->template->render();
  }
}

interface INewsControl {
  /** @return NewsControl */
  function create();
}