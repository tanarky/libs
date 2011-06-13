<?php
define('FW_ROOT', '/usr/share/tanarky/php5');
require(FW_ROOT. '/utils.php');
require(FW_ROOT. '/readonly.php');

try {
    if(emptystr($_GET['cntl'])){
        throw new Exception('no input[controller]');
    }
    $ro = new readonly();
    $device = 'pc';
    if(emptystror($_GET['device'], '') === 'smartphone'){
        $device = 'smartphone';
    }
    $ro->set('device', $device);
    $file_name = implode('/', array(FW_ROOT, 'cntl', $device, $_GET['cntl'].".php"));
    if(!file_exists($file_name)){
        throw new Exception('no controller file:'. $file_name);
    }
    require($file_name);

    $class_name = implode('_', array('cntl', $device, $_GET['cntl']));
    if(!class_exists($class_name)){
        throw new Exception('no controller class:'. $class_name);
    }
    $o = new $class_name();
    $o->run();
}
catch(Exception $e){
    header('x', true, 404);
    echo '404 page not found:'. $e->getMessage();
}