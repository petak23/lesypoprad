<?php

namespace DbTable;
use Nette;

/**
 * Model, ktory sa stara o tabulku slider
 * Posledna zmena 24.05.2017
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2017 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
class Slider extends Table {
  /** @var string */
  protected $tableName = 'slider';

  /**
   * Vrati vsetky polozky z tabulky slider usporiadane podla "usporiadaj"
   * @param string $usporiadaj - názov stlpca, podla ktoreho sa usporiadava a sposob
   * @return Nette\Database\Table\Selection */
  function getSlider($usporiadaj = 'poradie ASC') {
		return $this->findAll()->order($usporiadaj);//->limit($pocet);
	}
  
  /**
   * Vrati nasledujuce cislo poradia
   * @return int */
  public function getNextCounter() {
    $poradie = $this->findAll()->max('poradie');
    return $poradie ? (++$poradie) : 1;
  }

}
