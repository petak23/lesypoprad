<?php

namespace DbTable;

use Nette;

/**
 * Model starajuci sa o tabulku hlavne_menu_lang
 * 
 * Posledna zmena 13.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.1.5
 */
class Hlavne_menu_lang extends Table {
  const 
    NOT_EXIST = 1,
    MISSING_PERMISSIONS = 2;
  
  /** @var string */
  protected $tableName = 'hlavne_menu_lang';
    
  /** Funkcia pre ziskanie info o konkretnom clanku na zaklade spec_nazov, language_id 
	  * a min. urovne registracie uzivatela
		* @param string $spec_nazov - specificky nazov clanku v hl. menu
		* @param int $language_id - id jazykovej mutacie clanku. Ak nemam tak 1 - sk
		* @param int $id_user_roles - min. uroven registracie uzivatela. Ak nemam tak sa berie 5
		* @return Nette\Database\Table\ActiveRow
    * @throws ArticleExteption */
	public function getOneArticleSp(string $spec_nazov, int $language_id = 1, int $id_user_roles = 5) {
    $articles = clone $this;
		//Najdi v tabulke hlavne_menu polozku podla spec. nazvu a urovne registracie
    $tmp_article = $articles->getTable()->where(["hlavne_menu.spec_nazov" => $spec_nazov, "id_lang" => $language_id]);
    if ($tmp_article->count() == 0) {
      throw new ArticleMainMenuException("Article not exist", self::NOT_EXIST);
    } else { // Article found
      $tmp_article_final = $tmp_article->where("hlavne_menu.id_user_roles <= ?", $id_user_roles)->fetch();
      if ($tmp_article_final === null) {
        throw new ArticleMainMenuException("Missing permissions", self::MISSING_PERMISSIONS);
      } else {
        return $tmp_article_final;
      }
    }
  }
  
  /** 
   * Funkcia pre ziskanie info o konkretnom clanku na zaklade id, language_id 
	 * a min. urovne registracie uzivatela
	 * @param int $id_hlavne_menu Id polozky v tabulke "hlavne_menu"
	 * @param int $id_lang Id jazykovej mutacie clanku v tabulke "lang". Ak nemam tak 1 - sk. 
	 * @param int $id_user_roles Min. uroven registracie uzivatela. Ak nemam tak sa berie 0 - guest
	 * @return Nette\Database\Table\ActiveRow
   * @throws ArticleExteption */
  public function getOneArticleId(int $id_hlavne_menu,int $id_lang = 1, int $id_user_roles = 0) {
    $articles = clone $this;
    //Najdi v tabulke hlavne_menu polozku podla id
    $tmp_article = $articles->getTable()->where(["id_hlavne_menu" => $id_hlavne_menu, "id_lang" => $id_lang]);
    if ($tmp_article->count() == 0) {
      throw new ArticleMainMenuException("Article not exist", self::NOT_EXIST);
    } else { // Article found
      $tmp_article_final = $tmp_article->where("hlavne_menu.id_user_roles <= ?", $id_user_roles)->fetch();
      if ($tmp_article_final == null) {
        throw new ArticleMainMenuException("Missing permissions", self::MISSING_PERMISSIONS);
      } else {
        return $tmp_article_final;
      }
    }
  }
  
  /**
   * Funkcia pre ulozenie textov clanku */
  public function ulozTextClanku(Nette\Utils\ArrayHash $values): void {
    $uloz_txt = [];
    foreach ($values as $k => $v) {
      $a = explode("_", $k, 2);
      // Ak v texte a anotacii je len prazdny text, tak uloz null
      $uloz_txt[$a[0]][$a[1]] = in_array($a[1], ["text", "anotacia"]) ? (strlen($v) ? $v : null) : $v;
    }
		$utc = count($uloz_txt);
    foreach($uloz_txt as $ke => $ut){
      $cid = $ut["id"];
      unset($ut['id']);
      $uloz_t = $this->uloz($ut, $cid);
    }
  }
  
  /** 
   * Ulozi texty pre tabulku hlavne_menu_lang
   * @param Nette\Utils\ArrayHash $values
   * @param Nette\Database\Table\Selection $jazyky
   * @param int $id
   * @return bool */
  public function ulozPolozku(Nette\Utils\ArrayHash $values, Nette\Database\Table\Selection $jazyky, int $id = 0): bool {
    $ulozenie = 0;
    foreach($jazyky as $j){
      foreach(["menu_name", "h1part2", "view_name"] as $f){
        $new = $values->{$j->skratka."_".$f};
        $ut[$f] = strlen($new) ? $new : NULL;
      }
      $hlid = $values->{$j->skratka."_id"};
      if ($hlid == 0)  { //pridavam
        $ut["id_lang"] = $j->id;
        $ut["id_hlavne_menu"] = $id;
      }
      if ($this->uloz($ut, $hlid) !== FALSE) { //Ulozenie v poriadku
        $ulozenie++;
      }
    }
    return ($ulozenie == count($jazyky));
  }
  
  /**
   * Pre danu polozku vrati len platne podclanky
   * @param int $id_lang Id jazyka
   * @param int $id_nadradenej
   * @return Nette\Database\Table\Selection */
  public function subArticleToView(int $id_lang, int $id_nadradenej) {
    return $this->findBy(["id_lang"=>$id_lang, "hlavne_menu.id_nadradenej"=>$id_nadradenej])
                ->where("datum_platnosti ? OR datum_platnosti >= ? ", NULL, date("Y-m-d",strtotime("0 day")));
  }

  public function saveText(int $id_hlavne_menu, int $id_lang, $text) {
    return $this->findOneBy(['id_hlavne_menu'=>$id_hlavne_menu, 'id_lang'=>$id_lang])
                ->update(['text'=>$text]);
  }
}

/**
 * Exception for a unique constraint violation.
 */
class ArticleMainMenuException extends Nette\Database\ConstraintViolationException {}
