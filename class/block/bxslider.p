@CLASS
bxslider

@show[id_te;name_te;counter;container;cms]
^self.show_slide[$id_te]





@show_slide[idblock;cms]
	^self.settings_slider[$idblock]
	$slides[^table::sql{select * from bxslider where idblock='$idblock' ^if(!def $cms){and visible='1'} order by sortir}]
	^if(def $slides){
		<style type="text/css">
		ul.bxslider, .bxslider li{margin:0^;padding:0^;}
		
		.bxslider li{
			min-height:100px^;
			min-width:100px^;
			height:${slides_set.slideHeight}px^;
		}
		
		.bxbacklink
		{
			z-index:1^;
			text-decoration:none^;
			display:block^;
			height:100%^;
		}
		
		
		</style>
	
	
		<ul class="bxslider bxslider_$idblock">
		^slides.menu{
			<li class="slide_show_$slides.id" style="^if(def ${slides.back_image}){background:url(/images/bxslider/img/n_${slides.back_image}) ^if(!def $slides.back_repeat){no-repeat}{$slides.back_repeat} ^if(def ${slides.back_pos_x}){${slides.back_pos_x}}{50%} ^if(def ${slides.back_pos_y}){${slides.back_pos_y}}{0%}^;}">
				^if(def $slides.link){<a href="$slides.link" class="bxbacklink"></a>}{<div class="bxbacklink"></div>}
			</li>
		}
		</ul>
	<script type="text/javascript">
	slider = ^$('.bxslider_$idblock').bxSlider(^self.show_settings[$idblock])^;
	^if(def $slides){}{
	slider.destroySlider()^;
	}
	</script>
	}{
		^if(def $cms){
			<ul class="bxslider bxslider_$idblock">
			<script type="text/javascript">
				slider = ^$('.bxslider_$idblock').bxSlider(^self.show_settings[$idblock])^;
				slider.destroySlider()^;
			</script>
		}
	}




@settings_slider[idblock]
$slides_opt[^table::sql{select * from te_opt where id_te='$idblock' order by sortir}]
$slides_set[
#	$.img_prev_w[^if(^slides_opt.locate[name;bx_img_prev_w]){$slides_opt.value}{200}]
#	$.img_prev_h[^if(^slides_opt.locate[name;bx_img_prev_h]){$slides_opt.value}{200}]
#	$.img_img_w[^if(^slides_opt.locate[name;bx_img_img_w]){$slides_opt.value}{700}]
#	$.img_img_h[^if(^slides_opt.locate[name;bx_img_img_h]){$slides_opt.value}{999}]
	$.slideHeight(^if(^slides_opt.locate[name;slideHeight]){$slides_opt.value}{0})
	$.slideWidth(^if(^slides_opt.locate[name;slideWidth]){$slides_opt.value}{0})
]




@show_settings[idblock]
$tbl[^table::sql{select * from te_opt where id_te = '$idblock' and type_block='bxslider' and type_opt='1' and value<>value_default order by sortir}]
^if(def $tbl){{^tbl.menu{${tbl.name}: ^self.switch_print_set[${tbl.value};${tbl.type_input}]}[,]}}
	
	
@switch_print_set[value;type]
^switch[$type]{
	^case[int]{$tmp[$value]}
	^case[intplus1]{$tmp[$value]}
	^case[select]{$tmp['$value']}
	^case[checkbox]{$tmp[^if($value==0){false}{true}]}
	^case[DEFAULT]{$tmp['$value']} 
} 
$result[$tmp]

