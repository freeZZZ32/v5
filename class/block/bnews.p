@CLASS
bnews

@show[iid]
$show_nopict(^int:sql{select value from te_opt where id_te='$iid' and name='shownopictnews'}[$.default(1)])

#$url[^curpage_url[]]

$thisrealpage(^int:sql{select idpage from text_ext where id='$iid' limit 1}[$.default(0)])
$url[^curpage_url[$thisrealpage]]

	$tmpl_path[^include_tmpl_path[]]

^use[/class/dtf.p]

$per_page(5)

^if(def $form:bnewspage){$bnewspage[$form:bnewspage]}{$bnewspage(1)}


$count_news[^int:sql{select count(*) from news where id_block='$iid' and is_hidden='n'}]
$tableres[^table::sql{select * from news where id_block='$iid' and is_hidden='n' order by date_news desc, id desc}[$.limit($per_page) $.offset(^eval($bnewspage*$per_page-$per_page))]]
^use[/class/scroller.p]



^if($tableres){
<p>
^scroller:print_scroller2[^math:ceiling(^eval($count_news/$per_page));10;$form:subs]
</p>

	^tableres.menu{

$avatar[^string:sql{select path from dop_gallery where dop_type='bnews' and dop_id='$tableres.id' and avatar='1'}[$.default{}]]
^if(def $avatar){$sgid_img[/images/bnews/s_${avatar}]}{$sgid_img[$tmpl_path/cms/news.png]}


<div id="div_bnews_${tableres.id}" class="block_elm" style="width:99%^;">

^if($show_nopict || def $avatar){<a href="$url/$tableres.url/"><img src="$sgid_img" border=0 align=left hspace=5 alt=""></a>}

$datapr[^date::create[$tableres.date_news]]
<p class=p11 style="padding-bottom:5px">^dtf:format[%d %h %Y;$datapr;$dtf:rr-locale]</p>
<a href="$url/$tableres.url/" class="tipa_h2">$tableres.head</a>
<p>^tableres.body.match[\n][g]{<br>} <br><a href="$url/$tableres.url/" class="color_marker" title="$tableres.head">Подробнее</a></p>
#<p class=p11>$tableres.body</p>


</div>


	}

<p>
^scroller:print_scroller2[^math:ceiling(^eval($count_news/$per_page));10;$form:subs]
</p>

}


@show_one[idn]


	$url[^curpage_url[]]
	$tmpl_path[^include_tmpl_path[]]

<script type="text/javascript">
^$(document).ready(function() {
	^$(".fancybox").fancybox({
		openEffect	: 'elastic',
		closeEffect	: 'elastic'
	})^;
})^;
</script>

#show - $idn
$one_rec[^table::sql{select * from news where id='$idn' and is_hidden='n'}]

^if($one_rec){

$show_nopict(^int:sql{select value from te_opt where id_te='$one_rec.id_block' and name='shownopictnews'}[$.default(1)])

$avatar[^string:sql{select path from dop_gallery where dop_type='bnews' and dop_id='$one_rec.id' and avatar='1'}[$.default{}]]
^if(def $avatar){
<div style="float:left^;padding-right:15px">
<a class="fancybox" rel="news_gallery_$idn" href="/images/bnews/b_${avatar}"><img src="/images/bnews/s_${avatar}" border=0 alt=""></a>
</div>
	}{
^if($show_nopict){
<div style="float:left^;padding-right:15px">
<img src="$tmpl_path/cms/news.png" border=0 alt="">
</div>
}
	}







^use[/class/dtf.p]
$datapr[^date::create[$one_rec.date_news]]
^dtf:format[%d %h %Y;$datapr;$dtf:rr-locale]

<h1>$one_rec.head</h1>
^untaint{$one_rec.full_text}


		$files[^table::sql{select * from news_files where news_id='$idn' order by id}]
		^if(def $files){
<div style="clear: both"></div>
<p class="tipa_h2">Прикрепленные файлы</p>
			^files.menu{
<p><a href="/nfiles/news/b_$files.path"><img src="/i/ico/txt.gif" align=absmiddle width=32 height=32 hspace=4 alt="">$files.descript</a></p>
			}
		}


	$gallery[^table::sql{select path from dop_gallery where dop_type='bnews' and dop_id='$one_rec.id' and avatar='0'}]
	^if($gallery){
<div style="clear: both"></div>
<p class="tipa_h2">Фотогалерея</p>
		^gallery.menu{
<div style="float:left^;padding:2px">
<a class="fancybox" rel="news_gallery_$idn" href="/images/bnews/b_${gallery.path}"><img src="/images/bnews/ss_${gallery.path}" border=0 width=120 height=120 class="png" alt=""></a>
</div>
		}
	}

	$tbl_video[^table::sql{select * from videos where id_te='$idn' and module='bnews' and enable=1 order by sortir}]
	^if(def $tbl_video){
<div style="clear: both"></div>
<p class="tipa_h2">Видео</p>
		^tbl_video.menu{
<div style="float:left^;padding:2px^;overflow:hidden">
<iframe width="420" height="340" src="$tbl_video.src" frameborder="0" allowfullscreen></iframe>
<p>$tbl_video.name</p>
<hr size=1 noshade color=#cccccc>
</div>
		}
	}


<div style="clear: both"></div>

#лайк
#<p align=right><img src="/class/block/i/like_ok.png" width=120 height=40 border=0 class="png" alt=""></p>

^use[/class/dtf.p]

<hr size=1 noshade color=#cccccc>
<table width=100%>
<tr>
<td width=50% valign=top>

	$prev_now[^table::sql{select * from news where date_news = '$one_rec.date_news' and id_block='$one_rec.id_block' and id < '$one_rec.id' and is_hidden='n' order by id desc limit 1}]
	^if(!$prev_now){
		$prev_now[^table::sql{select * from news where date_news < '$one_rec.date_news' and id_block='$one_rec.id_block' and is_hidden='n' order by date_news desc limit 1}]
	}
	^if($prev_now){

	$pr_avatar[^string:sql{select path from dop_gallery where dop_type='bnews' and dop_id='$prev_now.id' and avatar='1'}[$.default{}]]
	
	^if(def $pr_avatar){<a href="$url/$prev_now.url/"><img src="/images/bnews/ss_$pr_avatar" border=0 hspace=5 align=left width=80 height=80 alt=""></a>}
<p><a href="$url/$prev_now.url/">&larr^; Предыдущая запись</a></p>

$dataprev[^date::create[$prev_now.date_news]]
<p class=p11>^dtf:format[%d %h %Y;$dataprev;$dtf:rr-locale]</p>

<a href="$url/$prev_now.url/" class="tipa_h3">$prev_now.head</a>
	}

</td>
<td width=50% valign=top align=right>
	$next_now[^table::sql{select * from news where date_news = '$one_rec.date_news' and id_block='$one_rec.id_block' and id > '$one_rec.id' and is_hidden='n' order by id limit 1}]
	^if(!$next_now){
		$next_now[^table::sql{select * from news where date_news > '$one_rec.date_news' and id_block='$one_rec.id_block' and is_hidden='n' order by date_news limit 1}]
	}
	^if($next_now){

	$ne_avatar[^string:sql{select path from dop_gallery where dop_type='bnews' and dop_id='$next_now.id' and avatar='1'}[$.default{}]]
	
	^if(def $ne_avatar){<a href="$url/$next_now.url/"><img src="/images/bnews/ss_$ne_avatar" border=0 hspace=5 align=right width=80 height=80 alt=""></a>}
<p><a href="$url/$next_now.url/">Следующая запись &rarr^;</a></p>

$datanext[^date::create[$next_now.date_news]]
<p class=p11>^dtf:format[%d %h %Y;$datanext;$dtf:rr-locale]</p>

<a href="$url/$next_now.url/" class="tipa_h3">$next_now.head</a>	
	}
</td>
</tr>
</table>

#<hr size=1 noshade color=#cccccc>
#комменты




}






@show_last_news[count]


^use[/class/dtf.p]
#$blocknews[^table::sql{select * from text_ext where id='$iid'}]

$tableres[^table::sql{
select n.id, n.date_news, n.head, n.body, n.id_page, n.id_block, n.is_hidden, n.full_text, n.url, o.value
from news n, text_ext b, te_opt o 
where n.is_hidden='n' and n.id_block=b.id and b.pref_block='bnews' and o.id_te=n.id_block and o.value='1' and o.name='showtolastnews'
order by n.date_news desc, n.id desc 
^if(def $count){limit $count}
}]

^if($tableres){
	^tableres.menu{
$url[/^str_url[$tableres.id_page]/${tableres.url}/]

$avatar[^string:sql{select path from dop_gallery where dop_type='bnews' and dop_id='$tableres.id' and avatar='1'}[$.default{}]]



<div id="div_bnews_mini${tableres.id}" style="padding: 3px 0 0px^;">

<table><tr><td valign="top">
^if(def $avatar){<a href="$url"><img src="/images/bnews/ss_${avatar}" width="50" height="50" alt=""></a><br>}

</td><td valign="top">

$datapr[^date::create[$tableres.date_news]]
<p class="p11 color_marker" style="padding-bottom:5px^;">^dtf:format[%d %h %Y;$datapr;$dtf:rr-locale]</p>

<a href="$url" class="tipa_h3">$tableres.head</a><br>
#<p >^tableres.body.match[\n][g]{<br>} 
<a href="$url" class="color_marker" title="$tableres.head">Подробнее</a>
#<p class=p11>$tableres.body</p>
</td></tr></table>



</div>


	}
}