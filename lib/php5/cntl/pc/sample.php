<?php
if(!defined('FW_ROOT')) exit('no constant FW_ROOT');

class cntl_pc_sample
{
    public function run(){
        $ro = new readonly();

        // get layout
        $ro->set('layout',
                 array(
                     'top' => array(
                         array('index','basic', 0,0,0), // page_key,module_name,unique_id,has_data,is_runof
                         array('index','header',0,0,0),
                         ),
                     'center' => array(
                         array('index','notice',1,1,1),
                         ),
                     'left' => array(),
                     'bottom' => array(
                         array('index','footer',0,0,0),
                         ),
                     ));

        // get recommend
        $ro->set('recommend',
                 array(
                     "catrec_20/promo/0" => array('title'=>'foo0'),
                     "catrec_20/promo/1" => array('title'=>'foo1'),
                     "/notice/0" => array('title'=>'bar0'),
                     "/notice/1" => array('title'=>'bar1'),
                     ));

        // get category
        $ro->set('category',
                 array(
                     array(
                         'id' => 1,
                         'jtitle' => 'ルート',
                         'etitle' => 'root',
                         'items'  => 600,
                         'has_recommend' => 0,
                         'children' => array(
                             array(
                                 'id' => 10,
                                 'jtitle' => 'カテゴリ10',
                                 'etitle' => 'category10',
                                 'items'  => 100,
                                 'has_recommend' => 0,
                                 ),
                             array(
                                 'id' => 20,
                                 'jtitle' => 'カテゴリ20',
                                 'etitle' => 'category20',
                                 'items'  => 200,
                                 'has_recommend' => 1,
                                 ),
                             array(
                                 'id' => 30,
                                 'jtitle' => 'カテゴリ30',
                                 'etitle' => 'category30',
                                 'items'  => 300,
                                 'has_recommend' => 1,
                                 ),
                             ),
                         ),
                     ));

        include0(FW_ROOT. '/view/pc/page_sample.php');
    }
}