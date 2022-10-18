<?php

namespace App\FrontModule\Presenters;

use Nette\Application as NA;
use Tracy\Debugger;

/**
 * Prezenter pre smerovanie na chybove stranky.
 * Posledna zmena(last change): 18.10.2022
 *
 *	Modul: FRONT
 *
 * @author Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version 1.0.5
 *
 */
class ErrorPresenter extends BasePresenter
{

	/**
	 * @param  Exception
	 * @return void
	 */
	public function renderDefault($exception)
	{
		if ($this->isAjax()) { // AJAX request? Just note this error in payload.
			$this->payload->error = TRUE;
			$this->terminate();
		} elseif ($exception instanceof NA\BadRequestException) {
			$code = $exception->getCode();
			$code_a = in_array($code, array(403, 404, 405, 410, 500)) ? $code : '4xx';
			$this->template->h2 = $this->texty_presentera->translate('err_' . $code_a . '_h2');
			$this->template->text = $this->texty_presentera->translate('err_' . $code_a . '_text');
			$this->template->err_code = "error " . $code_a;
			$this->setView($code == 500 ? "500" : "400");
			// log to access.log
			Debugger::log("HTTP code $code: {$exception->getMessage()} in {$exception->getFile()}:{$exception->getLine()}", 'access');
		} else {
			$this->setView('500'); // load template 500.latte
			Debugger::log($exception, Debugger::ERROR); // and log exception
		}
	}
}
