<?php

try {

}
catch(Exception $e){
    header('x', true, 404);
    echo '404 page not found.';
}