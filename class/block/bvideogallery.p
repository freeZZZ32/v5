@CLASS
bvideogallery

@show[id_te;name_te]
#$id_te
$tbl_video[^table::sql{select * from videos where id_te='$id_te' and module='bvideogallery' and enable=1 order by sortir}]
# Если есть хоть одно видео
^if(def $tbl_video){
#qqq
# Считываем настройки раздела из базы данных
 $countcol[^string:sql{select value from te_opt where id_te='$id_te' and name='countcol'}[$.default{2}]]
 $width[^string:sql{select value from te_opt where id_te='$id_te' and name='width'}[$.default{0}]]
 $height[^string:sql{select value from te_opt where id_te='$id_te' and name='height'}[$.default{0}]]
 $view_name_video[^string:sql{select value from te_opt where id_te='$id_te' and name='view_name_video'}[$.default{}]]
 $view_name_gallery[^string:sql{select value from te_opt where id_te='$id_te' and name='view_name_gallery'}[$.default{}]]
 $descript[^string:sql{select value from te_opt where id_te='$id_te' and name='descript'}[$.default{}]]
# Отображаем видео на странице
^if(def $view_name_gallery){<a id="gallery$id_te"><strong>$name_te</strong></a>}
^if(def $descript){<p class="tipa_h2" align="left">$descript</p>}
<table border="0" width="100%" cellspacing="0" cellpadding="0">
 <tr>
 $counter(0)
 ^tbl_video.menu{
  <td align="center" valign="top" style="padding:10px 0px^;border-bottom: 1px solid #999999^;">
   <table border="0" width="$width" cellspacing="1" cellpadding="5">
    <tr>
     <td>
      <iframe width="$width" height="$height" src="$tbl_video.src" frameborder="0" allowfullscreen></iframe>
		   </td>
	   </tr>
    ^if(def $view_name_video){
    <tr>
     <td align="center">
			   ^untaint{$tbl_video.name}
		   </td>
	   </tr>
	   }
	  </table>
	 </td>
	 ^counter.inc[]
	 $count_mod($counter)
  ^count_mod.mod($countcol)
  ^if($count_mod eq 0){</tr><tr>}
 }
 </tr>
</table>
}
