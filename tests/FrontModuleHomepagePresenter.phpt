<?php

namespace Tests;

use Tester\Assert;

require __DIR__.'/bootstrap.php';

/**
 * @testCase
 */
class HomepagePresenter extends \Tester\TestCase {
  
  use \Testbench\TPresenter;
//  use \Testbench\TNetteDatabase;
  
//  public function testDatabase(){
//      $em = $this->getContext();
//      //Tester\Assert::...
//  }
  public function testRenderDefaultModule() {
    $this->checkAction('Front:Homepage:default');
//    $this->checkAction('Front:Homepage:notAllowed');
  }
  
}

(new HomepagePresenter())->run();