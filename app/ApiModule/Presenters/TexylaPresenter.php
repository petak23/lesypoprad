<?php
declare(strict_types=1);

namespace App\ApiModule\Presenters;

use Nette\Application\Responses\TextResponse;
use Texy;

/**
 * Prezenter pre pristup k api editácie textu.
 * Posledna zmena(last change): 10.05.2022
 *
 * Modul: API
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.0
 * 
 * @help 1.) https://forum.nette.org/cs/28370-data-z-post-request-body-reactjs-appka-se-po-ceste-do-php-ztrati
 */
class TexylaPresenter extends BasePresenter {

  /** @var Texy\Texy @inject */
	public $texy;

  
  /** Akcia vráti náhľad editovaného textu */
  public function actionPreview(): void {
    $_post = json_decode(file_get_contents("php://input"), true); // @help 1.)

    $this->sendResponse(new TextResponse($this->texy->process($_post["texy"] != null ? $_post["texy"] : "")));
  }
}