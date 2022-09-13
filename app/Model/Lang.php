<?php
namespace DbTable;

use Nette\Database\Table\Selection;

/**
 * Model, ktory sa stara o tabulku lang
 * 
 * Posledna zmena 30.03.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.6
 */
class Lang extends Table {
  /** @var string */
  protected $tableName = 'lang';

  /** Vracia vsetky akceptovane jazyky */
  public function akceptovane(): Selection {
    return $this->findBy(["prijaty"=>1]);
  }

  public function getLngId(string $sk = "sk"): int {
    return $this->findOneBy(['skratka'=>$sk])->id;
  }
}