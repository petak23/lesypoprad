<?php
declare(strict_types=1);

namespace DbTable;

use Nette\Database;
use Nette\Utils\ArrayHash;
/**
 * Model, ktory sa stara o tabulku verzie
 * 
 * Posledna zmena 06.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
class Verzie extends Table {
  /** @var string */
  protected $tableName = 'verzie';

  /** Vrati vsetky verzie v poradi od najnovsej */
  public function vsetky(): Database\Table\Selection {
    return $this->getTable()->order('modified DESC');
  }

  /** Vrati najnovsiu verziu */
  public function posledna(): ?Database\Table\ActiveRow {
    return $this->vsetky()->limit(1)->fetch();
  }
  
  /** Ulozi verziu
   * @throws Database\DriverException */
  public function ulozVerziu(ArrayHash $values): ?Database\Table\ActiveRow  {
    try {
      $id = isset($values->id) ? $values->id : 0;
      unset($values->posli_news, $values->id);
      return $this->uloz($values, $id);
    } catch (Exception $e) {
      throw new Database\DriverException('Chyba ulozenia: '.$e->getMessage());
    }
  }
}
