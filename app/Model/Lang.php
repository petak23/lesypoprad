<?php

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku lang
 * 
 * Posledna zmena 06.06.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.5
 */
class Lang extends Table {
  /** @var string */
  protected $tableName = 'lang';

  /** Vracia vsetky akceptovane jazyky
   * @return \Nette\Database\Table\Selection */
  public function akceptovane() {
    return $this->findBy(["prijaty"=>1]);
  }
}