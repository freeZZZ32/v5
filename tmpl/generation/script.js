$(document).ready(function() {

$( "#tabs_generation" ).tabs({collapsible: true, active: 0});
$( "#tabs_generation" ).show();
$( "#name_tmpl" ).show();
	

$("#drag_generation").draggable({
	appendTo: 'body',
	containment: 'window',
	scroll: false,
	handle: "#name_tmpl",
	distance: 5
});
$("#tabs_generation").resizable(); 

});

function update(version){
$.ajax({
	type: "POST",
	url: "/tmpl/generation/version/update.html",
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'version' : version
	}),
			
	success: function(msg){
		location.reload();
	},
	error: function(){
		alert('Произошла ошибка');
	}
});	

}

//удалить картинку
function delete_img(name){

$.ajax({
	type: "POST",
	url: "/tmpl/generation/ajax_image.html",
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'name' : name,
		'type' : 'delete'
	}),	
	success: function(msg){
		
		$('#image-'+name).html('');
	},
	error: function(){
		alert('Произошла ошибка');
	}
});	

}
//показать картинку
function ajax_foto(name){
$('#image-'+name).html();
$.ajax({
	type: "POST",
	url: "/tmpl/generation/show_image.html",
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'name' : name
	}),
			
	success: function(msg){
		arr = msg.split('|');
		image_element=arr[0];
		src=arr[1];
		$('#image-'+name).html(image_element);
		switch(name){
			case 'body_bg':$('body').css('background-image', 'url('+src+')');
			break
			case 'bg_1':$('.bg_1').css('background-image', 'url('+src+')'); 
			break
			case 'bg_2':$('.bg_2').css('background-image', 'url('+src+')');
			break
			case 'bg_3':$('.bg_3').css('background-image', 'url('+src+')');
			break
			
		}
	},
	error: function(){
		alert('Произошла ошибка');
	}
});	
}


//Изменятется ширина сайта
function site_animation(){
number('type_w_site');
number('type_padding_site');
var val_width=$('#type_w_site').val();
var str_width=$('#select_type_w_site').val();
var val_padding=$('#type_padding_site').val();
var str_padding=$('#select_type_padding_site').val();

var width=val_width+str_width;
var padding=val_padding+str_padding;
if(width && padding){
	$('.type_w_site').animate({width: width,'padding-left': padding, 'padding-right': padding}, 700);
	$('#button_site').animate({'background-color': '#cccccc'}, 700);
	$('#button_site').text('Сохранить');
}
return false
}


//убирает все кроме цифр
function number(id){
var value=$('#'+id).val();
value=value.replace(/[^0-9]/g,"");
$('#'+id).val(value);
return false
}


//Сохранение настроек сайта
function save_site(event){
$(event).fadeTo(1,0);
$('#loader_site').show();
var val_width=$('#type_w_site').val();
var str_width=$('#select_type_w_site').val();
var val_padding=$('#type_padding_site').val();
var str_padding=$('#select_type_padding_site').val();

$.ajax({
	type: "POST",
	url: 'ajax_site.html',
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'val_width' : val_width,
		'str_width' : str_width,
		'val_padding' : val_padding,
		'str_padding' : str_padding,
		'type' : 'add_width_padding'
	}),
	success: function(msg){
		setTimeout(function(){
			$('#loader_site').hide();
			$(event).css('background','#cdff8d');
			$(event).text('Сохранено');
			$(event).fadeTo(700,1);
			
		},700);
		
		//setTimeout(function(){
		//	$(event).animate({'background-color': '#cccccc'}, 700);
		//	$(event).text('Сохранить');
		//},2000);
	},
	error: function() {
		$('#loader_site').hide();
		alert('Произошла ошибка');
	}
});
}




//Изменятется background
function background_animation(name){
var background_repeat=$('#background_repeat_'+name).val();
var left_position=$('#left_position_'+name).val();
var right_position=$('#right_position_'+name).val();
var background_size=$('#background_size_'+name).val();
var background_attachment=$('#background_attachment_'+name).val();

if(name=='body_bg'){
	var selector=$('body');
}else{
	var selector=$('.'+name);
}
selector.css('background-repeat', background_repeat);
selector.css('background-position', left_position+' '+right_position);
selector.css('background-size', background_size);
selector.css('background-attachment', background_attachment);
	$('#button_background').animate({'background-color': '#cccccc'}, 700);
	$('#button_background').text('Сохранить');

return false
}



//сохранение настроек background
function save_background(event,name){
$(event).fadeTo(1,0);
$('#loader_background_'+name).show();
var background_repeat=$('#background_repeat_'+name).val();
var left_position=$('#left_position_'+name).val();
var right_position=$('#right_position_'+name).val();
var background_size=$('#background_size_'+name).val();
var background_attachment=$('#background_attachment_'+name).val();

$.ajax({
	type: "POST",
	url: 'ajax_site.html',
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'name' : name,
		'background_repeat' : background_repeat,
		'background_position' : left_position+" "+right_position,
		'background_size' : background_size,
		'background_attachment' : background_attachment,
		'type' : 'add_background'
	}),
	success: function(msg){
		setTimeout(function(){
			$('#loader_background_'+name).hide();
			$(event).css('background','#cdff8d');
			$(event).text('Сохранено');
			$(event).fadeTo(700,1);
			
		},700);
	},
	error: function() {
		$('#loader_background_'+name).hide();
		alert('Произошла ошибка');
	}
});
}



//сохранение настроек стили
function save_style(event){
$(event).fadeTo(1,0);
$('#loader_style').show();

var color_body=$('#color_body').val();
var color_a=$('#color_a').val();
var color_color_marker=$('#color_color_marker').val();
var color_slogan=$('#color_slogan').val();
var color_h1_slogan=$('#color_h1_slogan').val();
var font_size_h1_slogan=$('#font-size_h1_slogan').val();
var color_head_h1=$('#color_head_h1').val();
var font_size_head_h1=$('#font-size_head_h1').val();
var color_ph_code=$('#color_ph_code').val();
var font_size_ph_code=$('#font-size_ph_code').val();
var color_ph_number=$('#color_ph_number').val();
var font_size_ph_number=$('#font-size_ph_number').val();
var color_bottom=$('#color_bottom').val();
var color_alma=$('#color_alma').val();
var color_h1=$('#color_h1').val();
var font_size_h1=$('#font-size_h1').val();
var color_h2=$('#color_h2').val();
var font_size_h2=$('#font-size_h2').val();
var color_kroshki=$('#color_kroshki').val();
var font_size_kroshki=$('#font-size_kroshki').val();
var color_zakladka=$('#color_zakladka').val();
$.ajax({
	type: "POST",
	url: 'ajax_site.html',
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'color_body' : color_body,
		'color_a' : color_a,
		'color_color_marker' : color_color_marker,
		'color_slogan' : color_slogan,
		'color_h1_slogan' : color_h1_slogan,
		'font_size_h1_slogan' : font_size_h1_slogan,
		'color_head_h1' : color_head_h1,
		'font_size_head_h1' : font_size_head_h1,
		'color_ph_code' : color_ph_code,
		'font_size_ph_code' : font_size_ph_code,
		'color_ph_number' : color_ph_number,
		'font_size_ph_number' : font_size_ph_number,
		'color_bottom' : color_bottom,
		'color_alma' : color_alma,
		'color_h1' : color_h1,
		'font_size_h1' : font_size_h1,
		'color_h2' : color_h2,
		'font_size_h2' : font_size_h2,
		'color_kroshki' : color_kroshki,
		'font_size_kroshki' : font_size_kroshki,
		'color_zakladka' : color_zakladka,
		'type' : 'add_style'
	}),
	success: function(msg){
		setTimeout(function(){
			$('#loader_style').hide();
			$(event).css('background','#cdff8d');
			$(event).text('Сохранено');
			$(event).fadeTo(700,1);
			
		},700);
	},
	error: function() {
		$('#loader_style').hide();
		alert('Произошла ошибка');
	}
});
}








//анимация css
function animation_css(name,name_selector,type){
if(type=='color'){
	var value=$('#color_'+name).val();
	$('#div_'+name).css('background-color','#'+value);
	$('#div_jpicker_'+name).hide('slow');
	$(name_selector).css(type, '#'+value);
}else if(type=='background-color'){
	var value=$('#color_'+name).val();
	$('#div_'+name).css('background-color','#'+value);
	$('#div_jpicker_'+name).hide('slow');
	$(name_selector).css('background-color', '#'+value);
}else{
	var value=$('#'+type+'_'+name).val();
	$(name_selector).css(type, value+'px');
}
}

//изменение селекта меню
function select_menu(event,old){
var value=$(event).val();
$('#div_menu').fadeTo(700,0.3);
//$('#loader_menu_span').show();
$.ajax({
	type: "POST",
	url: "/tmpl/generation/ajax_menu.html",
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'type' : 'forma',
		'type_h_menu' : value
	}),
			
	success: function(msg){
		arr = msg.split('|');
		div_menu=arr[0];
		menu=arr[1];
		setTimeout(function(){
			//$('#loader_menu_span').hide();
			$('#div_menu').fadeTo(700,1);
			$('#div_menu').html(div_menu);
			$('#div_hmenu_'+old).parent().html(menu);
		},700);
	},
	error: function(){
		alert('Произошла ошибка');
	}
});	
}



function save_menu(event,old){
$(event).fadeTo(1,0);
$('#loader_menu').show();
var type_h_menu=$('#select_type_h_menu').val();
var hmenu_1_li_background_color=$('#color_hmenu_1_li_background_color').val();
var hmenu_1_li_color=$('#color_hmenu_1_li_color').val();
var hmenu_1_a_color=$('#color_hmenu_1_a_color').val();
var hmenu_1_a_background_color=$('#color_hmenu_1_a_background_color').val();
var hmenu_2_li_background_color=$('#color_hmenu_2_li_background_color').val();
var hmenu_2_li_color=$('#color_hmenu_2_li_color').val();
var hmenu_2_a_color=$('#color_hmenu_2_a_color').val();
var div_hmenu_2_background_color=$('#color_div_hmenu_2_background_color').val();
var hmenu_3_li_color=$('#color_hmenu_3_li_color').val();
var hmenu_3_li_hover_color=$('#color_hmenu_3_li_hover_color').val();
var hmenu_3_a_color=$('#color_hmenu_3_a_color').val();
$.ajax({
	type: "POST",
	url: "/tmpl/generation/ajax_site.html",
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'type' : 'add_menu',
		'type_h_menu' : type_h_menu,
		'hmenu_1_li_background_color' : hmenu_1_li_background_color,
		'hmenu_1_li_color' : hmenu_1_li_color,
		'hmenu_1_a_color' : hmenu_1_a_color,
		'hmenu_1_a_background_color' : hmenu_1_a_background_color,
		'hmenu_2_li_background_color' : hmenu_2_li_background_color,
		'hmenu_2_li_color' : hmenu_2_li_color,
		'hmenu_2_a_color' : hmenu_2_a_color,
		'div_hmenu_2_background_color' : div_hmenu_2_background_color,
		'hmenu_3_li_color' : hmenu_3_li_color,
		'hmenu_3_li_hover_color' : hmenu_3_li_hover_color,
		'hmenu_3_a_color' : hmenu_3_a_color
	}),
			
	success: function(msg){
		setTimeout(function(){
			$('#loader_menu').hide();
			$('#div_hmenu_'+old).parent().html(msg);
			$(event).css('background','#cdff8d');
			$(event).text('Сохранено');
			$(event).fadeTo(700,1);
		},700);
	},
	error: function(){
		alert('Произошла ошибка');
	}
});	
}



//созранение в файл user.css
function save_user(event){
$(event).fadeTo(1,0);
$('#loader_user').show();
var type_h_menu=$('#select_type_h_menu').val();
var text_user=$('#text_user').val();
$.ajax({
	type: "POST",
	url: "/tmpl/generation/ajax_site.html",
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	data: ({
		'rand' : Math.random(),
		'type' : 'add_user',
		'text_user' : text_user
	}),
			
	success: function(msg){
		setTimeout(function(){
			$('#loader_user').hide();
			$(event).css('background','#cdff8d');
			$(event).text('Сохранено');
			$(event).fadeTo(700,1);
			parent.$.fancybox.close();
		},700);
	},
	error: function(){
		alert('Произошла ошибка');
	}
});	
}








