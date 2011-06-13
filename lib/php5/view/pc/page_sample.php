<?php
$ro        = new readonly();
$layout    = $ro->get("layout");
$recommend = $ro->get("recommend");
?><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>YUI Base Page</title>
    <link rel="stylesheet" href="http://yui.yahooapis.com/2.8.0r4/build/reset-fonts-grids/reset-fonts-grids.css" type="text/css">
  </head>
  <body class="yui-skin-sam">
    <div id="doc2" class="yui-t2">
      <div id="hd">
<?php
foreach($layout['top'] as $m){
    $module_file = FW_ROOT. '/view/pc/mod_'. $m[1].'.php';
    if(!$m[3]){
        include0($module_file);
    }
    else {
        $page_key = ($m[4]) ? '' : $m[0];
        $data_key = implode('/',array($page_key, $m[1], $m[2]));
        include1($module_file, $recommend[$data_key]);
    }
}
?>
      </div>
      <div id="bd">
        <div id="yui-main">
          <div class="yui-b">
            <div class="yui-g">
              <!-- CENTER -->
<?php
foreach($layout['center'] as $m){
    $module_file = FW_ROOT. '/view/pc/mod_'. $m[1].'.php';
    if(!$m[3]){
        include0($module_file);
    }
    else {
        $page_key = ($m[4]) ? '' : $m[0];
        $data_key = implode('/',array($page_key, $m[1], $m[2]));
        include1($module_file, $recommend[$data_key]);
    }
}
?>
              <!-- /CENTER -->
            </div>
          </div>
        </div>
        <div class="yui-b">
          <!-- LEFT -->
<?php
foreach($layout['left'] as $m){
    $module_file = FW_ROOT. '/view/pc/mod_'. $m[1].'.php';
    if(!$m[3]){
        include0($module_file);
    }
    else {
        $page_key = ($m[4]) ? '' : $m[0];
        $data_key = implode('/',array($page_key, $m[1], $m[2]));
        include1($module_file, $recommend[$data_key]);
    }
}
?>
          <!-- /LEFT -->
        </div>
      </div>
      <div id="ft">
<?php
foreach($layout['bottom'] as $m){
    $module_file = FW_ROOT. '/view/pc/mod_'. $m[1].'.php';
    if(!$m[3]){
        include0($module_file);
    }
    else {
        $page_key = ($m[4]) ? '' : $m[0];
        $data_key = implode('/',array($page_key, $m[1], $m[2]));
        include1($module_file, $recommend[$data_key]);
    }
}
?>
      </div>
    </div>
  </body>
</html>
