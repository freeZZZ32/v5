@CLASS
bguestbook



@show[iid]
^use[/class/controlimage.p]
^use[/class/scroller.p]
^use[/class/dtf.p]




$cfPerPage(50)

^if(def $form:bnewspage){$cNachLimit(^eval((${form:bnewspage}-1)*$cfPerPage))}{$cNachLimit(0)}

$block[^table::sql{select * from text_ext where id = '$iid'}]

^if(def $block){

^if($form:guestb == $block.id){
	^self.save_guestbook[]
}


$mess[^table::sql{select id, date_p, name, head, body from gbook where idblock='$iid' order by date_p desc}[$.limit($cfPerPage) $.offset($cNachLimit)]]
$kolvoall[^int:sql{select count(*) from gbook where idblock='$iid'}]

^if(def $mess){
<a href="#guest_add_${block.id}" class="form20">Добавить сообщение</a><br><br>
^scroller:print_scroller2[^math:ceiling(^eval($kolvoall/$cfPerPage));10]
	^mess.menu{
	<div id="guest_${mess.id}" style="padding: 10px 0^; border-bottom: #cccccc 1px solid^;">
		$datapr[^date::create[$mess.date_p]]
		<p class="ghead"><b>$mess.name</b> </p>

<span style="font-size:11px">^dtf:format[%d %h %Y в %H:%M;$datapr;$dtf:rr-locale]</span>
<br>
		<p><b>$mess.head</b></p>
#		<span class="gbody">$mess.body</span>
		<span class="gbody">^mess.body.match[\n][g]{<br>}</span>
	</div>
	
	}

<p>^scroller:print_scroller2[^math:ceiling(^eval($kolvoall/$cfPerPage));10]</p>
}
^form_show[$block.id]
}{
	Блок не найден
}



@form_show[idblock]
<a name=guest_add_$idblock>
<FORM method="post" action="" enctype="multipart/form-data" style="MARGIN-TOP: 1em">
<input name="page_p" type="hidden" value="${form:p}"> 
<input name="guestb" type="hidden" value="$idblock">
<input name="idblock" type="hidden" value="$idblock">
 
#<div>

			<table width="100%" border=0>
				<tr>
					<td width="250"><img src="/i/1.gif" width="200" height="1" alt=""></td>
					<td><img src="/i/1.gif" width="300" height="1" alt=""></td>
					
				</tr>
				<tr>
					<td class="form20">Ваше имя: *</td>
					<td><input name="name" class="v3input" style="width:100%"></td>
					
				</tr>
				<tr>
					<td class="form20">Заголовок сообщения: *</td>
					<td><input name="head" class="v3input" style="width:100%"></td>
					
				</tr>

				<tr>
					<td class="form20" valign=top>Текст сообщения: *</td>
					<td><textarea name="body" class="v3textarea" rows=10 cols=30 style="width: 100%"></textarea></td>
					
				</tr>			
				<tr>
					<td class="form20" valign=top>Контрольные цифры: ^controlimage:insert_controlimage[f6eed7]</td>
					<td><input type="text" class="v3input" name="usercode"></td>
					
				</tr>

				<tr>
					<td></td>
					<td><input type="submit" value="Добавить"></td>
					
				</tr>
				<tr>
					<td class="form20" style="font-size:16px">* Поля, обязательные для заполнения</td>
					<td></td>
					
				</tr>

			</table>

#</div>
</form>


@save_guestbook[]
^use[/class/controlimage.p]
$now[^date::now[]]

^if(def ^controlimage:proverka_controlimage[$form:usercode;$form:maxid] && def $form:usercode && def $form:maxid && def $form:name && def $form:head && def $form:body){
	
		^MAIN:dbconnect{
			^void:sql{insert into gbook (idblock, date_p, name, head, body) values ('$form:idblock','^now.sql-string[]', '$form:name', '$form:head', '$form:body')} 
		}
	<script>
		alert('Сообщение добавлено')^;
	</script>
		
		 
}{
	<script>
		alert('Поля заполнены не верно')^;
	</script>

	

}

