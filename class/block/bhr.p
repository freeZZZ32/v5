@CLASS
bhr

@show[iid]
$tableres[^table::sql{select * from te_text where id='$iid'}]
#^rem{
<table>
<tr>
	<td style="background-image:url(/manage/i/hr.gif); background-position: left bottom; background-repeat: repeat-x;"><img src="/i/1.gif" width=40 height=1></td>
#	<td><h2><nobr>&nbsp;^untaint{$tableres.content}&nbsp;</nobr></h2></td>
	<td><nobr><h2>&nbsp;^untaint{$tableres.content}&nbsp;</h2></nobr></td>
	<td style="width:100%; background-image:url(/manage/i/hr.gif); background-position: left bottom; background-repeat: repeat-x;"></td>
</tr>
</table>
#}

#<div  style="background-image:url(/manage/i/hr.gif); background-position: left bottom; background-repeat: repeat-x;">
#<div style="display:inline-block^; background-color:#ffffff^; padding:0 5px^; margin-left:100px^;"><h2>^untaint{$tableres.content}</h2></div>
#</div>

