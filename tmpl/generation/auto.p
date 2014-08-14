

###############################################################
#************************** site_tabs ************************#
#						 1 вкладка (Сайт)					  #
#Переменные подключаются еще в главном auto                   #
#	$type_h_menu - тип меню                                   #
#	$type_w_site - ширина сайта                               #
#	$type_padding_site - отступы слева справа                 #
###############################################################
@site_tabs[]
$f[^file::load[binary;$tmpl_path/css/tmpl.css]] 
$tmpl_text[$f.text]

$background_position[^value_get[\/\*!body\/background-position\*\/;$tmpl_path/css/tmpl.css]]
$background_repeat[^value_get[\/\*!body\/background-repeat\*\/;$tmpl_path/css/tmpl.css]]
$background_size[^value_get[\/\*!body\/background-size\*\/;$tmpl_path/css/tmpl.css]]
$background_attachment[^value_get[\/\*!body\/background-attachment\*\/;$tmpl_path/css/tmpl.css]]

$background_position1[^value_get[\/\*!bg_1\/background-position\*\/;$tmpl_path/css/tmpl.css]]
$background_repeat1[^value_get[\/\*!bg_1\/background-repeat\*\/;$tmpl_path/css/tmpl.css]]
$background_size1[^value_get[\/\*!bg_1\/background-size\*\/;$tmpl_path/css/tmpl.css]]
$background_attachment1[^value_get[\/\*!bg_1\/background-attachment\*\/;$tmpl_path/css/tmpl.css]]

$background_position2[^value_get[\/\*!bg_2\/background-position\*\/;$tmpl_path/css/tmpl.css]]
$background_repeat2[^value_get[\/\*!bg_2\/background-repeat\*\/;$tmpl_path/css/tmpl.css]]
$background_size2[^value_get[\/\*!bg_2\/background-size\*\/;$tmpl_path/css/tmpl.css]]
$background_attachment2[^value_get[\/\*!bg_2\/background-attachment\*\/;$tmpl_path/css/tmpl.css]]

$background_position3[^value_get[\/\*!bg_3\/background-position\*\/;$tmpl_path/css/tmpl.css]]
$background_repeat3[^value_get[\/\*!bg_3\/background-repeat\*\/;$tmpl_path/css/tmpl.css]]
$background_size3[^value_get[\/\*!bg_3\/background-size\*\/;$tmpl_path/css/tmpl.css]]
$background_attachment3[^value_get[\/\*!bg_3\/background-attachment\*\/;$tmpl_path/css/tmpl.css]]

$val_width[^type_w_site.match[[^^0-9]][gi]{$match.1}]
$str_width[^type_w_site.match[[0-9]][gi]{$match.1}]

$val_padd[^type_padding_site.match[[^^0-9]][gi]{$match.1}]
$str_padd[^type_padding_site.match[[0-9]][gi]{$match.1}]

<table cellspacing=0 cellpadding=0>
<tr >
	<td class="cms_h2" style="padding-bottom:5px;" colspan=2>
		<span class="show" onclick="^$('.SETTING').toggle(500)">Настройки</span>
	</td>
</tr>
<tr class="SETTING">
	<td class="cms_h3" width="140px">Ширина сайта:</td>
	<td>
		<input type="text" onchange="site_animation()" name="type_w_site" id="type_w_site" value="$val_width" class="input_text_sel">
		<select class="select_text" id="select_type_w_site" onchange="site_animation()">
			<option ^if($str_width eq 'px'){selected} value="px">px</option>
			<option ^if($str_width eq '%'){selected} value="%">%</option>
		</select>
	</td>
</tr>
<tr class="SETTING">
	<td class="cms_h3">Отступ (слева, справа):</td>
	<td>
		<input type="text" onchange="site_animation()" name="type_padding_site" id="type_padding_site"  value="$val_padd" class="input_text_sel">
		<select class="select_text" id="select_type_padding_site" onchange="site_animation()">
			<option ^if($str_padd eq 'px'){selected} value="px">px</option>
			<option ^if($str_padd eq '%'){selected} value="%">%</option>
		</select>
	</td>
</tr>
<tr class="SETTING" height="40px" valign="bottom">
	<td colspan=2 align="right">
		<div style="position:relative^;"><button onclick="save_site(this)" id="button_site">Сохранить</button></div>
		<div class="div_loader">
			<img style="display: none^;" id="loader_site" height="20" src="/manage/i/loader.gif">
		</div>
	</td>
</tr>

^background_form[BACKGROUND;body_bg;Главный фон;$background_position;$background_repeat;$background_size;$background_attachment]
^background_form[BACKGROUND1;bg_1;Дополнительный фон 1;$background_position1;$background_repeat1;$background_size1;$background_attachment1]
^background_form[BACKGROUND2;bg_2;Дополнительный фон 2;$background_position2;$background_repeat2;$background_size2;$background_attachment2]
^background_form[BACKGROUND3;bg_3;Дополнительный фон 3;$background_position3;$background_repeat3;$background_size3;$background_attachment3]
</table>



###############################################################
#************************* image_tabs ************************#
#						 2 вкладка (Картинки)				  #
###############################################################
@image_tabs[]
<span class="cms_h2 show" onclick="^$('.IMAGE').toggle(500)">Картинки</span>
<table cellspacing=0 cellpadding=0 style="padding-left:20px">
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[hr;HR-линия]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2"><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[auth;auth]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2" ><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[buy;buy]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2"><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px" >
		^ajax_image[cart;cart]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2"><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[mail;mail]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2"><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[news;news]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2"><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[search;search]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2"><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[subcat;subcat]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2"><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[tovar;tovar]
	</td>
</tr>
<tr class="IMAGE">
	<td class="cms_h2" ><hr></td>
</tr>
<tr class="IMAGE">
	<td class="cms_h3" style="padding-top:10px">
		^ajax_image[variant;variant]
	</td>
</tr>
</table>


###############################################################
#************************* style_tabs ************************#
#						 3 вкладка (Стили)			     	  #
###############################################################
@style_tabs[]
$f[^file::load[binary;$tmpl_path/css/tmpl.css]] 
$tmpl_text[$f.text]
$body_color[
	$.background_color[^value_get[\/\*!body\/background-color\*\/;$tmpl_path/css/tmpl.css]]
]
$a[
	$.color[^value_get[\/\*!a\/color\*\/;$tmpl_path/css/tmpl.css]]
]
$color_marker[
	$.color[^value_get[\/\*!color_marker\/color\*\/;$tmpl_path/css/tmpl.css]]
]
$slogan[
	$.background_color[^value_get[\/\*!slogan\/background-color\*\/;$tmpl_path/css/tmpl.css]]
]
$h1_slogan[
	$.color[^value_get[\/\*!h1_slogan\/color\*\/;$tmpl_path/css/tmpl.css]]
	$.font_size[^value_get[\/\*!h1_slogan\/font-size\*\/;$tmpl_path/css/tmpl.css]]
]
$head_h1[
	$.color[^value_get[\/\*!head_h1\/color\*\/;$tmpl_path/css/tmpl.css]]
	$.font_size[^value_get[\/\*!head_h1\/font-size\*\/;$tmpl_path/css/tmpl.css]]
]
$ph_code[
	$.color[^value_get[\/\*!ph_code\/color\*\/;$tmpl_path/css/tmpl.css]]
	$.font_size[^value_get[\/\*!ph_code\/font-size\*\/;$tmpl_path/css/tmpl.css]]
]
$ph_number[
	$.color[^value_get[\/\*!ph_number\/color\*\/;$tmpl_path/css/tmpl.css]]
	$.font_size[^value_get[\/\*!ph_number\/font-size\*\/;$tmpl_path/css/tmpl.css]]
]
$bottom[
	$.color[^value_get[\/\*!bottom\/color\*\/;$tmpl_path/css/tmpl.css]]
]
$alma[
	$.color[^value_get[\/\*!alma\/color\*\/;$tmpl_path/css/tmpl.css]]
]
$h1[
	$.color[^value_get[\/\*!h1\/color\*\/;$tmpl_path/css/tmpl.css]]
	$.font_size[^value_get[\/\*!h1\/font-size\*\/;$tmpl_path/css/tmpl.css]]
]
$h2[
	$.color[^value_get[\/\*!h2\/color\*\/;$tmpl_path/css/tmpl.css]]
	$.font_size[^value_get[\/\*!h2\/font-size\*\/;$tmpl_path/css/tmpl.css]]
]
$kroshki[
	$.color[^value_get[\/\*!kroshki\/color\*\/;$tmpl_path/css/tmpl.css]]
	$.font_size[^value_get[\/\*!kroshki\/font-size\*\/;$tmpl_path/css/tmpl.css]]
]
$zakladka[
	$.background_color[^value_get[\/\*!zakladka\/background-color\*\/;$tmpl_path/css/tmpl.css]]
]



<span class="cms_h2 show" onclick="^$('.STYLE').toggle(500)">Стили</span><br>
<table cellspacing=0 cellpadding=0 style="padding-left:20px">
<tr>
	<td style="padding-top:10px"colspan=3></td>
</tr>
^style_form[STYLE;body;$body_color;Цвет фона]
^style_form[STYLE;a;$a;Ссылка]
^style_form[STYLE;.color_marker;$color_marker]
^style_form[STYLE;.slogan;$slogan;Полоска(slogan)]
^style_form[STYLE;.bottom;$bottom]
^style_form[STYLE;.alma;$alma]
^style_form[STYLE;.zakladka;$zakladka]

^style_form[STYLE;.h1_slogan;$h1_slogan;Текст слоган(h1_slogan)]
^style_form[STYLE;.head_h1;$head_h1;Текст название компании(head_h1)]
^style_form[STYLE;.ph_code;$ph_code;Контакты(ph_code)]
^style_form[STYLE;.ph_number;$ph_number;Номер телефона(ph_number)]
^style_form[STYLE;h1;$h1]
^style_form[STYLE;h2;$h2]
^style_form[STYLE;.kroshki;$kroshki]

<tr>
	<td colspan=3><a href="user_css.html" class="modalbox cms_h2" onclick="">Свой стиль</a></td>
</tr>


<tr class="STYLE"  height="40px" valign="bottom">
	<td colspan=3 align="right">
		<div style="position:relative^;"><button onclick="save_style(this)" id="button_style">Сохранить</button></div>
		<div class="div_loader">
			<img style="display: none^;" id="loader_style" height="20" src="/manage/i/loader.gif">
		</div>
	</td>
</tr>
</table>





###############################################################
#************************* menu_tabs *************************#
#						 4 вкладка (Меню)			     	  #
###############################################################
@menu_tabs[edit_type_h_menu]
^if(def $edit_type_h_menu){
	$type_h_menu[$edit_type_h_menu]
}
$f[^file::load[binary;$tmpl_path/css/mnu.css]] 
$tmpl_text[$f.text]

$hmenu_1_li_background_color[
	$.background_color[^value_get[\/\*!ul#hmenu_1 li:hover>a\/background-color\*\/;$tmpl_path/css/mnu.css]]
]
$hmenu_1_li_color[
	$.color[^value_get[\/\*!ul#hmenu_1 li:hover>a\/color\*\/;$tmpl_path/css/mnu.css]]
]
$hmenu_1_a_background_color[
	$.background_color[^value_get[\/\*!ul#hmenu_1 a\/background-color\*\/;$tmpl_path/css/mnu.css]]
]
$hmenu_1_a_color[
	$.color[^value_get[\/\*!ul#hmenu_1 a\/color\*\/;$tmpl_path/css/mnu.css]]
]


$hmenu_2_li_background_color[
	$.background_color[^value_get[\/\*!ul#hmenu_2 li:hover>a\/background-color\*\/;$tmpl_path/css/mnu.css]]
]
$hmenu_2_li_color[
	$.color[^value_get[\/\*!ul#hmenu_2 li:hover>a\/color\*\/;$tmpl_path/css/mnu.css]]
]
$div_hmenu_2_background_color[
	$.background_color[^value_get[\/\*!div#div_hmenu_2\/background-color\*\/;$tmpl_path/css/mnu.css]]
]
$hmenu_2_a_color[
	$.color[^value_get[\/\*!ul#hmenu_2 a\/color\*\/;$tmpl_path/css/mnu.css]]
]


$hmenu_3_li_color[
	$.color[^value_get[\/\*!ul#hmenu_3 li.subitem:hover>a\/color\*\/;$tmpl_path/css/mnu.css]]
]
$hmenu_3_li_hover_color[
	$.color[^value_get[\/\*!ul#hmenu_3 li:hover>a\/color\*\/;$tmpl_path/css/mnu.css]]
]
$hmenu_3_a_color[
	$.color[^value_get[\/\*!ul#hmenu_3 a\/color\*\/;$tmpl_path/css/mnu.css]]
]


<span class="cms_h2 show" onclick="^$('.MENU').toggle(500)">МЕНЮ</span><br>
<span class="cms_h3" >Для того чтобы увидеть изменения нажмите кнопку "Сохранить"</span>
<table cellspacing=0 cellpadding=0 style="padding-left:20px">
<tr>
	<td style="padding-top:10px"colspan=3></td>
</tr>
<tr class="MENU">
	<td class="cms_h3">Выбор меню:</td>
	<td colspan=2 style="padding-left:10px^;">
		<select name="type_h_menu" id="select_type_h_menu" style="width: 86px^;" onchange="select_menu(this,'$type_h_menu')">
			<option ^if($type_h_menu eq '1'){selected} value="1">1</option>
			<option ^if($type_h_menu eq '2'){selected} value="2">2</option>
			<option ^if($type_h_menu eq '3'){selected} value="3">3</option>
		</select>
	</td>
</tr>

^if($type_h_menu eq '1'){
^style_form[MENU m_1;hmenu_1_li_background_color;$hmenu_1_li_background_color;При наведении меню]
^style_form[MENU m_1;hmenu_1_li_color;$hmenu_1_li_color;При наведении текст]
^style_form[MENU m_1;hmenu_1_a_color;$hmenu_1_a_color;Текст в меню]
^style_form[MENU m_1;hmenu_1_a_background_color;$hmenu_1_a_background_color;Цвет подложки]
}
^if($type_h_menu eq '2'){
^style_form[MENU m_2;hmenu_2_li_background_color;$hmenu_2_li_background_color;При наведении меню]
^style_form[MENU m_2;hmenu_2_li_color;$hmenu_2_li_color;При наведении текст]
^style_form[MENU m_2;hmenu_2_a_color;$hmenu_2_a_color;Текст в меню]
^style_form[MENU m_2;div_hmenu_2_background_color;$div_hmenu_2_background_color;Цвет подложки]
}
^if($type_h_menu eq '3'){
^style_form[MENU m_3;hmenu_3_li_color;$hmenu_3_li_color;При наведении меню]
^style_form[MENU m_3;hmenu_3_li_hover_color;$hmenu_3_li_hover_color;При наведении текст]
^style_form[MENU m_3;hmenu_3_a_color;$hmenu_3_a_color;Текст в меню]
}


<tr class="MENU"  height="40px" valign="bottom">
	<td colspan=3 align="right">
		<div style="position:relative^;"><button onclick="save_menu(this,'$type_h_menu')" id="button_style">Сохранить</button></div>
		<div class="div_loader">
			<img style="display: none^;" id="loader_menu" height="20" src="/manage/i/loader.gif">
		</div>
	</td>
</tr>
</table>








################################   BACKGROUND1   #########################
@background_form[TR_CLASS;name;text;background_position;background_repeat;background_size;background_attachment]
^if(def $background_position && def $background_repeat && def $background_size && def $background_attachment){
<tr>
	<td class="cms_h2" colspan=2><hr></td>
</tr>
<tr>
	<td class="cms_h2" colspan=2>
		<span class="show" onclick="^$('.${TR_CLASS}').toggle(500)">$text</span>
	</td>
</tr>
<tr class="$TR_CLASS">
	<td class="cms_h3" style="padding-top:10px" colspan=2>
		^ajax_image[$name]
	</td>
</tr>
<tr class="$TR_CLASS">
	<td class="cms_h3" style="padding-top:10px">repeat:</td>
	<td style="padding-top:10px">
		<select name="background_repeat_$name" id="background_repeat_$name" class="select" onchange="background_animation('$name')">
			<option ^if($background_repeat eq 'no-repeat'){selected} value="no-repeat">no-repeat</option>
			<option ^if($background_repeat eq 'repeat-x'){selected} value="repeat-x">repeat-x</option>
			<option ^if($background_repeat eq 'repeat-y'){selected} value="repeat-y">repeat-y</option>
			<option ^if($background_repeat eq 'repeat'){selected} value="repeat">repeat</option>
		</select>
	</td>
</tr>
<tr class="$TR_CLASS">
	<td class="cms_h3" style="padding-top:10px">position:</td>
	<td style="padding-top:10px">
		$background_split[^background_position.split[ ;lh]] 
		$left_position[$background_split.0]
		$right_position[$background_split.1]
		<select class="select_text" id="left_position_$name" name="left_position_$name" onchange="background_animation('$name')" >
			<option ^if($left_position eq 'top'){selected} value="top">top</option>
			<option ^if($left_position eq 'center'){selected} value="center">center</option>
			<option ^if($left_position eq 'bottom'){selected} value="bottom">bottom</option>
		</select>
		<select class="select_text" id="right_position_$name" name="right_position_$name" onchange="background_animation('$name')">
			<option ^if($right_position eq 'left'){selected} value="left">left</option>
			<option ^if($right_position eq 'center'){selected} value="center">center</option>
			<option ^if($right_position eq 'right'){selected} value="right">right</option>
		</select>
	</td>
</tr>
<tr class="$TR_CLASS">
	<td class="cms_h3" >size:</td>
	<td style="padding-top:10px">
		
		<select class="select" id="background_size_$name" name="background_size_$name" onchange="background_animation('$name')">
			<option ^if($background_size eq 'auto'){selected} value="auto">auto</option>
			<option ^if($background_size eq 'cover'){selected} value="cover">cover</option>
			<option ^if($background_size eq 'contain'){selected} value="contain">contain</option>
		</select>
	</td>
</tr>
<tr class="$TR_CLASS">
	<td class="cms_h3" >attachment:</td>
	<td>
		<select class="select" id="background_attachment_$name" name="background_attachment_$name" onchange="background_animation('$name')">
			<option ^if($background_attachment eq 'fixed'){selected} value="fixed">fixed</option>
			<option ^if($background_attachment eq 'scroll'){selected} value="scroll">scroll</option>
		</select>
	</td>
</tr>
<tr class="$TR_CLASS"  height="40px" valign="bottom">
	<td colspan=2 align="right">
		<div style="position:relative^;"><button onclick="save_background(this,'$name')" id="button_background_$name">Сохранить</button></div>
		<div class="div_loader">
			<img style="display: none^;" id="loader_background_$name" height="20" src="/manage/i/loader.gif">
		</div>
	</td>
</tr>
}



#################################################################################
@style_form[CLASS_TR;name;param;name_text]
$count(^param._count[])
^if(def $name && def $param){
^if($count==1){
<tr class="$CLASS_TR">
	<td class="cms_h3">^if(def $name_text){$name_text}{^name.trim[left;.]}:</td>
}{
<tr class="$CLASS_TR">
	<td class="cms_h3" colspan=3>^if(def $name_text){$name_text}{^name.trim[left;.]}:</td>
</tr>
}
	^if(def $param.color){^color_form[$CLASS_TR;$name;$param.color;$count]}
	^if(def $param.background_color){^color_form[$CLASS_TR;$name;$param.background_color;$count;background-color]}
	^if(def $param.font_size){^font_size_form[$CLASS_TR;$name;$param.font_size;$count]}
	
}
<tr class="$CLASS_TR">
	<td class="cms_h2" colspan=3><hr style="margin:2px"></td>
</tr>



#########################################################################
@color_form[CLASS_TR;name;value;count;background_color]
$type_animation[color]
^if(def $background_color){$type_animation[$background_color]}
$name_class[$name]
$name[^name.trim[left;.]]
^if($count>1){
<tr class="$CLASS_TR">
<td class="cms_h3" style="padding-left:20px^;font-size:14px" >Цвет:</td>
}
	<td style="padding-left:10px^;">
		<div id="div_$name" class="div_color" style="background-color: #${value}^;" onclick="^$('#div_jpicker_$name').toggle('slow')^;" ></div>
	</td>
	<td style="padding-left:10px^;">
		<input type="text" name="color_$name" id="color_$name" value="$value" style="width:50px" maxlength="6" onclick="^$('#div_jpicker_$name').toggle('slow')^;" onchange="animation_css('$name','$name_class','$type_animation')">
		<div id="div_jpicker_$name" style="display:none^;position:absolute^;z-index:99999999">
			<div id="jpicker_$name"></div>
		</div>
	</td>
</tr>

<script type="text/javascript">
var css_color=^$("#color_$name").val()^;
if(!css_color){css_color='ffffff'^;}
  ^$('#jpicker_$name').jPicker({
	localization:{
		text:{
			title:'jPicker',
			newColor: 'Новый',
			currentColor: 'Предыдущий',
			ok: 'Выбрать',
			cancel: 'Отмена'
		}
	},
	color:{
            alphaSupport: true,
            active: new ^$.jPicker.Color({ ahex: css_color })
	}
	},
	//При нажатии на ОК
	function(color, context){
		var all = color.val('all')^;
		if(!all){^$("#color_$name").val('')^;}
		^$("#div_jpicker_$name").hide('slow')^;
		animation_css('$name','$name_class','$type_animation')
	},
	function(color, context){
		var all = color.val('all')^;
		if(!all){
			^$("#color_$name").val('')^;
			^$("#div_$name").css('background-color', '#ffffff')^;
		}else{
			^$("#color_$name").val(all.hex);
			^$("#div_$name").css('background-color', '#'+all.hex)^;
		}
	},
	//При нажатии на Отмена
	function(color, context){
		^$("#div_jpicker_$name").hide('slow')^;
	})^;  
</script>


#########################################################################
@font_size_form[CLASS_TR;name;value;count]
$name_class[$name]
$name[^name.trim[left;.]]
^if($count>1){
<tr class="$CLASS_TR">
<td class="cms_h3" style="padding-left:20px^;font-size:14px" >Размер шрифта:</td>
}
	$val[^value.match[[^^0-9]][gi]{$match.1}]
	$str[^value.match[[0-9]][gi]{$match.1}]
	<td></td>
	<td style="padding-left:10px^;">
		<input type="text" name="font-size_$name" id="font-size_$name" value="$val" style="width:30px" maxlength="4" onchange="animation_css('$name','$name_class','font-size')">
		$str
	</td>
</tr>



###############################################################
#*************************** ajax_image **********************#
#					    добавление ajax картинок			  #
###############################################################
@ajax_image[name;text]
^switch[$name]{
	^case[bg_1]{$path[^find_path[$tmpl_path/i/;$name]]}
	^case[bg_2]{$path[^find_path[$tmpl_path/i/;$name]]}
	^case[bg_3]{$path[^find_path[$tmpl_path/i/;$name]]}
	^case[body_bg]{$path[^find_path[$tmpl_path/i/;$name]]}
	^case[auth]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[buy]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[cart]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[mail]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[news]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[search]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[subcat]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[tovar]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[variant]{$path[^find_path[$tmpl_path/cms/;$name]]}
	^case[hr]{$path[^find_path[/manage/i/;$name]]}
	^case[DEFAULT]{}
}

<script type="text/javascript">
^$(function() {

	var uploader = new plupload.Uploader({
		runtimes : 'html5,silverlight,flash',
		browse_button : 'pickfiles-${name}',
		container : 'container-${name}',
		drop_element : 'container-${name}',
		dragdrop: true,
		max_file_size : '10mb',
		url : '/tmpl/generation/ajax_image.html?name=$name',
		filters : [
	        {title : "files", extensions : "jpg,jpeg,gif,png,psd,ai,cdr,pdf,zip,rar"}
	    ],
		multi_selection: false,
		multiple_queues: false,
		flash_swf_url : '/manage/v3filemanager/plupload/plupload.flash.swf',
		silverlight_xap_url : '/manage/v3filemanager/plupload/plupload.silverlight.xap'
		
	})^;
	
	uploader.init()^;

	//Добавление файлов
	uploader.bind('FilesAdded', function(up, files) {		
		//загрузка файлов
		uploader.start()^;	
	//	up.preventDefault()^;
		up.refresh()^; // Reposition Flash/Silverlight
	})^;
	

	//процесс загрузки
	uploader.bind('UploadProgress', function(up, file) {
		^$("#file_load-${name}").parent().show();
		^$("#file_load-${name}").parent().fadeTo(0,0.5)^;
		^$("#file_load-${name}").html(file.percent + "%")^;	
	})^;

	uploader.bind('Error', function(up, err) {
		var message=''^;
		if(err.code=='-601'){
			message='Неправильное расширение файла'^;
		}
		^$('#filelist').append("<div>Ошибка: " + message +
			", Файл: " + err.file.name + "</div>"
		)^;

		up.refresh()^; // Reposition Flash/Silverlight
	})^;
	

	//После Загрузки
	uploader.bind('FileUploaded', function(up, file) {
			^$("#file_load-${name}").html("Загружено")^;
			ajax_foto('$name')^;
			setTimeout(function(){
					^$("#file_load-${name}").parent().fadeTo(2500,0)^;
					^$("#file_load-${name}").parent().hide();
			},1000);

	})^;
	
})^;
</script>
		
^use[/class/NConvert.p]
$oImg[^NConvert::create[
	$.sScriptPath[/cgi-bin/]
	$.sScriptName[nconvert]
	^if(def $sFormat){$.sFormat[$sFormat]}
]]

$width_img[100%]
$height_img[auto]
$imginfo[^oImg.info[$path]]
^if($imginfo.iWidth< 265 && $imginfo.iHeight< 265){
	$width_img[${imginfo.iWidth}px]
	$height_img[${imginfo.iHeight}px]
}
^if($imginfo.iHeight>400 && $imginfo.iWidth<265){
	$width_img[${imginfo.iWidth}px]
	$height_img[400px]
}

^if($name eq 'hr'){
	$width_img[110px]
}


^if($text ne ''){
		<div>
			${text}:
		</div>
}	
<div id="container-${name}">
		<div style="display:inline-block">
			<div class="div_img" style="display:inline-block">
					<span id="image-${name}">
						<img  src="$path" style="width:$width_img^;height:$height_img^;">
						<div class="delete_img" style="margin-top: -8px^;left:$width_img^;margin-left: -8px^;" onclick="delete_img('$name')">x</div>
					</span>
			</div>
			<div align="center" class="status_load">
				<span id="file_load-${name}" ></span>
			</div>
			<div style="padding-bottom:10px">
				<a id="pickfiles-${name}" href="#">Загрузить картинку</a>
			</div>
		</div>
</div>
<div id="filelist"></div>




###############################################################
#************************ value_get ***********************#
#					Получение значения с css	 		   	  #
###############################################################
@value_get[regular;path_class]
$f[^file::load[binary;$path_class]] 
$tmpl_text[$f.text]
$rep[^table::create{from   to
\	
}]
$selector[^regular.replace[$rep]]
^if(^tmpl_text.pos[$selector]==-1){
	$value[^add_selector[$selector;$path_class]]	
}{
	$value[^tmpl_text.match[(.+)\:(.+)${regular}(.+)][gi]{^clear_match[$match.2]}]
}

$result[$value]


###############################################################
#************************ add_selector ***********************#
#						Добавление в css селектора 		   	  #
#	1. Разбиваем селектор на класс и стиль                    #
#	2. Назодим начальную позицию класса и стиля               #
#	3. Если нет стиля то давбавляет его                       #
#	4. Если нет селектора то добовляет его                    #
#	no_add_find - не перезаписывает файл если нашел           #
###############################################################
@add_selector[selector;path_class;no_add_find;copy]
$f[^file::load[binary;$path_class]] 
$text_f[$f.text]
$rep[^table::create{from   to
*	
!	}]

$selector_split[^selector.replace[$rep]]
$selector_split[^selector_split.split[/;lh]] 

$class[$selector_split.1]
$class_enter[
$class]
$class_space[ $class]
$class_dote[.${class}]
$style[$selector_split.2:]
$class_pos(-1)
^if(^text_f.pos[${class_dote}^{]!=-1){$class_pos(^text_f.pos[${class_dote}^{])}
^if(^text_f.pos[${class_dote} ^{]!=-1){$class_pos(^text_f.pos[${class_dote} ^{])}
^if(^text_f.pos[${class_dote}
^{]!=-1){$class_pos(^text_f.pos[${class_dote}
^{])}

^if(^text_f.pos[${class_space}^{]!=-1){$class_pos(^text_f.pos[${class_space}^{])}
^if(^text_f.pos[${class_space} ^{]!=-1){$class_pos(^text_f.pos[${class_space} ^{])}
^if(^text_f.pos[${class_space}
^{]!=-1){$class_pos(^text_f.pos[${class_space}
^{])}

^if(^text_f.pos[${class_enter}^{]!=-1){$class_pos(^text_f.pos[${class_enter}^{])}
^if(^text_f.pos[${class_enter} ^{]!=-1){$class_pos(^text_f.pos[${class_enter} ^{])}
^if(^text_f.pos[${class_enter}
^{]!=-1){$class_pos(^text_f.pos[${class_enter}
^{])}



^if($class_pos!=-1){
	$start($class_pos)
	$text[^text_f.mid($start)]
	$end(^eval(^text.pos[^}]+1))
	$text[^text.mid(0;$end)]
	$text_class[$text]
	$end(^eval($start+$end))
	
	$style_pos(-1)
	$style_end[^;$style]
	$style_slesh[/$style]
	$style_tab[	$style]
	$style_space[ $style]
	$style_enter[
$style]
	
	^if(^text.pos[$style_end]!=-1){$style_pos(^eval(^text.pos[$style_end]+1))}
	^if(^text.pos[$style_slesh]!=-1){$style_pos(^eval(^text.pos[$style_slesh]+1))}
	^if(^text.pos[$style_tab]!=-1){$style_pos(^text.pos[$style_tab])}
	^if(^text.pos[$style_space]!=-1){$style_pos(^text.pos[$style_space])}
	^if(^text.pos[$style_enter]!=-1){$style_pos(^text.pos[$style_enter])}
	^if($style_pos!=-1){
		
		$text[^text.mid($style_pos)]
		
		$text[^text.mid(0;^text.pos[^;])]
		$text[^text.trim[]]
		$text[${text}^;]
		^if(def $copy){
			$text_rep[${text}${copy}]
		}{
			$text_rep[${text}${selector}]
		}
		$rep_selector[^table::create{from   to
$text	$text_rep}]

		^if(^text_class.pos[$text_rep]==-1){
			$text_1[^text_f.mid(0;$start)]
			$text_class[^text_class.replace[$rep_selector]]
			$text_3[^text_f.mid($end)]
			$text_f[${text_1}${text_class}${text_3}]
			^if(!def $no_add_find){^text_f.save[$path_class]}
		}
		
		$value[^text.mid(^eval(^text.pos[$style]+^style.length[]);^eval(^text.pos[^;]-^style.length[]))]
		$value[^clear_match[$value]]

	}{
		$text[^text_class.mid(0;^eval(^text.pos[{]+1))]
		$rep_style[^table_style_add[$selector_split.2;$selector;$text]]

		$text_f[^text_f.replace[$rep_style]]
		^text_f.save[$path_class]
		$value[auto]
	}
}{
$value[]
}

$result[$value]




###############################################################
#********************* table_style_add ***********************#
#					Добавление стиля которого нет 		   	  #
###############################################################
@table_style_add[style;selector;start_text]
^switch[$style]{
	^case[background-size]{
		$add_style[${text} ${style}: auto^;${selector} -moz-background-size:auto^; /*!copy/body/background-size*/ -o-background-size:auto^; /*!copy/body/background-size*/ -webkit-background-size:auto^; /*!copy/body/background-size*/ -khtml-background-size:auto^; /*!copy/body/background-size*/]
		$rep_style[^table::create{from   to
$start_text	$add_style}]
	
	}
	^case[transition]{
		$add_style[${text} ${style}: all 0.5s ease^;${selector} -webkit-transition:all 0.5s ease^; /*!copy/a/transition*/ -moz-transition:all 0.5s ease^; /*!copy/a/transition*/ -o-transition:all 0.5s ease^; /*!copy/a/transition*/]
		$rep_style[^table::create{from   to
$start_text	$add_style}]
	
	}
	^case[DEFAULT]{
		$add_style[${text} ${style}: auto^;${selector}]
		$rep_style[^table::create{from   to
$start_text	$add_style}]
	}
}
$result[$rep_style]


###############################################################
#*************************** find_path ***********************#
#	    Находит точный путь к картинки с разрешением		  #
###############################################################
@find_path[path;name]
$exist(0)
^if(def $path){
	$list[^file:list[$path]]
	^if(def $list){
		^list.menu{
			^if(^file:justname[$list.name] eq '$name' && $exist==0){
				$value[${path}${list.name}]
				$exist(1)
			}
		}
	}
}
$result[$value]


###############################################################
#************************* clear_match ***********************#
#						убирает впереди # и в конце ;	   	  #
###############################################################
@clear_match[value]
^if(def $value){
$rep[^table::create{from   to
^#	
^;	
}]
$value[^value.replace[$rep]]
$value[^value.trim[]]
}
$result[$value]

