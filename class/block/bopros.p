@CLASS
bopros

@USE
/class/calendar.p

@BASE
calendar

@show[iid]
<script type="text/javascript">
	function ajax_opros_show(iid){
		^$.ajax({
			url: "/class/block/bopros/show.html",
			data: ({opros_id : iid
	   		}),
			success: function(msg){
				^$("#opros"+iid).html(msg)^;
			}	
		})^;
	}
	
	
	function ajax_opros_vote(iid){
#		if(otvet){
#		^$(".opros_otvet_${opros.id}:checked").val()
			^$.ajax({
			url: "/class/block/bopros/send.html",
			data: ({opros_id : iid,
			opros_otvet : ^$(".opros_otvet_"+iid+":checked").val()
	   		}),
			success: function(msg){
				^$("#opros"+iid).html(msg)^;
			}	
			})^;
#		}
#		else
#		{
#			alert("Ќе выбран ответ")^;
#		}

	}
</script>
<style type="text/css">
div.opros_div:hover{
	background-color:#f7f7f7^;
	
}
</style>

^checkdate[]

$block[^table::sql{select *  from bopros where idblock='$iid' and parent='0' and visible='1' order by sortir}]

^if(def $block){
	^block.menu{
		$blockchildcount[^int:sql{select count(*)  from bopros where idblock='$iid' and parent='$block.id'}[$.default(0)]]
		^if($blockchildcount > 0){
		^self.setnullcookie[$block.id;0]
		<div id="opros${block.id}"></div>
	
		<script type="text/javascript">
			ajax_opros_show(${block.id})^;
		</script>	
			
		}
	}
}


@show_opros[iid]
	^if(^self.getVoteCookie[$iid]){
		$opros[^table::sql{select *  from bopros where id='$iid' and parent='0' and visible='1'}]
		^if(def $opros){
			$oproschild[^table::sql{select * from bopros where parent='$opros.id' order by sortir}]
			^if(def $oproschild){
			
				$maxprg[^int:sql{select max(itogo) from bopros where parent='$iid'}]
				$vsego[^int:sql{select sum(itogo) from bopros where parent='$iid'}]
			
			
			
#		$opros_vyvod[^table::sql{select id, value, parent, visible, ndt, kdt, itogo from bopros where parent='$idopros' order by id}]
#		$opros_name[^string:sql{select value from bopros where id='$idopros'}]


#		^if($maxprg==0){$maxprg(1000)}
#		^if($vsego==0){$vsego(1000)}

		<div style="margin-bottom:15px^;">
		<div class="tipa_h2">$opros.value</div>
			<table><tr><td width="100%"></td><td></td></tr>
			^oproschild.menu{
				$percent(^eval(${oproschild.itogo}/${vsego}*100))
				$widthpercent(^eval(${oproschild.itogo}/${maxprg}))
				<tr><td colspan="2" >$oproschild.value</td></tr>
				<tr><td align="center" style="background-color:#f7f7f7^;" class="opros_child_tr${opros.id}">
				<div id="opros_child_wid${oproschild.id}" style="position:absolute^; background-color:#dae1e8^;">&nbsp^;</div>
				<div style="text-align:center^; position:relative^; z-index:10^;">
					<script>
						var allwidth=^$(".opros_child_tr${opros.id}").width()^;
						var elwidth=$widthpercent * allwidth^;
						^$("#opros_child_wid${oproschild.id}").width(elwidth)^;
					</script>
					$oproschild.itogo
				</div>
				</td><td><b>^percent.format[%.0f]%</b></td>
				</tr>
			}
			$okonch10(^eval($vsego%10))
			$okonch100(^eval($vsego%100))
			<tr><td>^if($okonch10==1 && $okonch100!= 11){ѕроголосовал}{ѕроголосовало} <b>$vsego</b> ^if($okonch10==2 ||$okonch10==3||$okonch10==4){человека}{человек}.</td></tr>
			</table>
		</div>

			}
		}
		
		
	}{

		$opros[^table::sql{select *  from bopros where id='$iid' and parent='0' and visible='1'}]
		^if(def $opros){
			$oproschild[^table::sql{select * from bopros where parent='$opros.id' order by sortir}]
			^if(def $oproschild){

#				<form name="opros" id="opros" action="$sAction" method="post">
				<div style="margin-bottom:15px^;">
				<div class="tipa_h2">$opros.value</div>
				  
				^oproschild.menu{
					<div style="padding:3px 0px^;" class="opros_div">	
						<input id="otvet_$oproschild.id" class="opros_otvet_${opros.id}" name="opros_otvet_${opros.id}" value="$oproschild.id" type="radio" 
						onclick='ajax_opros_vote(${opros.id})' style="cursor:hand^; cursor:pointer^;">
						<label onclick='ajax_opros_vote(${opros.id})' for="otvet_$oproschild.id" style="cursor:hand^; cursor:pointer^;">$oproschild.value</label>
					</div>
					<div style="height:1px^; background-color:#f7f7f7"></div>
				}
#				<div align="center" style="padding:5"><input type="button" value="√олосовать" onclick='ajax_opros_vote(${opros.id},^$(".opros_otvet_${opros.id}:checked").val())'  style="width: 120px^;font-size:12px^; border:1px solid #C2C2C2^;background-color:#FFFFFF^;"></div>
#				</form>
				
				$maxprg[^int:sql{select max(itogo) from bopros where parent='$iid'}]
				$vsego[^int:sql{select sum(itogo) from bopros where parent='$iid'}]
				
				$okonch10(^eval($vsego%10))
				$okonch100(^eval($vsego%100))
				<div>^if($okonch10==1 && $okonch100!= 11){ѕроголосовал}{ѕроголосовало} <b>$vsego</b> ^if($okonch10==2 ||$okonch10==3||$okonch10==4){человека}{человек}.</div>
				</div>
			}
				
		}
	}

	
@opros_vote[iid;vote]
^self.setcookie[$iid;$vote]

^void:sql{update bopros set itogo=itogo+1 where id='$vote'}

^self.show_opros[$iid]


##################################################################
# увеличиваем ответ с номером id на 1 единицу
@setVoteID[voteID][idparent]
^if(def $voteID){
^MAIN:dbconnect{^void:sql{update bopros set itogo=itogo+1 where id='$voteID'}}
^MAIN:dbconnect{$idparent(^int:sql{select parent from bopros where  id='$voteID'}[$.default[0]])}
^setVoteCookie[$idparent]
}

##################################################################
# создаем куку с номером опроса и 1
@setcookie[idcookie;value]
	$cookie:opros$idcookie[
		$.value[$value]
		$.expires[14]
	]


@setnullcookie[idcookie;value]
^if(!def $cookie:opros$idcookie){
	$cookie:opros$idcookie[
		$.value[$value]
		$.expires[14]
	]
}


##################################################################
# обнул€ем куку с номером опроса и 1
@clear_cookie[idcookie]
$cookie:opros$idcookie[]


##################################################################
# обнул€ем все куки
@clear_all_cookie[]
#  инициализируем куки и заполн€ем их нул€ми
^MAIN:dbconnect{$alloprosid[^table::sql{select id from bopros where parent=0} order by id]}
^alloprosid.menu{^self.clear_cookie[$alloprosid.id]}
^self.init[]

##############################
# увеличиваем куку с номером опроса на 1
@inccookie[idcookie]
^if(def $cookie:opros$idcookie){
	$cookie:opros$idcookie[^eval($cookie:opros$idcookie+1)]
}


##############################
# автоматическое отключение опросов
@checkdate[]
	^use[/class/calendar.p]
	^void:sql{update bopros set visible=0 where visible=1 and ndt>kdt}
	^void:sql{update bopros set visible=0 where visible=1 and kdt<'^calendar:getNowSqlDate[]'}
	^void:sql{update bopros set visible=0 where visible=1 and ndt>'^calendar:getNowSqlDate[]'}


##############################
# создаем куку с номером опроса и 1 
# чтобы записать что человек уже проголосовал
@setVoteCookie[idcookie]
^if(!def $cookie:opros$idcookie){
	$cookie:opros_vote$idcookie[
		$.value[yes]
		$.expires[1]
	]
}
##############################
# провер€ем голосовал ли пользователь
@getVoteCookie[idcookie]
^if(def $cookie:opros$idcookie){
	^if($cookie:opros$idcookie == 0){$result(false)}{$result(true)}
}{
	$result(false)
}	
@getVoteCookie2[idcookie]
$cookie:opros$idcookie


##############################
# выводим опрос
# јргументы
# $sAction - форма принимающа€ ответ запроса
#			 в форму передаютс€ следуюущие параметры
#	$form:voteID	- номер ответа
#   $form:oprosID	- номер опроса
@get_next_opros[idparent;sAction][sAction]
^disableOpros[]

^MAIN:dbconnect{$OprosCount[^int:sql{select count(id) from bopros where parent=$idparent and visible=1}]}

^if($OprosCount>0){

^try{ 
	^MAIN:dbconnect{$oprosid[^table::sql{select id, value from bopros where parent=$idparent and visible=1 order by id limit $cookie:opros$idparent,1}]}
}{ 
    $exception.handled(true) 
	^self.clear_all_cookie[]
	^MAIN:dbconnect{$oprosid[^table::sql{select id, value from bopros where parent=$idparent and visible=1 order by id limit $cookie:opros$idparent,1}]}
} 	
	
	
	^if(^oprosid.count[]>0){
		^MAIN:dbconnect{$opros_vyvod[^table::sql{select id, value, parent from bopros where parent=$oprosid.id order by id}]}
		
		^if(^self.getVoteCookie[$oprosid.id]){
			^self.print_result_opros[$oprosid.id]
		}{
			^self.print_opros[$sAction]
		}
		^self.inccookie[$idparent]
	}{
		$cookie:opros$idparent[0]
		^self.get_next_opros[$idparent;$sAction]
	}
}


@insert_script[]
<script type="text/javascript" src="/class/script/ajax.js"></script>	
<script type="text/javascript" src="/class/opros_v2.js"></script>


##############################
# выводит опрос
#
@print_opros[sAction][sAction;flag]
^self.insert_script[]
<div id="opros_class">


<form name="opros" id="opros" action="$sAction" method="post">
<input type="hidden" name="oprosID" value="$opros_vyvod.parent">
<table class="opros_vote" border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	  <th colspan="2"><p align=left><b>$oprosid.value</b></p></th>
	</tr>   
	
	^opros_vyvod.menu{
	<tr>
	  <td colspan="2">
		<input id="voteID${opros_vyvod.id}" name="voteID" value="$opros_vyvod.id" type="radio">
		
		<label for="voteID${opros_vyvod.id}">$opros_vyvod.value</label>
	</td>
	</tr>

	}
	<tr><td colspan="2" align="center" style="padding:5"><input type="button" value="√олосовать" onclick="chOpros(this,1)"  style="width: 120px;font-size:12px; border:1px solid #C2C2C2;background-color:#FFFFFF;"></td></tr>
	<tr><td colspan="2" align="center"><label onclick="chOpros(this,0)"  style="width: 120px;cursor:pointer;text-decoration: underline">–езультаты</label></td></tr>
</table>
</form>

</div>




##############################
# выводит результат опроса с номером - idopros
#
@print_result_opros[idopros]
^MAIN:dbconnect{$opros_vyvod[^table::sql{select id, value, parent, visible, ndt, kdt, itogo from bopros where parent='$idopros' order by id}]}
^MAIN:dbconnect{$opros_name[^string:sql{select value from bopros where id='$idopros'}]}
^MAIN:dbconnect{$maxprg[^int:sql{select max(itogo) from bopros where parent='$idopros'}]}
^MAIN:dbconnect{$vsego[^int:sql{select sum(itogo) from bopros where parent='$idopros'}]}

	^if($maxprg==0){$maxprg(1000)}
	^if($vsego==0){$vsego(1000)}


	<table class="opros_result" border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
		  <th><p align=left><b>–езультаты опроса<br>$opros_name</b></p></th>
		</tr>
		^opros_vyvod.menu{
			$a((100*$opros_vyvod.itogo)/$maxprg)
			$b(120*$a/100)
			$c($opros_vyvod.itogo*100/$vsego)
				
			<tr><td><li>$opros_vyvod.value</li></td></tr>
			<tr><td><img src="/class/opros/prg.jpg" height="8" width="$b"> $opros_vyvod.itogo (^c.format[%.2f]%)</td></tr>
			
			<tr><td class="aL">&nbsp^;</td></tr>
		</tr>

		}
		<tr><td>¬сего проголосовало - $vsego</td></tr>
	</table>


##############################
# выводим все опросы
# где родитель  $idparent
@print_all_opros[idparent]
^MAIN:dbconnect{$opros_all[^table::sql{select id, value from bopros where parent='$idparent' order by id}]}


<table class="vote" border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
	  <th colspan="2">Ќазвание опроса</th>
	</tr>    
	^opros_all.menu{
	<tr>
		<td>$opros_all.value</td>
		<td><a href="?op=$opros_all.id">–езультаты</a></td>
	</tr>

	}
	<tr><th colspan="2">&nbsp^;</th></tr>
</table>