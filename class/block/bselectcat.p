@CLASS
bselectcat

@show[iid]
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

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
$te_bselectcat[^table::sql{select id, name from te_bselectcat where idblock='$iid' and visible='1' order by sortir}]
^if($te_bselectcat){
	^te_bselectcat.menu{
		<p class="tipa_h1">$te_bselectcat.name</p>
		$show_id[^table::sql{select id_bcatalog,text_tovar from te_bselectcat_show where id_bselectcat='$te_bselectcat.id' order by sortir}]
		^if($show_id){
			^show_id.menu{
				
				^show_catalog[$show_id.id_bcatalog;$show_id.text_tovar]
			}
		}
	}
}

<div style="clear:both^;"></div>

@show_catalog[id_catalog;text_tovar]
$tmpl_path[^include_tmpl_path[]]
$tableres[^table::sql{select * from bcatalog where id="$id_catalog"}]
^if($tableres){
$thisrealpage(^int:sql{select idpage from text_ext where id='$tableres.idblock' limit 1}[$.default(0)])
$url[^curpage_url[$thisrealpage]]

$show_tobuy(^int:sql{select value from te_opt where id_te='$tableres.idblock' and name='tobuy' limit 1}[$.default(0)])
$show_kolvobuy(^int:sql{select value from te_opt where id_te='$tableres.idblock' and name='showkolvo' limit 1}[$.default(0)])
$folder(1)
	^tableres.menu{
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
#			<div style="clear: both"></div>
		}

		<div id="div_bcatalog_${tableres.id}" class="block_elm" style="overflow:hidden^;width:214px^;height:^if($tableres.type == 1){340}{230}px^;background-color:#transparent^;padding:4px^;margin-bottom:20px^;border: 1px solid #ccc^;">
		<table width="100%" cellpadding=0 cellspacing=0 border=0>
		<tr>
			<td align=center>

				<a href="$url/^catalog_url[$tableres.id]/" ^if(def $tableres.head){class="tip"} ^if(def $tableres.head){title="$tableres.head"} style="text-decoration:none">
				<div style="width:200px^;height:150px^;background-image: url($sgid_img)^;background-position: 50% 50%^;padding:0px^;margin-bottom:7px^;text-align:left^;background-repeat:no-repeat">
					<div style="position:relative^;top:120px^;left:0px^;padding:5px^;width:130px^;height:30px">
	
						^if($priceold > 0  && $tableres.type == 1){
							<span class="tipa_h3" style="color:#ff6666^; background-color:#ffffff">
							<nobr>&nbsp^;<s>
							^if($priceold%1 == 0){$priceold}{^priceold.format[%.2f]} </s> 
							<span class="rur">p<span>уб.</span></span>&nbsp^;</nobr></span>
						}
					</div>
					^if(def $text_tovar){$akciya[$text_tovar]}{$akciya[$tableres.akciya]}

					^if($tableres.novinka > 0){<div style="position:relative^;top:0px^;left:5px^;padding:1px^;"><span class="cat_novinka">&nbsp^;Новинка&nbsp^;</span></div>}
					^if(def $akciya){<div style="position:relative^;top:0px^;margin:0px^;left:5px^;padding:1px^;"><span class="cat_akciya">&nbsp^;$akciya&nbsp^;</span></div>}


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

