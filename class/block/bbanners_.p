@CLASS
bbanners

###@USE
###/class/calendar.p

@BASE
calendar


@show[iid]

$banners[^table::sql{select * from text_ext where id = '$iid'}]
^if(def $banners){


$cal[^calendar::init[]]

$countban[^int:sql{select count(*) from bbanners where idblock = '$iid'}[$.default{0}]]
^if($countban>0){
		^setcookie[$iid;^math:random($countban)]
}
^get_nextbanner_img[$iid]
}{
	Блок не найден
}







##############################
@auto[]

$sClassName[Img]
# declaration
$sLimitDate[]
$sLimitClick[]
$sLimitView[]




##################################################################
# создаем куку с номером родителя и 1
@setcookie[idcookie;value]
^if(!def $cookie:banners$idcookie){
	$cookie:banners$idcookie[
		$.value[$value]
		$.expires[1]
	]
}



##################################################################
@getUriBanner[idcookie]
^MAIN:dbconnect{$bannerUri[^string:sql{select uri from bbanners where id='$idcookie'}[$.default{}]]}
$result[$bannerUri]

##################################################################
# увеличиваем куку с номером банера на 1
@inccookie[idcookie]
^if(def $cookie:banners$idcookie){
		$cookie:banners$idcookie[^eval($cookie:banners$idcookie+1)]
}

##################################################################
@statistikaclick[idcookie]
^MAIN:dbconnect{^void:sql{update bbanners set cclick=cclick+1 where id='$idcookie'}}
# уменьшаем колво кликов
^MAIN:dbconnect{^void:sql{update bbanners set ogrclick=ogrclick-1 where id='$idcookie' and chkclick=1}}

^disableBanners[$idcookie]

##################################################################
@statistika[idcookie]

		
^MAIN:dbconnect{^void:sql{update bbanners set cview=cview+1 where id='$idcookie'}}

# уменьшаем колво показов
^MAIN:dbconnect{^void:sql{update bbanners set ogrview=ogrview-1 where id='$idcookie' and chkview=1}}
^disableBanners[$idcookie]


##################################################################
@disableBanners[idcookie]
$cal[^calendar::init[]]
# отключаем по колву показов
^MAIN:dbconnect{^void:sql{update bbanners set chkview=null, chkclick=null, chkdata=null where id='$idcookie' and chkview=1 and ogrview<=0}}
# отключаем по кликам
^MAIN:dbconnect{^void:sql{update bbanners set chkview=null, chkclick=null, chkdata=null where id='$idcookie' and chkclick=1 and ogrclick<=0}}
# отключаем по дате
^MAIN:dbconnect{^void:sql{update bbanners set chkview=null, chkclick=null, chkdata=null where id='$idcookie' and chkdata=1 and odata<'^cal.getNowSqlDate[]'}}


###############################################################	
@get_nextbanner_img[iid]
$cal[^calendar::init[]]
$bannerscount[^int:sql{select count(id) from bbanners where idblock=$iid and (chkview=1 or chkclick=1 or (chkdata=1 and ndata<='^cal.getNowSqlDate[]'))}]
^if($bannerscount>0){
$pathbanclick[/class/block/bbanners/]
	$bannersid[^table::sql{select id, name, ext, uri, width, height, chkclick from bbanners where idblock=$iid and (chkview=1 or chkclick=1 or (chkdata=1 and ndata<='^cal.getNowSqlDate[]')) limit $cookie:banners$iid,1}]
	^if(^bannersid.count[]>0){
	
			^switch[${bannersid.ext}]{
				^case[jpg;gif;jpeg]{
#					^if($bannersid.chkclick eq '1'){<a href="${pathbanclick}bannersclick.html?iduri=${bannersid.id}" target="_blank">}
					<a href="${pathbanclick}bannersclick.html?iduri=${bannersid.id}" target="_blank">
					<img src="/images/banners/${bannersid.id}.${bannersid.ext}" border="0">
#					^if($bannersid.chkclick eq '1'){</a>}
					</a>
				}
				^case[swf]{^insertflashbanner[/images/banners/${bannersid.id}.${bannersid.ext};${bannersid.width};${bannersid.height};${pathbanclick}bannersclick.html?iduri=${bannersid.id}&resp=${request:uri}]}
			}
			
		
		^statistika[$bannersid.id]
		
		
#		$cookie:banners$iid - count $bannerscount -
		^inccookie[$iid]

			
	}{
		
		$cookie:banners$iid[0]
		^get_nextbanner_img[$iid]
	}
}{
&nbsp^;
}


	
@insertflashbanner[filename;w;h;uri]
<div class="banner" id="$filename">
<script type="text/javascript">
//<![CDATA[

var rb_link = "$uri"^;
var rb_swf = "$filename"^;
var rb_fver = "8"^;
var rb_width = "$w"^;
var rb_height = "$h"^;
var rb_flash = 0^;
if (navigator.mimeTypes && navigator.mimeTypes["application/x-shockwave-flash"] ) {
 var plugin = navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin^;
 if (plugin && parseInt(plugin.description.substring(plugin.description.indexOf(".")-1)) >= rb_fver)
  rb_flash = 1^;
 } else if (navigator.appName && navigator.appName.indexOf("Microsoft") != -1 &&
 navigator.userAgent.indexOf("Windows") != -1 && navigator.userAgent.indexOf("Windows 3.1") == -1) {
  rb_flash = 1^;
}
/* GKE выводить всегда*/
rb_flash=1^;
if (rb_flash) {
 
 document.write('<scr'+'ipt type="text/javascript" src="/lib/rbflash/rb_flash.js"></scr'+'ipt>')^;
} else {
  
}
//]]>
</script>

</div>




