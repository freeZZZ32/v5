@CLASS
bscat

@show[iid]
	$tmpl_path[^include_tmpl_path[]]
	
	$tableres[^table::sql{select * from te_bscat where block='$iid' and visible='1' order by sortir}]
	^if(def $tableres){
		^tableres.menu{
#<div style="width:^eval($tableres.width+5)px^; float:left^;margin:5px">
#<p class="tipa_h2">$tableres.name</p>
			<div class="bxslider_cat" id="bxslider_cat_${tableres.id}" ^if(def ${tableres.width}){style="width:${tableres.width}px^;"}>

			$slide[^table::sql{select * from te_bscat_slide where bscat='$tableres.id' order by id}]
			^if(def $slide){
				^slide.menu{
			
					<div style="padding:5px 0^;">
#					style="width:${tableres.width_slide}px^;padding:5px^;height:${tableres.height}px^;background-color:${tableres.color}">


					$bcatalog[^table::sql{select * from bcatalog where id='$slide.bcatalog'}]
					$sgid_img[]
					$avatar[^string:sql{select path from dop_gallery where dop_type='bcatalog' and dop_id='$bcatalog.id' and avatar='1'}[$.default{}]]
					^if(def $avatar){$sgid_img[/images/bcatalog/s_${avatar}]}{$sgid_img[$tmpl_path/cms/tovar.png]}
					
					<a href="/^str_url[$bcatalog.idpage]/^catalog_url[$bcatalog.id]/" style="display:block^; background:url($sgid_img) no-repeat 50% 50%^; width:${tableres.width_slide}px^; height:150px^;"></a>
					<a href="/^str_url[$bcatalog.idpage]/^catalog_url[$bcatalog.id]/" class="tipa_h3" style="display:block^;">$bcatalog.name</a>
					<div class="tipa_h2"> $bcatalog.price <span class="rur">p<span>уб.</span></span></div>
#<table width=100% cellpadding=4 cellspacing=0 border=0>
#<tr><td background="$sgid_img" style="background-repeat:no-repeat^;background-position:top center"><a href="/^str_url[$bcatalog.idpage]/^catalog_url[$bcatalog.id]/"><img src="/i/1.gif" width=^eval($tableres.width_slide-15) height=150 border=0 alt="$bcatalog.name" title="$bcatalog.name"></a></td></tr>
#<tr><td><a href="/^str_url[$bcatalog.idpage]/^catalog_url[$bcatalog.id]/" class="tipa_h3">$bcatalog.name</a></td></tr>
#<tr><td>
#
#
#<nobr><span class="tipa_h2"> $bcatalog.price <span class="rur">p<span>уб.</span></span></span></nobr>
#
#
#</td></tr>
##<tr><td><a href="/^str_url[$bcatalog.idpage]/^catalog_url[$bcatalog.id]/" class="color_marker">Подробнее</a></td></tr>
#</table>
			
					</div>
				}
			}


</div>
#</div>

<script type="text/javascript">
^rem{
^$(document).ready(function(){
	^$('#bxslider_cat_${tableres.id}').bxSlider({
	auto: true,
	displaySlideQty: $tableres.displayslide,
	controls:false,
	autoDelay:$tableres.delay,
	speed:$tableres.speed,
	pause:$tableres.pause,
	moveSlideQty: $tableres.moveslide
	})^;
})^;
}

^$('#bxslider_cat_${tableres.id}').bxSlider({
	auto: true,
	autoStart: true,
	pause:$tableres.pause,
	autoHover:true,
	autoDelay:$tableres.delay,
	speed:$tableres.speed,
	randomStart:true,
	responsive:true,
	slideWidth: ${tableres.width_slide},
	minSlides: 2,
	maxSlides: $tableres.displayslide,
	moveSlides: $tableres.moveslide,
	slideMargin: 20,
	pager:false,
	controls:false
})^;

</script>

	}


}

