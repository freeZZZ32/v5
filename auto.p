##### @USE
##### Не добавляли ^use[/class/controlimage.p]

@auto[]
	^include[/config.p]
#	^if(-f "/config_pay.p"){^include[/config_pay.p]}
	$connect_string[mysql://${sql_login}:${sql_pass}@[/var/run/mysqld/mysqld.sock]/${sql_table}?charset=utf8]
	$servername[http://${env:SERVER_NAME}]
	
	


	
@main[]
^use[/class/auth/auth.p]
^use[/class/blocks.p]
^use[/class/html.p]
^connect[$connect_string]{
	$auth[^auth::init[]]
	

	^get_param_global[]
	^get_param_local[]
	^get_tmpl_set[]
	
	$blocksinit[^blocks::init[$param_page.curpage]]
#	^check_user[]
	^all_content[]
}


@all_content[]
^html:doctype[]
<html>
<head>
^head[]
</head>
<body>
^body[]
</body>
</html>


@head[]
	$heading_page[<div class="kroshki">^full_kroshki[$param_page]</div>]
	$datenow[^date::now[]]$dateyear($datenow.year)$datemade(2014)$dateyears[^if($dateyear==$datemade){$dateyear}{$datemade &dash^; $dateyear}]
	^title[]
	^keywords[]
	^descript[]

	^html:links[$tmpl_path_shared;$tmpl_path]
	^blocksinit.pre_show[]
	^add_head_else[]


@body[]
	^if(def $form:print && $form:print eq yes){	
		^ProcessFileTemplate[tmpl_path_shared/print.html]
	}{	^ProcessFileTemplate[$tmpl_path/index.html]}



@ProcessFileTemplate[filename]
$t[^file::load[text;$filename]]
$template[^untaint{$t.text}]

$parse[^table::create{from to
%HEADERPAGE%	$heading_page
%ALMA%	альма
%YEARS%	$dateyears
%YEAR%	$datemade
%NAMECOMPANY%	Компания
}]
	
$_fd[^template.replace[$parse]]
$result[^process[$caller.self]{^taint[as-is][$_fd]}]
	

@title[]

@keywords[]

@descript[]

@add_head_else[]




@text[]
	^test[]	<hr>
	^if(def $showcurpage){
		^blocksinit.show[]
	}{
		^err404[]
	}












@test[]
Всем привет это текст новой системы v5
<div>
Тип системы:		$type_systym <br>
Главный родитель:	$param_page.curpage_main <br>
Текущая страница:	$param_page.curpage <br>
id каталога страницы:	$param_page.idc <br>
id новости страницы:	$param_page.idn <br>
</div>





#####################################################
#####---Параметры страниц и блоков---###

@get_param_global[]
	^pageid[]
	$type_systym[full]
	$tmpl_path[^get_tmpl_path[]]
	$tmpl_path_shared[/tmpl/shared]
	
	$param_page[
		$.mainpage(^int:sql{select id from menus where mainpage='1'limit 1}[$.default(1)])
		$.curpage(^if(def $pid){$pid}{^if(def $form:p){$form:p}{^int:sql{select id from menus where mainpage='1'}[$.default(1)]}})
		$.curpage_main(1)
		$.idc(^if(def $form:idc){$form:idc}{0})
		$.idn(^if(def $form:idn){$form:idn}{0})
	]

	$showcurpage[^table::sql{select * from menus where id='$param_page.curpage'}]

	$param_page.curpage_main($param_page.curpage)
	$current_tmp(^int:sql{select parent from menus where id=$param_page.curpage}[$.default(0)])
	^while($current_tmp>0){
		$param_page.curpage_main($current_tmp)
		$current_tmp(^int:sql{select parent from menus where id=$param_page.curpage_main}[$.default(0)])
	}
	
@get_param_local[idpage]
	$param_block[
		$.show_h_block(1)
		$.show_t_block(1)
		$.show_l_block(1)
		$.show_r_block(1)
		$.show_b_block(1)
	]

@get_tmpl_path[]
$tmpl_path_table[^table::sql{select value from settings where type='tmpl'}]
^if(def $cookie:tmpl && -f "${cookie:tmpl}/index.html"){
	$tmpl_path[${cookie:tmpl}]
	}{
		^if(def $tmpl_path_table){
			$tmpl_path[$tmpl_path_table.value]
		}{
			$tmpl_path[/tmpl/main]
		}
	}
$result[$tmpl_path]

@get_tmpl_set[]
#^include[$tmpl_path/config.cfg]
#$tmpl_set[
#	$width[0]
#]




#####################################################
#####---Крошки и урлы---###

@full_kroshki[param_page]
$result[^if($param_page.idc>0 || $param_page.idn>0){^kroshki[$param_page.curpage]}{^kroshki[$param_page.curpage;1]} ^if($param_page.idc > 0){^catalog_kroshki[$param_page.idc]} ^if($param_page.idn > 0){^news_kroshki[$param_page.idn]}]


@kroshki[idpage;last][tb]
$tb[^table::sql{select id,parent,name,mainpage from menus where id=$idpage}]
^if($tb.parent == 0){
	$temps[^if($tb.mainpage != 1){<a href="/" class="kroshki">Главная</a> /} ^if(def $last){<span class="kroshki">${tb.name}</span>}{<a href="^str_url[$tb.id]" class="kroshki">$tb.name</a>}]
}{
	$temps[^self.kroshki[$tb.parent] / ^if(def $last){<span class="kroshki">$tb.name</span>}{<a href="^str_url[$tb.id]" class="kroshki">$tb.name</a>}]
}
$result[$temps]


@catalog_kroshki[idc;last][tb]
$tb[^table::sql{select * from bcatalog where id=$idc}]
^if($tb.parent == 0){
	$temps[/ <a href="^str_url[$tb.idpage]^catalog_url[$tb.id]" class="kroshki">$tb.name</a>]
}{
	$temps[^self.catalog_kroshki[${tb.parent}] / ^if(def $last){<span class="kroshki">$tb.name</span>}{<a href="^str_url[$tb.idpage]^catalog_url[$tb.id]" class="kroshki">$tb.name</a>}]
}
$result[$temps]

@news_kroshki[idn]
$result[/ ^string:sql{select head from news where id='$idn'}[$.default{Без названия}]]
#$url[^string:sql{select url from news where id='$idn'}[$.default{err}]]


@str_url[idpage][tb]
#$tb[^table::sql{select parent,uri,mainpage from menus where id=$idpage}]
#^if($tb.mainpage==1){$temps[/]}{
#^if($tb.parent==0){
#	$temps[/$tb.uri/]
#}{
#	$temps[^self.str_url[$tb.parent]$tb.uri/]
#}
#}
#$result[$temps]

@catalog_url[idc][tb]
$tb[^table::sql{select parent,url from bcatalog where id='$idc'}]
^if($tb.parent != 0){
	$temps[^self.catalog_url[$tb.parent]$tb.url/]
}{
	$temps[$tb.url/]
}
$result[$temps]

@news_url[idn]
$tb[^table::sql{select url from bnews where id='$idn'}]
$result[$tb.url]


#####################################################
#####---служебные функции---###
@pageid[]
$pid[0]


@dbconnect[code] 
^connect[$connect_string]{$code} 

@include[file][_fd]
##### Оператор @include[]. В случае отсутствия файла НЕ ВЫЗЫВАЕТ
##### фатальной ошибки, а только выводит предупреждение.

^if(-f $file){
	$_fd[^file::load[text;$file]]
	$result[^process[$caller.self]{^taint[as-is][$_fd.text]}[$.file[$file]]]
}{
	$result[^process[$caller.self]{<br><font color="red"><b>Warning! Оператор include[$file] не нашел файл!</b></font><br>}]
}





#####---Конец стандартных функций релиза---###
#####################################################
#####################################################


