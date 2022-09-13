<?php

namespace DbTable;

use Nette;
use Nette\Database\Table\ActiveRow;
use Nette\Utils\Strings;


/**
 * Reprezentuje repozitar pre databázovu tabulku
 * 
 * Posledna zmena(last change): 15.06.2022
 * 
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.1.9
 */
abstract class Table
{

  use Nette\SmartObject;

  /** @var Nette\Database\Explorer */
  protected $connection;

  /** @var Nette\Security\User */
  protected $user;

  /**
   * @param Nette\Database\Explorer $db
   * @throws Nette\InvalidStateException */
  public function __construct(Nette\Database\Explorer $db)
  {
    $this->connection = $db;
    if ($this->connection === NULL) {
      $class = get_class($this);
      throw new Nette\InvalidStateException("Nemám pripojenie na DB!");
    }
    if ($this->tableName === NULL) {
      $class = get_class($this);
      throw new Nette\InvalidStateException("Názov tabuľky musí byť definovaný v $class::\$tableName.");
    }
  }

  /** 
   * Vracia celu tabulku z DB
   * @return Nette\Database\Table\Selection */
  protected function getTable()
  {
    if ($this->connection === NULL) {
      throw new Nette\InvalidStateException("Nemám pripojeniena DB!");
    }
    return $this->connection->table($this->tableName);
  }

  /** 
   * V poli vrati info o jednotlivych stlpcoch tabulky
   * @return array */
  /*public function getTableColsInfo(): array {
    $pom = $this->connection->getConnection()->getSupplementalDriver()->getColumns($this->tableName);
    $out = [];
    foreach ($pom as $key => $value) {
      $out[$key] = $value["vendor"];
    }
    return $out;
  }*/

  /** 
   * Funkcia v poli vrati zakladne info. o pripojeni.
   * @return array */
  public function getDBInfo(): array
  {
    $pom = explode(";", $this->connection->getConnection()->getDsn()); // Rozlozi text na host a dbname napr. "mysql:host=localhost:8111;dbname=d264787_echomsz"
    $out = [];
    foreach ($pom as $p) {
      $t = explode("=", $p);
      $x = explode(":", $t[0]);
      if (is_array($x) && count($x) == 2) {
        $out[$x[1]] = $t[1];
      } else {
        $out[$t[0]] = $t[1];
      }
    }
    return $out;
  }

  /** 
   * Vracia vsetky zaznamy z DB
   * @return Nette\Database\Table\Selection */
  public function findAll()
  {
    return $this->getTable();
  }

  /** 
   * Vracia vyfiltrovane zaznamy na zaklade vstupneho pola
   * @param string|string[] $by 
   * @return Nette\Database\Table\Selection */
  public function findBy($by)
  {
    return $this->getTable()->where($by);
  }

  /** 
   * Rovnak ako findBy ale vracia len jeden zaznam
   * @param string|string[] $by
   * @return ActiveRow|null */
  public function findOneBy($by): ?ActiveRow
  {
    return $this->findBy($by)->limit(1)->fetch();
  }

  /** 
   * Vracia zaznam s danym primarnym klucom
   * @param mixed $id primary key
   * @return ActiveRow|null */
  public function find($id): ?ActiveRow
  {
    return $this->getTable()->get($id);
  }

  /** 
   * Hlada jednu polozku podla specifickeho nazvu a min. urovne registracie uzivatela
   * @param string $spec_nazov Specificky nazov
   * @param int $id_reg Min. uroven registracie 
   * @return ActiveRow|null */
  public function hladaj_spec(string $spec_nazov, int $id_reg = 5): ?ActiveRow
  {
    return $this->findOneBy(["spec_nazov" => $spec_nazov, "id_user_roles <= " . $id_reg]);
  }

  /** 
   * Hlada jednu polozku podla id a min. urovne registracie uzivatela
   * @param int $id Id polozky
   * @param int $id_reg Min. uroven registracie
   * @return ActiveRow|null */
  public function hladaj_id(int $id = 0, int $id_reg = 5): ?ActiveRow
  {
    return $this->findOneBy(["id" => $id, "id_user_roles <= " . $id_reg]);
  }

  /** 
   * Zmeni spec nazov na '-' ak min. uroven registracie uzivatela suhlasi
   * @param string $spec_nazov Specificky nazov
   * @param int $id_reg Min. uroven registracie */
  public function delSpecNazov(string $spec_nazov, int $id_reg)
  {
    $this->hladaj_spec($spec_nazov, $id_reg)->update(['spec_nazov' => '-']);
  }

  /** 
   * Funkcia skontroluje a priradi specificky nazov pre polozku
   * @param string $nazov nazov clanku
   * @return string */
  public function najdiSpecNazov(string $nazov): string
  {
    //Prevedie na tvar pre URL s tym, ze _ akceptuje
    $spec_nazov = Strings::webalize($nazov, '_');
    $pom = 0;
    if ($this->hladaj_spec($spec_nazov)) {
      do {
        $pom++;
      } while ($this->hladaj_spec($spec_nazov . $pom));
    }
    return $spec_nazov . ($pom == 0 ? '' : $pom);
  }

  /** 
   * Prida zaznam(y) do tabulky
   * @param  array|\Traversable|Selection array($column => $value)|\Traversable|Selection for INSERT ... SELECT
   * @return ActiveRow|int|bool Returns IRow or number of affected rows for Selection or table without primary key */
  public function pridaj($data)
  {
    return $this->getTable()->insert($data);
  }

  /** 
   * Opravy v tabulke zaznam s danym id
   * @param mixed $id primary key
   * @param iterable (column => value)
   * @return ActiveRow|null */
  public function repair($id, $data): ?ActiveRow
  {
    $this->find($id)->update($data); //Ak nieco opravil tak true inak(nema co opravit) false
    return $this->find($id);
  }

  /**
   * @deprecated use repair */
  public function oprav($id, $data): ?ActiveRow
  {
    return $this->repair($id, $data);
  }

  /** 
   * Funkcia pridava alebo aktualizuje v DB podla toho, ci je zadané ID
   * @param iterable $data
   * @param mixed $id primary key
   * @return ActiveRow|int|bool */
  public function uloz($data, $id = 0)
  {
    return $id ? $this->repair($id, $data) : $this->pridaj($data);
  }

  /**
   * Zmaze v tabulke zaznam s danym id
   * @param mixed $id primary key
   * @return int return number of affected rows */
  public function zmaz($id): int
  {
    return isset($id) ? $this->find($id)->delete() : 0;
  }

  /** 
   * Funkcia vymaze subor ak exzistuje
   * @param string $subor Nazov suboru aj srelativnou cestou
   * @return bool Ak zmaze alebo neexistuje(nie je co mazat) tak true inak false */
  public function deleteFile(string $file): bool
  {
    return (is_file($file)) ? unlink($file) : true;
  }
}
