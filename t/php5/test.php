<?php

$path = dirname( __FILE__ ). "/../../lib/php5/readonly.php";
if(file_exists($path)){
    require_once($path);
    error_log('test issetor: '. issetor($b, "abc"));
}
else{
    error_log('no file:'. $path);
}

$g = array('user' => array('name'=>'tanarky', 'sex'=>'male'));
readonly::set_all($g);
var_dump(readonly::get('user'));
readonly::set_one('user', array('name'=>'hoge', 'sex'=>'female'));
var_dump(readonly::get('user'));
