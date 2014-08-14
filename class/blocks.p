@CLASS
blocks

@init[idpage]
$type_block[^hash::sql{select pref_block from text_ext where idpage=$idpage group by pref_block}]
$pidpage($idpage)
^if(def $type_block){

###---Текстовые блоки
	^use[/class/block/btext.p]
	^use[/class/block/bhtml.p]
	^use[/class/block/bparsercode.p]
	
#	^use[/class/block/bmore.p]
#	^use[/class/block/bhr.p]
###---Галереи
#	^use[/class/block/bgallery.p]
#	^use[/class/block/bbanners.p]
#	^use[/class/block/bvideogallery.p]
#	^use[/class/block/bmusic.p]
###---Слайдеры
#	^use[/class/block/bxslider.p]
#	^use[/class/block/bscat.p]
	
###---Тяжелые блоки
#	^use[/class/block/bnews.p]
#	^use[/class/block/bform.p]
#	^use[/class/block/bguestbook.p]
###---Каталог
#	^use[/class/block/bcatalog.p]
#	^use[/class/block/bselectcat.p]


###---Ешё блоки	
#	^use[/class/block/bopros.p]
#	^use[/class/block/bquestion.p]
#	^use[/class/block/btimer.p]
#	^use[/class/block/bsitemap.p]




$brick[
	$.btext[$btext:CLASS]
	$.bhtml[$bhtml:CLASS]
	$.bparsercode[$bparsercode:CLASS]

#	$.bcatalog[$bcatalog:CLASS]
#	$.bgallery[$bgallery:CLASS]
#	$.bnews[$bnews:CLASS]
#	$.bparsercode[$bparsercode:CLASS]
#	$.bsubcat[$bsubcat:CLASS]
#	$.btimer[$btimer:CLASS]
#	$.bvideogallery[$bvideogallery:CLASS]
#	$.bmusic[$bmusic:CLASS]
#	$.bform[$bform:CLASS]
#	$.bhr[$bhr:CLASS]
#	$.bsitemap[$bsitemap:CLASS]
#	$.bslideshow[$bslideshow:CLASS]
#	$.bbxslideshow[$bbxslideshow:CLASS]
#	$.bbanners[$bbanners:CLASS]
#	$.bguestbook[$bguestbook:CLASS]
#	$.bopros[$bopros:CLASS]
#	$.botzyv[$botzyv:CLASS]
#	$.bscat[$bscat:CLASS]
#	$.bselectcat[$bselectcat:CLASS]
#	$.bmore[$bmore:CLASS]
#	$.bgcarousel[$bgcarousel:CLASS]
#	$.brealty[$brealty:CLASS]
#	$.bquestion[$bquestion:CLASS]
#	$.bxslider[$bxslider:CLASS]
]

	$allclasses[^reflection:classes[]]
	^type_block.foreach[key;value]{
		$type_block.$key(^allclasses.contains[$key])
	}
}


@pre_show[]
###используется для подлкючения стилей и скриптов
^type_block.foreach[key;value]{^if($value){^brick.$key.pre_show[]}}

@show[manage_part]
$te_blocks_curent[^table::sql{select * from text_ext where visible='1' and idpage='$pidpage' order by sortir}]
	^if(def $te_blocks_curent){
		^te_blocks_curent.menu{
			$pref_block[$te_blocks_curent.pref_block]
			^if($type_block.$pref_block){
				^brick.$pref_block.show[$te_blocks_curent.id]
			}{
				^if($pref_block eq btarget){
					clASS $pref_block необходимо переписать для увеличения скорости cms
^rem{
					$tableres_target[^table::sql{select * from te_text where id='$te_blocks_curent.id'}]
					$ttb[^table::sql{select * from text_ext where id='$tableres_target.content'}]
					^if(def $ttb){
						$pref_block_target[$ttb.pref_block]
						^brick.$pref_block_target.show[$ttb.id]
					}
}
				}{
					class $pref_block not found
				}
			}
	}
	}




























#^if(-f '/class/block/bcatalog.p'){^use[/class/block/bcatalog.p]}

^rem{
^use[/class/block/bgallery.p]
^use[/class/block/bhtml.p]
^use[/class/block/bnews.p]
^use[/class/block/bparsercode.p]
^use[/class/block/bsubcat.p]
^use[/class/block/btext.p]
^use[/class/block/btimer.p]
^use[/class/block/bvideogallery.p]
^use[/class/block/bmusic.p]
^use[/class/block/bform.p]
^use[/class/block/bhr.p]
^use[/class/block/bsitemap.p]
^use[/class/block/bslideshow.p]
^use[/class/block/bbxslideshow.p]
^use[/class/block/bbanners.p]
^use[/class/block/bguestbook.p]
^use[/class/block/bopros.p]
^use[/class/block/botzyv.p]
#^use[/class/block/btarget.p]
^use[/class/block/bscat.p]
^use[/class/block/bselectcat.p]
^use[/class/block/bmore.p]
^use[/class/block/bgcarousel.p]
^use[/class/block/brealty.p]
^use[/class/block/bquestion.p]
^use[/class/block/bxslider.p]





$brick[
	$.bcatalog[$bcatalog:CLASS]
	$.bgallery[$bgallery:CLASS]
	$.bhtml[$bhtml:CLASS]
	$.bnews[$bnews:CLASS]
	$.bparsercode[$bparsercode:CLASS]
	$.bsubcat[$bsubcat:CLASS]
	$.btext[$btext:CLASS]
	$.btimer[$btimer:CLASS]
	$.bvideogallery[$bvideogallery:CLASS]
	$.bmusic[$bmusic:CLASS]
	$.bform[$bform:CLASS]
	$.bhr[$bhr:CLASS]
	$.bsitemap[$bsitemap:CLASS]
	$.bslideshow[$bslideshow:CLASS]
	$.bbxslideshow[$bbxslideshow:CLASS]
	$.bbanners[$bbanners:CLASS]
	$.bguestbook[$bguestbook:CLASS]
	$.bopros[$bopros:CLASS]
	$.botzyv[$botzyv:CLASS]
#	$.btarget[$btarget:CLASS]
	$.bscat[$bscat:CLASS]
	$.bselectcat[$bselectcat:CLASS]
	$.bmore[$bmore:CLASS]
	$.bgcarousel[$bgcarousel:CLASS]
	$.brealty[$brealty:CLASS]
	$.bquestion[$bquestion:CLASS]
	$.bxslider[$bxslider:CLASS]
]

}

################################################


$tb_block(1)

$subcat(0)
^if(def $form:subcat){$subcat($form:subcat)}
^if($pidpage != $form:p){$subcat(0)}


$idc(0)
^if(def $form:idc){
$idc($form:idc)
$tb_block(0)
}

$idn(0)
^if(def $form:idn){
$idn($form:idn)
$tb_block(0)
}

$idr(0)
^if(def $form:idr){
$idr($form:idr)
$tb_block(0)
}

^if($tb_block==1 || $idpage != $form:p || $pmanage_part ne main){
	$te_blocks_curent[^table::sql{select * from text_ext where manage_part='$pmanage_part' and visible='1' and idpage='$idpage' order by sortir}]
	^if(def $te_blocks_curent){
		^te_blocks_curent.menu{
		<div class="block_$te_blocks_curent.id" style="">
		$pref_block[$te_blocks_curent.pref_block]

			^if(-f "/class/block/${pref_block}.p"){
			^use[/class/block/${pref_block}.p]

				^if($pref_block eq bslideshow){^slideshow_counter.inc[]
				^brick.$pref_block.show[$te_blocks_curent.id;name;$slideshow_counter;$te_blocks_curent.id]
				}{
				^if($pref_block eq bbxslideshow){^bbxslideshow_counter.inc[]
						^brick.$pref_block.show[$te_blocks_curent.id;name;$bbxslideshow_counter;$te_blocks_curent.id]
					}{
						^brick.$pref_block.show[$te_blocks_curent.id]
					}
				}

			}{

				^if($pref_block eq btarget){

				$tableres_target[^table::sql{select * from te_text where id='$te_blocks_curent.id'}]
				$ttb[^table::sql{select * from text_ext where id='$tableres_target.content'}]


					^if($ttb){
					$pref_block_target[$ttb.pref_block]
						^if($pref_block_target eq bslideshow){
						^slideshow_counter.inc[]
						^brick.$pref_block_target.show[$ttb.id;name;$slideshow_counter;$te_blocks_curent.id]
						}{
						^if($pref_block_target eq bbxslideshow){
								^bbxslideshow_counter.inc[]
								^brick.$pref_block_target.show[$ttb.id;name;$bbxslideshow_counter;$te_blocks_curent.id]
							}{
								^brick.$pref_block_target.show[$ttb.id]
							}
						}
					}

				}{
				class $pref_block not found
				}
			}


</div>
			</td>
			</tr>
		}
	</table>



}


}{
#	обрабатываем конкретным блоком

	^if(def $form:idc){
		^if(-f "/class/block/bcatalog.p"){
		^use[/class/block/bcatalog.p]
		^bcatalog:show_one[$form:idc]
		}
	}
	^if(def $form:idn){
		^if(-f "/class/block/bnews.p"){
		^use[/class/block/bnews.p]
		^bnews:show_one[$form:idn]
		}
	}
	
}
