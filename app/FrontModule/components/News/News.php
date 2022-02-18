<?php
namespace App\FrontModule\Components\News;
use Nette;
use DbTable;
use Language_support;

/**
 * Komponenta pre zobrazenie aktualnych noviniek pre FRONT modul
 * Posledna zmena(last change): 18.02.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.1
 *
 */
class NewsControl extends Nette\Application\UI\Control {
  /** @var \Nette\Database\Table\Selection */
  private $news;
  /** @var Language_support\LanguageMain Prednastavene texty pre komponentu */
  private $texty;

  /** @param DbTable\News $news */
  public function __construct(DbTable\News $news, Language_support\LanguageMain $lang_supp) {
    parent::__construct();
    $this->news = $news->findAll();
    $this->texty = $lang_supp;
    
  }

  public function render() {
    $this->template->setFile(__DIR__ . '/News.latte');
    $this->template->news = $this->news;
    $this->template->texty = $this->texty;
    $this->template->render();
  }
  
}

interface INewsControl {
  /** @return NewsControl */
  function create();
}