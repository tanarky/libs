<?php

// 変数名汚染を可能な限り少なくしたinclude
if(!function_exists('include0')){
    function include0($N){
        include($N);
    }
}
// inc()に直接的に1つだけ渡すverson
if(!function_exists('include1')){
    function include1($N, $M=array()){
        include($N);
    }
}
if(!function_exists('issetor')){
    function issetor(&$e, $def){
        return (isset($e) ? $e : $def);
    }
}
if(!function_exists('emptyor')){
    function emptyor(&$e, $def){
        return (empty($e) ? $e : $def);
    }
}
if(!function_exists('emptystr')){
    function emptystr(&$e){
        return ((isset($e) && $e && is_scalar($e) && !is_bool($e)) ? false:true);
    }
}
if(!function_exists('emptystror')){
    function emptystror(&$e, $def){
        return (!emptystr($e) ? $e : $def);
    }
}
