@CLASS
btimer

@show[iid]
$tableres[^table::sql{select * from te_text where id='$iid'}]
$dop_block[^table::sql{select * from te_timer where id='$iid'}]

		^try{
		$dt_now[^date::create[$dop_block.dt]]
		}{
		$exception.handled(1)
		}


<table width="100%" cellpadding=0 cellspacing=0 border=0>
<tr><td>^untaint{$tableres.content}</td></tr>
#<tr><td align=right><span class="p11">$dop_block.text_start</span></td></tr>

^if($dt_now){

<tr><td align=right style="padding:2px">
#<div id="countdown-block-$iid" class="btimer"></div>
#<script>
#^$("#countdown-block-$iid").countdown(new Date(${dt_now.year}, ^eval($dt_now.month - 1), ${dt_now.day}, ${dt_now.hour}, ${dt_now.minute}, ${dt_now.second}), {prefix:'', finish: '$dop_block.text_end'})^;
#</script>

$dtjs[^dt_now.unix-timestamp[]]


<script language="javascript" type="text/javascript">
/*<![CDATA[*/
^$(document).ready(function(){setInterval(function(){
var now=new Date()^;
var endTS= $dtjs*1000^;
var totalRemains=(endTS-now.getTime())^;
if(totalRemains>1){var RemainsSec=(parseInt(totalRemains/1000))^;
var RemainsFullDays=(parseInt(RemainsSec/(24*60*60)))^;
var secInLastDay=RemainsSec-RemainsFullDays*24*3600^;
var RemainsFullHours=(parseInt(secInLastDay/3600))^;
if(RemainsFullHours<10){RemainsFullHours="0"+RemainsFullHours}^;
var secInLastHour=secInLastDay-RemainsFullHours*3600^;
var RemainsMinutes=(parseInt(secInLastHour/60))^;
if(RemainsMinutes<10){RemainsMinutes="0"+RemainsMinutes}^;
var lastSec=secInLastHour-RemainsMinutes*60^;
if(lastSec<10){lastSec="0"+lastSec}^;
var itogdney=""^;
var dney=" дней "^;
if(RemainsFullDays==1){dney=" день "}^;
if(RemainsFullDays==2){dney=" дня "}^;
if(RemainsFullDays==3){dney=" дня "}^;
if(RemainsFullDays==4){dney=" дня "}^;

if(RemainsFullDays>0){
itogdney=RemainsFullDays +dney^;
}^;



^$('#timer-block-$iid').text(itogdney+ RemainsFullHours+":"+RemainsMinutes+":"+lastSec)^;}
#else{^$("#timer-block-$iid").remove()^;}},1000)^;})^;
else{^$('#timer-block-$iid').text("$dop_block.text_end")^;}},1000)^;})^;
/*]]>*/
</script>
<table cellpadding=0 cellspacing=0 border=0><tr><td align=right><span  style="color:#${dop_block.text_color}^;">${dop_block.text_start}</span></td>
</tr>
<tr>
<td>
<div id="timer-block-$iid" class="btimer" style="color: #${dop_block.fontcolor}^;font-size: ${dop_block.fontsize}px^;"></div>
</td>
</tr>
</table>




</td></tr>
}
</table>

