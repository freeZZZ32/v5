@CLASS
bgallery

@show[id_te;name_te]
	

$preview_width[^string:sql{select value from te_opt where id_te='$id_te' and name='preview_width'}[$.default{0}]]
$preview_height[^string:sql{select value from te_opt where id_te='$id_te' and name='preview_height'}[$.default{0}]]
$width[^string:sql{select value from te_opt where id_te='$id_te' and name='width'}[$.default{0}]]
$height[^string:sql{select value from te_opt where id_te='$id_te' and name='height'}[$.default{0}]]
$countcol[^string:sql{select value from te_opt where id_te='$id_te' and name='countcol'}[$.default{2}]]
$descript[^string:sql{select value from te_opt where id_te='$id_te' and name='descript'}[$.default{}]]
$view_name_gallery[^string:sql{select value from te_opt where id_te='$id_te' and name='view_name_gallery'}[$.default{}]]
$view_name_foto[^string:sql{select value from te_opt where id_te='$id_te' and name='view_name_foto'}[$.default{}]]
$make_resize_preview[^string:sql{select value from te_opt where id_te='$id_te' and name='make_resize_preview'}[$.default{}]]
#$viewastable[^string:sql{select value from te_opt where id_te='$id_te' and name='viewastable'}[$.default{}]]






^if(def $form:page){$cpage($form:page)}{$cpage(1)}
$per_page(1600)

$count_catalog[^int:sql{select count(*) from te_gallery where id_te='$id_te'}]


$tablegallery[^table::sql{select * from te_gallery where id_te='$id_te' order by sortir, id desc}[$.limit($per_page) $.offset(^eval($cpage*$per_page-$per_page))]]
^if(def $view_name_gallery){<a id="gallery$id_te"><b>$name_te</b></a>}
^if(def $descript){<p class="tipa_h2">$descript</p>}

#^if(def $viewastable){
#	^self._block_gallery_table[$tablegallery]
#}{
	^self._block_gallery_normal[$tablegallery;$id_te]
#}


^if(^math:ceiling(^eval($count_catalog/$per_page)) > 1){

$allpages(^math:ceiling(^eval($count_catalog/$per_page)))

#$allpages

<table width=1% cellpadding=3><tr>
<td style="padding-left:20"></td>
<td>
#<b>Страницы: </b>

^if($cpage > 1){ <a href="?page=^eval($cpage-1)" style="text-decoration:none"><b><</b></a> }{&nbsp^;&nbsp^;&nbsp^;}

</td><td width=100%>
^use[/class/scroller.p]
^scroller:print_scroller2[^math:ceiling(^eval($count_catalog/$per_page));10]
</td>
<td>

^if($cpage < $allpages){ <a href="?page=^eval($cpage+1)" style="text-decoration:none"><b>></b></a> }{&nbsp^;&nbsp^;&nbsp^;}
</td>
</tr></table>

}

##############################
# вывод как обычно
@_block_gallery_normal[tableres;id_te]



<script type="text/javascript">
^$(document).ready(function() {
	^$(".fancybox").fancybox({
		openEffect	: 'elastic',
		closeEffect	: 'elastic',
		type		: 'image',
$fitToView(^int:sql{select value from te_opt where id_te='$id_te' and name='fitToView'}[$.default(0)])
		fitToView	: ^if($fitToView){true}{false},
		helpers	: {
			title	: {
				type: 'inside'
			},
			thumbs	: {
				width	: 50,
				height	: 50
			}
		}
	})^;
})^;
</script>



<table width="100%" border="0" cellpadding="1" cellspacing="1">
$ind(1)
	^tableres.menu{
		^if($ind==1){<tr>$post_row_descript[]}

		$bigpath[$siteprefpath/block/gallery/big/${tableres.id}.${tableres.ext}]
		$smallpath[$siteprefpath/block/gallery/small/${tableres.id}.${tableres.ext}]
		
		<td width="^eval(100/$countcol)%" class="aC" valign="top">
			
			^if(def $make_resize_preview){
				<img src="$smallpath" border="0" hspace="0" alt=""></a>
			
			}{
#			<div>
#				<a href="$bigpath" class="zoom_picture">
#				<img src="$smallpath" title="Нажмите чтобы увеличить" border="0" hspace="0" /></a>
#			</div>

#<div id="gallery-${id_te}">
#<a href="$bigpath"><img src="$smallpath" border=0></a>
#</div>


#<a class="fancybox" rel="gallery-${id_te}" href="$bigpath"><img src="$smallpath" border=0 class="png"></a>
<a class="fancybox" rel="bgallery" href="$bigpath" title="${tableres.descript}"><img src="$smallpath" border=0 class="png" alt=""></a>


			}
			
		</td>
		$post_row_descript[
			$post_row_descript 
			^if(def $view_name_foto){<td class="aC" valign="top" style="padding-bottom:15px^;">^untaint{$tableres.descript}</td>}
			]
		^ind.inc(1)
		^if($ind>$countcol){</tr> $ind(1) <tr>^untaint{$post_row_descript}</tr>}
	}
	^if($ind!=1){^while($ind<=$countcol){
		<td valign="top">&nbsp^;</td> 
		^ind.inc(1)}
		$post_row_descript[
			$post_row_descript <td>&nbsp^;</td>]
		
	}
	^if($ind>$countcol){</tr> $ind(1) <tr>^untaint{$post_row_descript}</tr>}
	
</table>

##############################
# вывод в виде таблицы
@_block_gallery_table[tableres]


<table width="100%" border="0" cellpadding="5" cellspacing="1">

	^tableres.menu{
		<tr>

		$bigpath[$siteprefpath/block/gallery/big/${tableres.id}.${tableres.ext}]
		$smallpath[$siteprefpath/block/gallery/small/${tableres.id}.${tableres.ext}]
		
			<td width="$preview_width" class="aC" valign="top">
				
				^if(def $make_resize_preview){
					<img src="$smallpath" border="0" hspace="0" alt=""></a>
				
				}{
				<div>
					<a href="$bigpath" class="zoom_picture">
					<img src="$smallpath" title="Нажмите чтобы увеличить" border="0" hspace="0" alt=""></a>
				</div>
				}
			</td>
			<td class="aL" valign="top">
				^untaint{$tableres.descript}
			</td>
		</tr>
	}

</table>
