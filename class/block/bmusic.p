@CLASS
bmusic

@show[iid]

$block[^table::sql{select id, descript, ext, sortir  from bmusic where ext='mp3' and idblock='$iid' order by sortir}]

^block.menu{

^rem{			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0" width="290" height="24">
				<param name="width" value="290" />
				<param name="height" value="24" />
				<param name="src" value="/block/player.swf" />
				<param name="flashvars" value="playerID=1&amp^;soundFile=/images/bmusic/${block.id}.${block.ext}" />
				<param name="quality" value="high" />
				<param name="menu" value="false" />
				<param name="wmode" value="transparent" />
				<param name="artists" value="" />
				<embed type="application/x-shockwave-flash" width="290" height="24" src="/block/player.swf" flashvars="playerID=1&amp^;soundFile=/images/bmusic/${block.id}.${block.ext}" quality="high" menu="false" wmode="transparent" artists=""></embed>
			</object>
}
<div style="padding-bottom:10px">
			<object data="/class/block/bmusic/dewplyer/dewplayer-vol.swf" width="240" height="20" name="dewplayer" id="dewplayer" type="application/x-shockwave-flash">
			<param name="movie" value="/class/block/bmusic/dewplyer/dewplayer-vol.swf" />
			<param name="flashvars" value="mp3=/images/bmusic/${block.id}.${block.ext}" />
			<param name="wmode" value="transparent" />
			</object>
</div>
}
