<?php

if(!function_exists('inc')){
    function inc($N){
        if(!file_exists($N)) return;
        include($N);
    }
}
if(!function_exists('issetor')){
    function issetor(&$e, $def){
        return (isset($e) ? $e : $def);
    }
}
if(!function_exists('')){
    function emptyor(&$e, $def){
        return (empty($e) ? $e : $def);
    }
}
if(!function_exists('')){
    function emptystror(&$e, $def){
        return ((is_scalar($e) && !is_bool($e)) ? $e : $def);
    }
}
