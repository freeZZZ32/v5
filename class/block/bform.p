@CLASS
bform

@show[iid]
$feedform[^table::sql{select * from text_ext where id = '$iid'}]
^if(def $feedform){

	$id_div[div_feed_${iid}]


<div id="${id_div}_otvet">
</div>
<div id="${id_div}">
</div>

<script type="text/javascript">
ajax_feed()^;


function ajax_feed(){
^$.ajax({
   type: "POST",
   url: "/class/block/bform/show_feed.html",
   data: ({form_id : $feedform.id
   }),
   success: function(msg){
	^$("#$id_div").empty()^;
 	^$("#$id_div").append(msg)^;
   }
 })^;
}
</script>
}



@setstyle[iid;feed_opt]
$style[
<style>
input.input_${iid} {
#	width: 300px^;
	width: 100%^;
	font-size: 13px^;
#	padding: 6px 0px 4px 10px^;
	padding: 6px 0px 4px 0px^;
	border: 1px solid #cecece^;
#	background: #F6F6f6^;
	border-radius: 8px^;
	-moz-border-radius:8px^;
	-webkit-border-radius:8px^;
}

textarea.input_${iid} {
	overflow: auto^;
 
	resize: none^;
#	width: 300px^;
	width: 100%^;
	height: 50px^;
 

#	background: #f6f6f6^;
	border: 1px solid #cecece^;
	border-radius: 8px^;
#	padding: 8px 0 8px 10px^;
	padding: 8px 0 8px 0px^;
}

select.input_${iid} {
	width: 100%^;
	height: 30px^;
	border: 1px solid #cecece^;
	border-radius: 8px 0px 0px 8px^;
	padding: 0px 0 0px 0px^;
}

div.tdcenter_${iid} {

}

td.tdleft_${iid} {

	^if($feed_opt.width_l eq '0'){}{width: $feed_opt.width_l^;}
	text-align: ${feed_opt.align_l}^;
	vertical-align: top^;

	padding-top: 4px^;
}

td.tdcenter_${iid} {
	^if($feed_opt.width_m eq '0'){}{width: $feed_opt.width_m^;}
	text-align: ${feed_opt.align_m}^;

#	padding: 2px 10px^;
	
}

td.tdright_${iid} {
#	^if($feed_opt.width_r eq '0'){}{width: $feed_opt.width_r^;}
	text-align: ${feed_opt.align_r}^;
	vertical-align: top^;
	padding-top: 4px^;
}

.notnull{
color: red^;
}
</style>
]
$result[$style]



@getfeedopt[iid]

$feed_opt[
$.type[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'type'}[$.default[max]]]

$.email[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'email'}[$.default[max]]]
$.url_ok[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'url_ok'}[$.default[max]]]

$.width[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'width'}[$.default[100%]]]
$.width_l[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'width_l'}[$.default[0]]]
#$.width_m[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'width_m'}[$.default[0]]]
$.width_r[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'width_r'}[$.default[0]]]

$.align_main[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'align_main'}[$.default[left]]]
$.align_l[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'align_l'}[$.default[left]]]
$.align_m[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'align_m'}[$.default[left]]]
$.align_r[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'align_r'}[$.default[left]]]

$.resetyes[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'resetyes'}[$.default[left]]]
$.but_align[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'but_align'}[$.default[left]]]
$.notnullpos[^string:sql{select value from bform_opt where id_form = '$iid' and name = 'notnullpos'}[$.default[left]]]
]
$result[$feed_opt]


@show_fos_call[]
$findformid[^string:sql{select id_form from bform_opt where name = 'type' and value = 'fos_call' limit 1}[$.default[]]]
^if(def $findformid){
	$fos[^table::sql{select id from text_ext where idpage = '0' and id = '$findformid'}]
	^if(def $fos){
		^self.show[$fos.id]
	}{
		Не найдена форма
	}
}{
	Не найдена опция type
}



@show_fos[]
$findformid[^string:sql{select id_form from bform_opt where name = 'type' and value = 'fos_main' limit 1}[$.default[]]]
^if(def $findformid){
	$fos[^table::sql{select id from text_ext where idpage = '0' and id = '$findformid'}]
	^if(def $fos){
		^self.show[$fos.id]
	}{
		Не найдена форма
	}
}{
	Не найдена опция type
}




@show_feed_form[iid]

$feed[^table::sql{select * from text_ext where id = '$iid'}]
$notnullpref[ *]
$feed_opt[^self.getfeedopt[$iid]]
$feed_style[^self.setstyle[$iid;$feed_opt]]
$feed_style
^if(def $feed){

	$feed_field[^table::sql{select * from bform_field where id_form = '$feed.id' and parent = '0' order by sortir}]
	<div id="form_otvet_${feed.id}">
	</div>
	
	^if(def $feed_field){
	
		<form method="post">
		<table ^if($feed_opt.width ne 0){width="$feed_opt.width"} align="$feed_opt.align_main" cellpadding=4 cellspacing=0 border=0>
		
		^feed_field.menu{
		^if($feed_field.parent == 0){
			^if($feed_field.type eq 'hidden'){
				<input type="hidden" id="$feed_field.name" name="$feed_field.name" ^if(def $feed_field.value){value="$feed_field.value"} ^if(def $feed_field.dopparam){$feed_field.dopparam}>
			}
		
						
			^if($feed_field.type eq 'label'){
				^if(def ${feed_field.label_t}){
				<tr>
					<td></td>
					<td valign="bottom" class="tdcenter_${feed.id}"><label  class="labelform" for="$feed_field.name">${feed_field.label_t}^if($feed_opt.notnullpos eq top){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
				<tr>
					<td class="tdleft_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_l}^if($feed_opt.notnullpos eq left){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td class="tdcenter_${feed.id}">
					<div class="tdcenter_${feed.id} labelform">$feed_field.value ^if(def $feed_field.dopparam){$feed_field.dopparam}
#					<input type="hidden" id="$feed_field.name" name="$feed_field.name" ^if(def $feed_field.value){value="$feed_field.value"} ^if(def $feed_field.dopparam){$feed_field.dopparam}>
					</div>
					</td>
					<td><label class="labelform" for="$feed_field.name">${feed_field.label_r}</label></td>
					</tr>
				^if(def ${feed_field.label_b}){
				<tr>
					<td></td>
					<td valign="top"  class="tdcenter_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_b}^if($feed_opt.notnullpos eq bottom){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
			}
			
			
			^if($feed_field.type eq 'checkbox'){
				^if(def ${feed_field.label_t}){
				<tr>
					<td></td>
					<td valign="bottom" class="tdcenter_${feed.id}"><label class="labelform">${feed_field.label_t}^if($feed_opt.notnullpos eq top){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
				<tr>
					<td class="tdleft_${feed.id}"><label class="labelform">${feed_field.label_l}^if($feed_opt.notnullpos eq left){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td class="tdcenter_${feed.id}"><input type="checkbox" id="$feed_field.name" name="$feed_field.name" ^if(def $feed_field.value){value="$feed_field.value"} ^if(def $feed_field.dopparam){$feed_field.dopparam}><label for="$feed_field.name">${feed_field.label_m}</label></td>
					<td class="tdright_${feed.id}"><label class="labelform">${feed_field.label_r}^if($feed_opt.notnullpos eq right){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
				</tr>
				^if(def ${feed_field.label_b}){
				<tr>
					<td></td>
					<td valign="top"  class="tdcenter_${feed.id}"><label class="labelform">${feed_field.label_b}^if($feed_opt.notnullpos eq bottom){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
			}
			
			^if($feed_field.type eq 'text'){
				^if(def ${feed_field.label_t}){
				<tr>
					<td></td>
					<td valign="bottom" class="tdcenter_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_t}^if($feed_opt.notnullpos eq top){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
				<tr>
					<td class="tdleft_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_l}^if($feed_opt.notnullpos eq left){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td class="tdcenter_${feed.id}"><input type="text" class="input_${feed.id}"  id="$feed_field.name" name="$feed_field.name" ^if(def $feed_field.value){value="$feed_field.value"} ^if(def $feed_field.dopparam){$feed_field.dopparam}></td>
					<td class="tdright_${iid}"><label class="labelform" for="$feed_field.name">${feed_field.label_r}^if($feed_opt.notnullpos eq right){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					</tr>
				^if(def ${feed_field.label_b}){	
				<tr>
					<td></td>
					<td valign="top"  class="tdcenter_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_b}^if($feed_opt.notnullpos eq bottom){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
			}
						
			^if($feed_field.type eq 'textarea'){
				^if(def ${feed_field.label_t}){
				<tr>
					<td></td>
					<td valign="bottom" class="tdcenter_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_t}^if($feed_opt.notnullpos eq top){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
				<tr>
					<td class="tdleft_${feed.id}"><label for="$feed_field.name" class="labelform">${feed_field.label_l}^if($feed_opt.notnullpos eq left){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td class="tdcenter_${feed.id}">			
						<textarea id="$feed_field.name" name="$feed_field.name" class="input_${feed.id}"  ^if(def $feed_field.dopparam){$feed_field.dopparam} style="$feed_field.style">
							^if(def $feed_field.value){$feed_field.value}
						</textarea>
					</td>
					<td class="tdright_${iid}"><label for="$feed_field.name" class="labelform">${feed_field.label_r}^if($feed_opt.notnullpos eq right){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					</tr>
				^if(def ${feed_field.label_b}){
				<tr>
					<td></td>
					<td valign="top" class="tdcenter_${feed.id}"><label for="$feed_field.name" class="labelform">${feed_field.label_b}^if($feed_opt.notnullpos eq bottom){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
			}			
						
			
			^if($feed_field.type eq 'password'){
				^if(def ${feed_field.label_t}){
				<tr>
					<td></td>
					<td valign="bottom"  class="tdcenter_${feed.id}" ><label for="$feed_field.name" class="labelform">${feed_field.label_t}^if($feed_opt.notnullpos eq top){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
				<tr>
					<td class="tdleft_${feed.id}"><label for="$feed_field.name" class="labelform">${feed_field.label_l}^if($feed_opt.notnullpos eq left){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td class="tdcenter_${feed.id}" ><input type="password" class="input_${feed.id}"  id="$feed_field.name" name="$feed_field.name" ^if(def $feed_field.value){value="$feed_field.value"} ^if(def $feed_field.dopparam){$feed_field.dopparam}></td>
					<td class="tdright_${iid}"><label for="$feed_field.name" class="labelform">${feed_field.label_r}^if($feed_opt.notnullpos eq right){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
				</tr>
				^if(def ${feed_field.label_b}){
				<tr>
					<td></td>
					<td valign="top" class="tdcenter_${feed.id}" ><label for="$feed_field.name" class="labelform">${feed_field.label_b}^if($feed_opt.notnullpos eq bottom){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					<td></td>
				</tr>
				}
			}
			
			
			
			
			^if($feed_field.type eq 'radio'){
				$feed_field_child[^table::sql{select * from bform_field where id_form = '$feed.id' and parent= '$feed_field.id' order by sortir}]
				^if(def $feed_field_child){
					^if(def ${feed_field.label_t}){
					<tr>
						<td></td>
						<td class="tdcenter_${feed.id}" ><label for="$feed_field.name" class="labelform">${feed_field.label_t}^if($feed_opt.notnullpos eq top){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
						<td></td>
					</tr>
					}	
					<tr>
						<td class="tdleft_${feed.id}"><label for="$feed_field.name" class="labelform">${feed_field.label_l}^if($feed_opt.notnullpos eq left){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
						<td class="tdcenter_${feed.id}">
							^feed_field_child.menu{				
								<input type="radio" class="$feed_field.name" id="${feed_field.name}${feed_field_child.id}" name="$feed_field.name" ^if(def $feed_field_child.value){value="$feed_field_child.value"} ^if(def $feed_field_child.dopparam){$feed_field_child.dopparam}>
								<label for="${feed_field.name}${feed_field_child.id}">${feed_field_child.label_m}</label><br>

							}
						<td class="tdright_${iid}"><label for="$feed_field.name" class="labelform">${feed_field.label_r}^if($feed_opt.notnullpos eq right){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					</tr>
					^if(def ${feed_field.label_b}){	
					<tr>
						<td></td>
						<td class="tdcenter_${feed.id}"><label for="$feed_field.name" class="labelform">${feed_field.label_b}^if($feed_opt.notnullpos eq bottom){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
						<td></td>
					</tr>
					}
				}
			}
			
			^if($feed_field.type eq 'select'){
				$feed_field_child[^table::sql{select * from bform_field where id_form = '$feed.id' and parent= '$feed_field.id' and type = 'option' order by sortir}]
				^if(def $feed_field_child){
					^if(def ${feed_field.label_t}){
					<tr>
						<td></td>
						<td class="tdcenter_${feed.id}" ><label class="labelform" for="$feed_field.name">${feed_field.label_t}^if($feed_opt.notnullpos eq top){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
						<td></td>
					</tr>
					}
					<tr>
						<td class="tdleft_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_l}^if($feed_opt.notnullpos eq left){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
						<td class="tdcenter_${feed.id}"><select id="$feed_field.name" name="$feed_field.name" class="input_${feed.id}"  style="width: 100%^;">
						^feed_field_child.menu{
							<option value="${feed_field_child.value}" ^if(def $feed_field_child.dopparam){$feed_field_child.dopparam}>${feed_field_child.label_m}</option>
						}
						</select>
					</td>
					<td class="tdright_${iid}"><label class="labelform" for="$feed_field.name">${feed_field.label_r}^if($feed_opt.notnullpos eq right){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
					</tr>
					^if(def ${feed_field.label_b}){
					<tr>
						<td></td>
						<td  class="tdcenter_${feed.id}"><label class="labelform" for="$feed_field.name">${feed_field.label_b}^if($feed_opt.notnullpos eq bottom){<span class="notnull">^if($feed_field.notnull == 1){$notnullpref}</span>}</label></td>
						<td></td>
					</tr>
					}
				
				}
			}
			
			
			
		}
		}
	<tr>
	<td colspan="3" align="$feed_opt.but_align">
		^if($feed_opt.resetyes eq 1){
			<span><input type="reset" value="Сбросить" id="butreset_${feed.id}" style="height:30px^; background-color: White^; border: 1px solid #cecece^; cursor: pointer^; border-radius: 8px^;"></span>
		}{
			<span style="display: none^;"><input type="reset" id="butreset_${feed.id}" value="Сбросить" style="height:30px^; background-color: White^; border: 1px solid #cecece^; cursor: pointer^; border-radius: 8px^;"></span>
		}
		<input type="button" id="submitfeed_${feed.id}" value="Отправить" style="height:30px^; background-color: White^; border: 1px solid #cecece^; cursor: pointer^; border-radius: 8px^;">
	</td>
	</tr>
	</table>
	</form>
	

<script type="text/javascript">

^$("#submitfeed_${feed.id}").click(send_mail)^;	

function send_mail(){

^$.ajax({
	type: "POST",
	url: "/class/block/bform/send.html",
	scriptCharset: "utf-8" ,
	contentType: "application/x-www-form-urlencoded^; charset=UTF-8",
	data: ({
		form_id : ${feed.id},
		^feed_field.menu{
			^if($feed_field.type eq checkbox || $feed_field.type eq radio){
				^if($feed_field.type eq checkbox){
					$feed_field.name : ^$("#${feed_field.name}:checked").val()
				}
			
				^if($feed_field.type eq radio){
					$feed_field.name : ^$(".${feed_field.name}:checked").val()
				}
			}{
				$feed_field.name : ^$("#$feed_field.name").val()
			}
		}[,]
	}),
	success: function(msg){
	  	^$("#form_otvet_${feed.id}").html(msg)^;
	}
	})^;
}
</script>	
	
	
}	

}


