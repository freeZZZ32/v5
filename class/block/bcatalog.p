@CLASS
bcatalog

@show[iid]
^use[/class/scroller.p]
$tmpl_path[^include_tmpl_path[]]

^include_tobuy[]

#Настройки каталога
$set[
^rem{
	Заголовок категорий товаров	Каталог	head_cmenu	0	bcatalog	text	10	1
	Изменить	Удалить	25	Показывать категории товаров	1	show_folder	0	bcatalog	checkbox	20	1
	Изменить	Удалить	26	Учитывать количество товаров на сайте	0	type_kolvo	0	bcatalog	checkbox	40	1
}	
	$type_kolvo(0)
	$view_variant(0)
	
	
	$.show_folder(^int:sql{select value from te_opt where id_te='$iid' and name='show_folder' and type_block='bcatalog' limit 1}[$.default(1)])
	$.show_tobuy(^int:sql{select value from te_opt where id_te='$iid' and name='show_tobuy' and type_block='bcatalog' limit 1}[$.default(1)])
	$.show_kolvo(^int:sql{select value from te_opt where id_te='$iid' and name='show_kolvo' and type_block='bcatalog' limit 1}[$.default(1)])
	$.height_folder(^int:sql{select value from te_opt where id_te='$iid' and name='height_folder' and type_block='bcatalog' limit 1}[$.default(230)])
	$.height_tovar(^int:sql{select value from te_opt where id_te='$iid' and name='height_tovar' and type_block='bcatalog' limit 1}[$.default(340)])
	$.height_image(^int:sql{select value from te_opt where id_te='$iid' and name='height_image' and type_block='bcatalog' limit 1}[$.default(150)])
#	$.show_inmenu(^int:sql{select value from te_opt where id_te='$iid' and name='show_inmenu' and type_block='bcatalog' limit 1}[$.default(1)])
]

$show_tobuy(^int:sql{select value from te_opt where id_te='$iid' and name='tobuy' limit 1}[$.default(0)])
$show_kolvobuy(^int:sql{select value from te_opt where id_te='$iid' and name='showkolvo' limit 1}[$.default(0)])

$thisrealpage(^int:sql{select idpage from text_ext where id='$iid' limit 1}[$.default(0)])
$url[^curpage_url[$thisrealpage]]




$namecatalog[^string:sql{select name from bcatalog where id='$form:idc' limit 1}[$.default[]]]
^if(def $namecatalog){<h1>$namecatalog</h1>}

^if(def $form:idc){$idc($form:idc)}{$idc(0)}

###верхний текст
#^untaint{^string:sql{select top_text from catalog_text where idpage='$iid' and idcatalog='$idc'}[$.default{}]}

$catalog_sort[sortir]
$catalog_colshow(60)
^if(def $form:bcatpage){$cpage($form:bcatpage)}{$cpage(1)}
<div style="clear:both^; padding-top:5px^;"></div>
^showsortform[$iid;$idc;1;1;1]





$tableres[^table::sql{select * from bcatalog where idblock='$iid' and parent='$idc' and visible='1' order by type, $catalog_sort}[^if($catalog_colshow==0){}{$.limit($catalog_colshow) $.offset(^eval($cpage*$catalog_colshow-$catalog_colshow))}]]
^if($tableres){

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">

$folder(1)

	^tableres.menu{

#			Цены!!!!!
^rem{
		^if($tableres.type == 1){
		$price_variant(^int:sql{select count(id) from bcatalog_variant where id_tov='$tableres.id'})
		^if($price_variant > 0){ 
			$pricenow(^double:sql{select price from bcatalog_variant where id_tov='$tableres.id' and main='1'}[$.default(0)])
			$priceold(^double:sql{select old_price from bcatalog_variant where id_tov='$tableres.id' and main='1'}[$.default(0)])
			
			^if($pricenow == 0){
				$pricenow_t[^table::sql{select price, id from bcatalog_variant where id_tov='$tableres.id' and price IS NOT NULL order by price limit 1}]
				$pricenow($pricenow_t.price)
				$priceold(^double:sql{select old_price from bcatalog_variant where id_tov='$tableres.id' and id='$pricenow_t.id' and old_price IS NOT NULL}[$.default(0)])
			}

		}{
			^if($tableres.price){$pricenow($tableres.price)}{$pricenow(0)}
			^if($tableres.old_price){$priceold($tableres.old_price)}{$priceold(0)}
		}
		}
}
		$priceold($tableres.old_price)
		$pricenow($tableres.price)
		
		$avatar[^string:sql{select path from dop_gallery where dop_type='bcatalog' and dop_id='$tableres.id' and avatar='1' limit 1}[$.default{}]]
		^if(def $avatar){$sgid_img[/images/bcatalog/s_${avatar}]}{
			^if($tableres.type == 1){
			$sgid_img[$tmpl_path/cms/tovar.png]
			}{
			$sgid_img[$tmpl_path/cms/subcat.png]
			}
		}



		^if($folder == 1 && $tableres.type == 1){
			$folder(0)
			<div style="clear: both"></div>
		}

		<div id="div_bcatalog_${tableres.id}" class="block_elm" style="overflow:hidden^;width:214px^;height:^if($tableres.type == 1){340}{230}px^;background-color:#transparent^;padding:4px^;margin-bottom:20px^;border: 1px solid #ccc^;">
		<table width="100%" cellpadding=0 cellspacing=0 border=0>
		<tr>
			<td align=center>

				<a href="$url/^catalog_url[$tableres.id]/" ^if(def $tableres.head){class="tip"} ^if(def $tableres.head){title="$tableres.head"} style="text-decoration:none">
				<div style="width:200px^;height:150px^;background-image: url($sgid_img)^;padding:0px^;margin-bottom:7px^;text-align:left^;background-repeat:no-repeat">
					<div style="position:relative^;top:120px^;left:0px^;padding:5px^;width:130px^;height:30px">
						

						^if($priceold > 0  && $tableres.type == 1){
							<span class="tipa_h3" style="color:#ff6666^; background-color:#ffffff">
							<nobr>&nbsp^;<s>
							^if($priceold%1 == 0){$priceold}{^priceold.format[%.2f]} </s> 
							<span class="rur">p<span>уб.</span></span>&nbsp^;</nobr></span>
						}
					</div>

					^if($tableres.novinka > 0){<div style="position:relative^;top:0px^;left:5px^;padding:1px^;"><span class="cat_novinka">&nbsp^;Новинка&nbsp^;</span></div>}
					^if(def $tableres.akciya){<div style="position:relative^;top:0px^;margin:0px^;left:5px^;padding:1px^;"><span class="cat_akciya">&nbsp^;$tableres.akciya&nbsp^;</span></div>}


				</div>
				</a>

			</td>
		</tr>
			
		<tr>
			<td align=center>
				<div style="overflow:hidden^;width:215px^;height:40px^;">
					<a href="$url/^catalog_url[$tableres.id]/" class="tipa_h3" ^if(def $tableres.head){title="$tableres.head"}>$tableres.name</a>
				</div>
			</td>
		</tr>

		^if($tableres.type == 1){
		<tr><td>
			^if($pricenow > 0){
				<table width="100%" cellpadding=1 cellspacing=0 border=0><tr>
					<td width="100%" colspan=2 align=center>
						<span class="tipa_h1"><nobr>^if( $pricenow%1 == 0){$pricenow}{^pricenow.format[%.2f]} <span class="rur">p<span>уб.</span></span></nobr></span>		
					</td></tr>
				^if($price_variant > 0){
					<tr><td colspan="2" align="center"><a href="$url/^catalog_url[$tableres.id]/"><img src="$tmpl_path/cms/variant.png"  width=96 height=35 border=0 class="png" alt=""></a></td></tr>
					
				}{ 
					^if($show_tobuy == 1){
						<tr>
						^if($show_kolvobuy==1){
							<td width="110px" align=right>Кол-во: <input class="spinner" name="kolvo"  id="kolvo_fld_${tableres.id}_0"  value=1 style="width:28px" maxlength=6 ></td>
							<td align="center" class="buy" onclick="buytovar('$tableres.id',0)" ><img src="$tmpl_path/cms/buy.png"  width=96 height=35 border=0 class="png" alt=""></td>	
							
						}{
							<td align="center" class="buy" colspan="2" onclick="buytovar('$tableres.id',0)"><img src="$tmpl_path/cms/buy.png"  width=96 height=35 border=0 class="png" alt=""></td>
						}
						</tr>
					}
				}
				</table>
			}
		
		</td></tr>
	

		<tr><td>
			<hr size=1 noshade color=#cccccc>
			^if(def $tableres.edizm){<p class="p11">Единица измерения: <span class="cat_kod">$tableres.edizm</span></p>}
			^if(def $tableres.kod){<p class="p11">Код товара: <span class="cat_kod">$tableres.kod</span></p>}
			^if(def $tableres.artikul){<p class="p11">Артикул: <span class="cat_kod">$tableres.artikul</span></p>}
			^if(def $tableres.madein){<p class="p11">Производитель: <span class="cat_kod">$tableres.madein</span></p>}
		</td></tr>
		}
		</table>
		</div>
	}

}


<div style="clear:both^;"></div>

^showsortform[$iid;$idc;0;0;1]

#нижний текст
#^untaint{^string:sql{select bottom_text from catalog_text where idpage='$iid' and idcatalog='$idc'}[$.default{}]}




@show_one[idc]
^include_tobuy[]
$tmpl_path[^include_tmpl_path[]]
$url[^curpage_url[]]


<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">


<script type="text/javascript">


^$(document).ready(function() {
	^$(".fancybox").fancybox({
		prevEffect	: 'none',
		nextEffect	: 'none',
		openEffect	: 'elastic',
		closeEffect	: 'elastic',
		helpers	: {
			title	: {
				type: 'outside'
			},
			thumbs	: {
				width	: 50,
				height	: 50
			}
		}
	})^;
})^;
</script>

$one_rec[^table::sql{select * from bcatalog where id='$idc' and visible='1'}]
^if($one_rec){

	^if($one_rec.type == 0){
		^self.show[$one_rec.idblock]
	}{
#		### 	Опции каталога
		
		$show_tobuy(^int:sql{select value from te_opt where id_te='$one_rec.idblock' and name='tobuy' limit 1}[$.default(0)])
		$show_kolvobuy(^int:sql{select value from te_opt where id_te='$one_rec.idblock' and name='showkolvo' limit 1}[$.default(0)])
		$show_variantlist(^int:sql{select value from  global_setting where name='showvariantlist' limit 1}[$.default(0)])
		
#		###	Цены!!!!!		
		$checkchild(^int:sql{select count(id) from bcatalog where parent='$idc'})
		$price_variant(^int:sql{select count(id) from bcatalog_variant where id_tov='$one_rec.id'})

		$avatar[^string:sql{select path from dop_gallery where dop_type='bcatalog' and dop_id='$one_rec.id' and avatar='1'}[$.default{}]]
		^if(def $avatar){
			$sgid_img[/images/bcatalog/s_${avatar}]
		}{
			$sgid_img[$tmpl_path/cms/tovar.png]
		}

		
		
		
		<table width="100%" cellpadding=0 cellspacing=0 border=0>
		<tr><td valign=top>
			<div style="float:left^; padding: 0 15px 20px 0px" id="tovar_avatar">
			^if(def $avatar){
				<div><a class="fancybox" rel="cat_gallery_$idc" href="/images/bcatalog/b_${avatar}"><img src="$sgid_img" border=0 alt=""></a></div>
				<p class="p11" align="center">Нажмите на фото, чтобы увеличить</p>
			}{
				<img src="$sgid_img" border=0 alt="">
			}
			<p></p>
			</div>

			<div id="tovar_name"><h1>$one_rec.name</h1></div>
			
#			$pricenow(^double:sql{select price from bcatalog_variant where id_tov='$tableres.id' and main='1'}[$.default(0)])
#			$priceold(^double:sql{select old_price from bcatalog_variant where id_tov='$tableres.id' and main='1'}[$.default(0)])
			
#			^if($pricenow == 0){
#				$pricenow_t[^table::sql{select price, id from bcatalog_variant where id_tov='$tableres.id' and price IS NOT NULL order by price limit 1}]
#				$pricenow($pricenow_t.price)
#			}

#			$price_tovar_n[$one_rec.price]
#			$price_tovar_o[$one_rec.old_price]
			
#			^if($price_variant > 0){$prices_variant[^table::sql{select price, old_price from bcatalog_variant where id_tov='$tableres.id' and main='1']}
#			^if($checkchild>0){$prices_child[^table::sql{select price, old_price from bcatalog_variant where id_tov='$tableres.id' and main='1']}
			
#			$prices[
#				$.tovar($one_rec.price)
#				$.variant(^if($price_variant > 0){^double:sql{select price from bcatalog_variant where id_tov='$tableres.id' and main='1'}[$.default(0)]}{0})
#				$.child(^if($checkchild>0){}{0})
#				$.childvariant(^if($checkchild>0){}{0})
#			]
			
#			^if($checkchild>0){
#				$price_now(0)
#				$price_old(0)
#			}{
#				$price_now(0)
#				$price_old(0)
#			}
#			
			
#			<div id="tovar_price">	Цена $price_now  </div> <br>




	^if($price_variant > 0 ){
		$price_t[^table::sql{select price, old_price, name,id from bcatalog_variant where id_tov='$one_rec.id'}]
		^if(def $price_t){
			^if($show_variantlist == 0){
				<table>
				^price_t.menu{
						^if(!def $form:idv || ($form:idv == $price_t.id)){
						<tr>
							<td width="160px"><a href="?idv=$price_t.id" style="text-decoration:none^;"><span class="tipa_h3">$price_t.name</span></a></td>
							^if($price_t.price>0){
								<td>^if($price_t.old_price != 0){<nobr><span class="tipa_h3" style="color:red^; text-decoration:line-through^;">^if($price_t.old_price%1==0){$price_t.old_price}{^price_t.old_price.format[%.2f]} <span class="rur">p</span></span>&nbsp^;&nbsp^;</nobr>}</td>
								<td><span class="tipa_h1"><nobr>^if($price_t.price %1==0){$price_t.price}{^price_t.price.format[%.2f]} <span class="rur">p<span>уб.</span></span></nobr></span></td>
								^if($show_tobuy == 1){
									^if($show_kolvobuy==1){
										<td width="60px" align=right><input class="spinner" name="kolvo"  id="kolvo_fld_${one_rec.id}_${price_t.id}"  value=1 style="width:28px" maxlength=6 ></td>
						 			}
						 			<td class="buy" onclick="buytovar('$one_rec.id',$price_t.id)"><img src="$tmpl_path/cms/buy.png"  width=96 height=35 border=0 class="png" alt=""></td>	
								}
							}{<td colspan='4'>&nbsp^;</td>}
						</tr>
						}
				}
				</table>
			}{
				<table><tr><td>
				<select id="price_variant" onchange='show_variant_price()^;'>
					^price_t.menu{
						<option value="$price_t.id" ^if($form:idv==$price_t.id){selected}>$price_t.name</option>
					}
				</select></td>
				<td>
					^price_t.menu{
						^if(def $show_idvariant){}{^if(def $form:idv){$show_idvariant($form:idv)}{$show_idvariant($price_t.id)}}
						
					^if($price_t.price>0){
						<table id="price_var_table_$price_t.id" class="price_var_table" cellpadding=2 cellspacing=0 border=0 ^if($show_idvariant == $price_t.id){}{style="display:none^;"}><tr>
						<td>^if($price_t.old_price != 0){<nobr><span class="tipa_h3" style="color:red^; text-decoration:line-through^;">^if($price_t.old_price%1==0){$price_t.old_price}{^price_t.old_price.format[%.2f]} <span class="rur">p</span></span>&nbsp^;&nbsp^;</nobr>}</td>
						<td><span class="tipa_h1"><nobr>^if($price_t.price %1==0){$price_t.price}{^price_t.price.format[%.2f]} <span class="rur">p<span>уб.</span></span></nobr></span></td>
								
						^if($show_tobuy == 1){
							^if($show_kolvobuy==1){
								<td width="60px" align=right><input class="spinner" name="kolvo"  id="kolvo_fld_${one_rec.id}_${price_t.id}"  value=1 style="width:28px" maxlength=6 ></td>
							}
							<td class="buy" onclick="buytovar('$one_rec.id',$price_t.id)"><img src="$tmpl_path/cms/buy.png"  width=96 height=35 border=0 class="png" alt=""></td>	
						}
						
						</tr></table>
					}
					}
				</td></tr></table>
				
				<script type="text/javascript">	
					function show_variant_price(){
						var idpricevariant = ^$("#price_variant").val()^;
						^$(".price_var_table").hide()^;
						^$("#price_var_table_"+idpricevariant).show()^;
					}
				</script>	
						
			}
		}
			
	}{
		^if($one_rec.price > 0){
		<table width="210px" cellpadding=1 cellspacing=0 border=0>
		<tr>
		<td width="100%" colspan=2 align=left>
		^if($one_rec.old_price > 0){	
			<span class="tipa_h3" style="color:red^; text-decoration:line-through^;"><nobr>^if($one_rec.old_price%1==0){$one_rec.old_price}{^one_rec.old_price.format[%.2f]} <span class="rur">p</span></nobr></span>&nbsp^;&nbsp^;
		}
		<span class="tipa_h1" id="tovar_price"><nobr>^if($one_rec.price %1==0){$one_rec.price}{^one_rec.price.format[%.2f]} <span class="rur">p<span>уб.</span></span></nobr></span>		
		</td>
		</tr>
			^if($show_tobuy == 1){
			<tr>
				^if($show_kolvobuy==1){
				<td width="110px" align=right>Кол-во: <input class="spinner" name="kolvo"  id="kolvo_fld_${one_rec.id}_0"  value=1 style="width:28px" maxlength=6 ></td>
				}
				<td ^if($show_kolvobuy==1){align=right}{align=center colspan="2"} class="buy" onclick="buytovar('$one_rec.id',0)" ><img src="$tmpl_path/cms/buy.png"  width=96 height=35 border=0 class="png" alt=""></td>	
			</tr>
			}
		</table>
		}
	}


<div>

^if(def $one_rec.edizm){<p class="p11" id="tovar_edizm">Единица измерения: <span class="cat_kod">$one_rec.edizm</span></p>}
^if(def $one_rec.kod){<p class="p11" id="tovar_kod">Код товара: <span class="cat_kod">$one_rec.kod</span></p>}
^if(def $one_rec.artikul){<p class="p11" id="tovar_artikul">Артикул: <span class="cat_kod">$one_rec.artikul</span></p>}
^if(def $one_rec.madein){<p class="p11" id="tovar_madein">Производитель: <span class="cat_kod">$one_rec.madein</span></p>}

^if($one_rec.novinka > 0){<p><span class="cat_novinka" id="tovar_novinka">&nbsp^;Новинка&nbsp^;</span></p>}
^if(def $one_rec.akciya){<p><span class="cat_akciya" id="tovar_akciya">&nbsp^;$one_rec.akciya&nbsp^;</span></p>}

</div>

^show_child[$one_rec.id]


^untaint{$one_rec.content}
#^untaint{^one_rec.content.match[\n][g]{<br>}}


</td></tr>
</table>

####################################

		$gallery[^table::sql{select path from dop_gallery where dop_type='bcatalog' and dop_id='$one_rec.id' and avatar='0'}]
		^if($gallery){


<p class="tipa_h3">Фотогалерея</p>
<div id="photogaller">
			^gallery.menu{
<div style="float:left^;padding:2px^;width:124px^;height:124px">
<a class="fancybox" rel="cat_gallery_$idc" href="/images/bcatalog/b_${gallery.path}"><img src="/images/bcatalog/ss_${gallery.path}" border=0 class="png" alt=""></a>
</div>
			}
</div>
		}

####################################

	$tbl_video[^table::sql{select * from videos where id_te='$one_rec.id' and module='bcatalog' and enable=1 order by sortir}]
	^if(def $tbl_video){
<div style="clear: both"></div>
<p class="tipa_h3">Видеоролики</p>
		^tbl_video.menu{
<div style="float:left^;padding:2px^;overflow:hidden">
<iframe width="420" height="340" src="$tbl_video.src" frameborder="0" allowfullscreen></iframe>
<p>$tbl_video.name</p>
<hr size=1 noshade color=#cccccc>
</div>
		}
	}



	}
}




@showsortform[iid;idc;showsort;showallcolvo;showcolvo]
$resp[$request:uri]
$catsortpath[/class/block/bcatalog/sortcookie.html?resp=^resp.base64[]]


	
^if(def $cookie:catsort){
	^if($cookie:catsort eq name){$catalog_sort[name]}
	^if($cookie:catsort eq price_asc){$catalog_sort[price asc]}
	^if($cookie:catsort eq price_desc){$catalog_sort[price desc]}
	^if($cookie:catsort eq default || (!def $catalog_sort)){$catalog_sort[sortir]}
	
}{
	$catalog_sort[sortir]
}
	
^if(def $cookie:catcolshow){
	^if($cookie:catcolshow == 90){$catalog_colshow(90)}
	^if($cookie:catcolshow == 150){$catalog_colshow(150)}
	^if($cookie:catcolshow == 0){$catalog_colshow(0)}
	^if($cookie:catcolshow == 60 || (!def $catalog_colshow)){$catalog_colshow(60)}
	
}{
	$catalog_colshow(60)
}	
	
	
	
$resp[$request:uri]
$catsortpath[/class/block/bcatalog/sortcookie.html?resp=^resp.base64[]]

$counttovar_all(^int:sql{select count(*) from bcatalog where idblock='$iid' and visible='1' and type='1'})
$counttovar_cur(^int:sql{select count(*) from bcatalog where idblock='$iid' and parent='$idc' and visible='1' and type='1'})
$countall_cur(^int:sql{select count(*) from bcatalog where idblock='$iid' and parent='$idc' and visible='1'})

^if($countall_cur > 0){

	^if($showsort == 1 && $countall_cur > 1){
		<div>
		<span class="catalog_scrool_text"><span class="color_marker">Сортировать по:</span> &nbsp^;</span> 
			<a href="$catsortpath&catsort=default" 		class="^if($cookie:catsort eq 'default'){catalog_scrool_text_a}{catalog_scrool_text}">умолчанию</a> <span>&nbsp^;|&nbsp^;</span>
			^if($cookie:catsort eq 'price_asc'){
				<a href="$catsortpath&catsort=price_desc"  	class="^if($cookie:catsort eq 'price_asc'){catalog_scrool_text_a}{catalog_scrool_text}">цене <img src="$tmpl_path/i/scroller/top_tr.png" width="10px" height="10px" alt=""></a><span>&nbsp^;|&nbsp^;</span>
			}{
				<a href="$catsortpath&catsort=price_asc"  	class="^if($cookie:catsort eq 'price_desc'){catalog_scrool_text_a}{catalog_scrool_text}">цене  ^if($cookie:catsort eq 'price_desc'){<img src="$tmpl_path/i/scroller/bottom_tr.png" width="10px" height="10px" alt="">}</a><span >&nbsp^;|&nbsp^;</span>
	
			}
			<a href="$catsortpath&catsort=name" 		class="^if($cookie:catsort eq 'name'){catalog_scrool_text_a}{catalog_scrool_text}">наименованию</a>
		
	
		</div>
	}


<table width="100%">	
<tr>	
^if($showallcolvo ==1){	
	^if($counttovar_cur == 0){}{	
		<td class="catalog_scrool_text" width="100px"><div style="display:inline-block^; padding-right:5px^; border-right:1px solid #999999">Товаров: $counttovar_cur </div> </td>
	}
}
<td width="200px">
	^if(def $catalog_colshow){
		^if($catalog_colshow!=0){
			^scroller:catalog_scroller[^math:ceiling(^eval(${countall_cur}/$catalog_colshow))]
		}
	}
</td>	

<td align="right">	
^if($showcolvo ==1 && $countall_cur > 59){	
	<span class="catalog_scrool_text"><span class="color_marker">Товаров на странице:</span> &nbsp^;</span>
	<a href="$catsortpath&catcolshow=60" 	class="^if($catalog_colshow == 60){catalog_scrool_text_a}{catalog_scrool_text}">60</a>&nbsp^;
 	^if($countall_cur > 89){
		<a href="$catsortpath&catcolshow=90" 	class="^if($catalog_colshow == 90){catalog_scrool_text_a}{catalog_scrool_text}">90</a>&nbsp^;
	}
	^if($countall_cur > 149){
		<a href="$catsortpath&catcolshow=150"  	class="^if($catalog_colshow == 150){catalog_scrool_text_a}{catalog_scrool_text}">150</a>&nbsp^;
	}
	<a href="$catsortpath&catcolshow=0"  	class="^if($catalog_colshow == 0){catalog_scrool_text_a}{catalog_scrool_text}">все</a>&nbsp^;
}


</td></tr></table>	


}


@show_price[t_price]




@show_child[id_child]
<style>
	div.child_selectable{
		margin:3px^;
		border:2px #ffce00 solid^;
	}
	
	div.child_selectable_off{
		border:2px #ffffff solid^;
		
	}
	
	div.child_selectable_on{
		margin:3px^;
		border:2px #ffce00 solid^;
	}
</style>
		$one_rec_child[^table::sql{select * from bcatalog where parent='$id_child' and type='2' and visible='1' order by sortir}]
		$view_dopprice(0)
		$view_child(0)
		^if(def $one_rec_child){
			^one_rec_child.menu{
				^if($view_child==0){
				$gallery[^table::sql{select path from dop_gallery where dop_type='bcatalog' and dop_id='$one_rec_child.id' and avatar='1'}]
				<a href="?newurl=$one_rec_child.url" onclick="return change_subtovar($one_rec_child.id)^;">
					<div id="childdiv_$one_rec_child.id" style="float:left^;width:50px^;height:50px^;" class="child_selectable child_selectable_off">	
						<img src="^if(def $gallery){/images/bcatalog/ss_${gallery.path}}{/i/nophoto170.gif}" width="50px" border=0 class="png" alt="$one_rec_child.name" title="$one_rec_child.name">
					</div>
				</a>
				}{
					<a href="?newurl=$one_rec_child.url" onclick="return change_subtovar($one_rec_child.id)^;" style="text-decoration:none^;"><div style="display:inline-block^; padding: 2px 5px^; border:#333333 1px solid">
						$one_rec_child.name
					</div></a>
				}
			
					

				
			}
			
			<div style="clear:both^;"></div>
		}
<script>
	
function change_subtovar(id){
	var nextchild^;
	^$.ajax({
		url: "/class/block/bcatalog/subtovar.html",
		data: ({form_id : id
		}),
		scriptCharset: "utf-8" ,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success: function(msg){
			^$(".child_selectable").removeClass("child_selectable_on")^;
			^$("#childdiv_"+id).addClass("child_selectable_on")^;
#			alert(msg)^;			
			nextchild=JSON.parse(msg)^;
			^$("#tovar_name").html(nextchild.name)^;
			^$("#tovar_avatar").html(nextchild.avatar)^;

		}
	})^;
	
	 
	return false^;
}	



</script>



















	
@include_tobuy[]
<style type="text/css">
	.buy{cursor:hand^;cursor:pointer^;}
</style>
	
<script type="text/javascript">
^$(function() {
	^$(".spinner").inputmask({ "mask": "9", "repeat": 10, "greedy": false})^;
	
	^$( ".spinner" ).spinner({
		spin: function( event, ui ) {
			if ( ui.value < 1 ) {
			^$( this ).spinner( "value", 1 )^;
			return false^;
			} 
		}
	})^;
})^;




function number_ins_up(id){
	var kolvo=^$("#"+id).val()^;
	kolvo=kolvo.replace(/[^^0-9]/g,"")^;
	if(kolvo==''){
		^$("#"+id).val('1')^;
	}{
		^$("#"+id).val(kolvo)^;
	}
	
}	
function number_ins(id){
	var kolvo=^$("#"+id).val()^;
	kolvo=kolvo.replace(/[^^0-9]/g,"")^;
	if(kolvo==0||kolvo==''){
		^$("#"+id).val('1')^;
	}else{
		^$("#"+id).val(kolvo)^;
	}
	
}

function show_variant_price(){
	alert("Сменить цену")^;
	^$("#span_oldprice").text("1")^;
	^$("#span_price").text("1")^;
}

</script>	
	
	
