<?php

declare(strict_types=1);

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku faktury
 * 
 * Posledna zmena 05.10.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */
class Faktury extends Table
{
  /** @var string */
  protected $tableName = 'faktury';

  /**
   * Vráti konkrétnu položku s daným id 
   * @param int $id Id položky */
  public function getItem(int $id): array
  {
    $p = $this->find($id)->toArray();
    return $p;
  }


  /** Vráti všetky položky ako pole */
  public function getItemsArray(int $id_hlavne_menu): array
  {
    $t = $this->findBy(['id_hlavne_menu' => $id_hlavne_menu]);
    $o = [];
    foreach ($t as $p) {
      $o[] = $p->toArray();
    }
    return $o;
  }

  /**
   * Zpracovanie požiadavky na zmazanie.
   * @param $id Id mazaného súboru. 
   * @return bool Ak zmaže alebo neexistuje(nie je co mazat) tak true inak false */
  public function removeFile(int $id): bool
  {
    $pr = $this->find($id);
    if ($pr !== null) {
      $o = $this->deleteFile($pr->main_file)
        ? (in_array(strtolower($pr->pripona), ['png', 'gif', 'jpg'])
          ? $this->deleteFile($pr->thumb_file) : true)
        : false;
      if ($o) {
        $pr->delete();
        return true;
      }
    }
    return false;
  }
}
