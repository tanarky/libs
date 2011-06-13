<?php
require_once('utils.php');

class readonly
{
    private static $_body   = null;
    private static $_locked = false;
    public function set_all($val){
        if(self::$_locked) return;
        self::$_body = $val;
    }
    public function set($key, $val){
        if(self::$_locked) return;
        self::$_body[$key] = $val;
    }
    public function get($key){
        if(!self::$_locked) self::lock();
        return issetor(self::$_body[$key], null);        
    }
    public function lock(){
        self::$_locked = true;
    }
}