<?php

require dirname(__DIR__).'/vendor/autoload.php';

Testbench\Bootstrap::setup(__DIR__ . '/_temp', function (\Nette\Configurator $configurator) {
    $configurator->createRobotLoader()->addDirectory([
        __DIR__ . '/../app',
    ])->register();

    $configurator->addParameters([
        'appDir' => __DIR__ . '/../app',
        'testsDir' => __DIR__,
    ]);

    $configurator->addConfig(__DIR__ . '/../app/config/config.neon');
    if(file_exists(__DIR__ . '/../app/config/config.local.neon')){
      $configurator->addConfig(__DIR__ . '/../app/config/config.local.neon');
    }
    $configurator->addConfig(__DIR__ . '/test.neon');
});
