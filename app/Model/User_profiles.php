<?php

namespace DbTable;

/**
 * Model, ktory sa stara o tabulku user_profiles
 * 
 * Posledna zmena 13.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.9
 */
class User_profiles extends Table {
  
  const
    COLUMN_LOG_IN_DATE_TIME = 'prihlas_teraz',
    COLUMN_LOG_IN_COUNTER = 'pocet_pr';  
  
  /** @var string */
  protected $tableName = 'user_profiles';

  /**
   * Aktualizuje datum a cas prihlasenia
   * @param id $id Id uzívatela*/
  private function logInDatetime($id) {
    $this->find($id)->update([ self::COLUMN_LOG_IN_DATE_TIME => date("Y-m-d H:i:s", Time())]);
  }
  
  /**
   * Aktualizuje pocitadlo prihlaseni
   * @param id $id Id uzívatela*/
  private function logInCounter($id) {
    $user_profile = $this->find($id);
    $log_in_counter = ($user_profile->{self::COLUMN_LOG_IN_COUNTER} + 1);
    $user_profile->update([ self::COLUMN_LOG_IN_COUNTER => $log_in_counter]);
  }
  
  /**
   * Spolocna funkcia pre aktualizacie po prihlaseni
   * @param id $id Id uzívatela*/
  public function updateAfterLogIn($id) {
    $this->logInDatetime($id);
    $this->logInCounter($id);
  }
  
  /**
   * Funkcia zisti max a sum prihlásenia
   * @return array max a sum pocet prihlaseni
   */
  function getPocetPr() {
		return ['max'=>$this->findAll()->max('pocet_pr'), 'sum'=>(int)$this->findAll()->sum('pocet_pr')];
	}
  
  /**
   * Funkcia na zostavenie pola emailov podla urovne registracie pre odoslanie info mailu. 
   * @param int $id_user_roles Minimalna uroven registracie
   * @return array Pole emailou s dvoma castami "komu" - retazec emilov oddelených ciarkami; "clen" - arra emailov
   */
  public function emailUsersList($id_user_roles = 5) {
    $cl = $this->findBy(['id_user_roles >='.$id_user_roles, 'news'=>'A']);
    $out = ["clen"=>[],"komu"=>""];
    $sum = count($cl); $iter = 0;
    foreach ($cl as $c) {
      $iter++;
      if ($c->users->email != '---') {
        $out["komu"] .= $sum == $iter ? $c->users->email : $c->users->email.', '; 
        $out["clen"][] = $c->users->email;
      }
    }
    return $out;
  }

  /**
   * Funkcia na zostavenie ratazca emailov podla urovne registracie pre odoslanie info mailu. 
   * @param int $id_user_roles Minimalna uroven registracie
   * @return sring Retazec emailov oddelených ciarkami
   */
  public function emailUsersListStr($id_user_roles = 5) {
    $cl = $this->findBy(['id_user_roles >='.$id_user_roles, 'news'=>'A']);
    $out = "";
    $sum = count($cl); $iter = 0;
    foreach ($cl as $c) {
      $iter++;
      if ($c->users->email != '---') {
        $out .= $sum == $iter ? $c->users->email : $c->users->email.', '; 
      }
    }
    return $out;
  }
  
  /** Pre zmazanie aktivít uzivatela
   * @param int $clen_id_up
   * @throws Database\DriverException
   */
  public function delUser($clen_id_up) {
    try {
      $this->connection->table('user_prihlasenie')->where(['id_user_main'=>$clen_id_up])->delete();
//      $this->connection->table('dokumenty')->where(['id_user_main'=>$clen_id_up])->update(['id_user_main'=>1]);
//      $this->connection->table('oznam')->where(['id_user_main'=>$clen_id_up])->update(['id_user_main'=>1]);
      $this->connection->table('verzie')->where(['id_user_main'=>$clen_id_up])->update(['id_user_main'=>1]);
      $this->zmaz($clen_id_up);
    } catch (Exception $e) {
      throw new Database\DriverException('DB error: '.$e->getMessage());
    }
  }
  
  /**
   * @param Nette\Utils\ArrayHash $values
   * @return Nette\Database\Table\ActiveRow|FALSE
   * @throws Nette\Database\DriverException */
  public function saveUser($values) {
    try {
      $id = (int)$values->id;
      unset($values->id);
      return $this->uloz($values, $id);
    } catch (Exception $e) {
      throw new Database\DriverException('Chyba ulozenia: '.$e->getMessage());
    }
  }
}