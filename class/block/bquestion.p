@CLASS
bquestion

@show[iid]

<style>
.cell{
	display:table-cell^;
	vertical-align:top^;
}
.block_question{
	padding:20px^;
	background-color:#dddddd^;
	-moz-border-radius: 4px^;
	-webkit-border-radius: 4px^;
	border-radius: 4px^;
	font-family:Cuprum, Arial^;
	font-size:17px^;
}
.q_image{
	float: left^;
	width:30px^;
	margin-right:15px^;
}
.block_answer{
	padding:20px^;
}
.triangle{
	position: absolute^;
	margin-left: 26px^;
	width: 0^;
    height: 0^;
    border-left: 8px solid transparent^;
    border-right: 8px solid transparent^;
    border-top: 8px solid #dddddd^;
}


.form_question{
	padding:5px^;
	
}
.important_field{
	color:red^;
}

.botton_question{
	padding:10px^;
	border:0px^;
	background-color:#ececec^;
	-moz-border-radius: 4px^;
	-webkit-border-radius: 4px^;
	border-radius: 4px^;
	transition: all 0.5s ease^; 
	-webkit-transition:all 0.5s ease^;  
	-moz-transition:all 0.5s ease^; 
	-o-transition:all 0.5s ease^;
	color:#1e5d8e^;
	font-size:16px^;
	cursor:pointer^;
}
.botton_question:hover{
	background-color:#ececec^;
	color:#1e7dc7^;
}

</style>

$block[^table::sql{select * from te_question where idblock='$iid' && answer!='' && visible='1' order by sortir asc, date desc}]
^if($block){
	^block.menu{
	<div id="block_answer_$id">
		<div class="block_question">
			<div class="cell">
				<div class="q_image" align="center"><img src="/i/ico/question.png"></div>
			</div>
			<div class="cell">
				^if(def $block.username){<span style="color:#2e6b9c^;">${block.username}</span><br>} ^untaint{$block.question}
			</div>
		</div>
		<div class="triangle"></div>
		<div class="block_answer">
			<div class="cell">
				<div class="q_image" style="padding-top: 5px^;" align="center"><img src="/i/ico/answer.png"></div>
			</div>
			<div class="cell">
				^untaint{$block.answer}
				
#				^use[/class/dtf.p]
#				$datapr[^date::create[$block.date]]
#				<br><p class=p11 style="padding-bottom:5px^;color:#2e6b9c^;">^dtf:format[%d %h %Y;$datapr;$dtf:rr-locale]</p>
			</div>
		</div>
	</div>
	}
}

<div >
	<button class="botton_question hide" id="toggle_button" onclick="scroll_body(toggle_button)">
		Задать вопрос
	</button>
	
	
	^rem{
	<div class="cell">
		<div class="q_image" align="center"><img src="/i/ico/question.png"></div>
	</div>
	<div class="cell" style="vertical-align:middle">
		Задать свой вопрос
	</div>
	}
</div>
<div class="form_question" ^if(def $form:text && $form:type_ajax eq 'submit_send_question' || $form:question eq 'ok'){}{ style="display:none"}>
	^form_bquestion[]
</div>

<br><br><br>

<script type="text/javascript">
function scroll_body(id){
	if (^$('#toggle_button').hasClass("hide")) {
		^$('#toggle_button').removeClass("hide")^;
		^$('#toggle_button').addClass("show")^;
		^$('.form_question').show(500)^;
		var destination=''+^$('.form_question').offset().top^;
		destination=destination.replace('px','')^;
		^$('body,html').animate({scrollTop: destination/1-100+'px'}, 1000)^;
	}else{
		^$('#toggle_button').removeClass("show")^;
		^$('#toggle_button').addClass("hide")^;
		^$('.form_question').hide(500)^;
	}
	
	
}
function field_ok(id){
	value=^$('#'+id).val()^;
	if(value==''){
		^$('#err_'+id).show()^;
	}else{
		^$('#err_'+id).hide()^;
	}
	return value
}
function  email_ok(id){
	email=^$('#'+id).val()^;
	if(email){
		if(!validate_email(email)){
			^$('#err_'+id).show()^;
		}else{
			^$('#err_'+id).hide()^;
		}
	}
	return email
}
function validate_email(email){  
	
    var re = /^^(([^^<>()[\]\\.,^;:\s@\"]+(\.[^^<>()[\]\\.,^;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))^$/^;
    return re.test(email)^;
}

function submit_send_question(){
	var name_send=^$('#name_send').val()^;
	var email_send=email_ok('email_send')^;
	var text_send=field_ok('text_send')^;
	//var email_send=^$('#email_send').val()^;
	//var name_send=^$('#name_send').val()^;
	//var text_send=^$('#text_send').val()^;
	text_send=escape(text_send)^;
	email_send=escape(email_send)^;
	name_send=escape(name_send)^;
	text_send=text_send.replace(/\n/g,'<br>')^;
	if(text_send!='' && ((validate_email(email_send)) || email_send=='')){
		//location.href="?text="+text_send+"&email="+email_send+"&name="+name_send+"&type_ajax=submit_send_question"^;
		^$.ajax({
				type: "POST",
				async: false,
				url: "?text="+text_send+"&email="+email_send+"&name="+name_send+"&type_ajax=submit_send_question",
				scriptCharset: "utf-8" ,
				contentType: "application/x-www-form-urlencoded^; charset=UTF-8",		
				success: function(msg){
					^$('#form_send_question').trigger('reset')^;
					var width=^$('.form_question').css('width')^;
					var height=^$('.form_question').css('height')^;
					var html=^$('.form_question').html()^;
					^$('.form_question').html('<div align="center" style="padding-top:50px^;font-size:16px^;width:'+width+'^;height:'+height+'^;">Ваш вопрос принят</div>')^;
					setTimeout(function(){
						^$('.form_question').html(html)^;
					},2000)^;
				},
				error: function() {
					alert('Произошла ошибка')^;
				}
		})^;
	}
}

function ok_function(){
	scroll_body(toggle_button)^;
	var width=^$('.form_question').css('width')^;
	var height=^$('.form_question').css('height')^;
	var html=^$('.form_question').html()^;
	^$('.form_question').html('<div align="center" style="padding-top:50px^;font-size:16px^;width:'+width+'^;height:'+height+'^;">Ваш вопрос принят</div>')^;
	setTimeout(function(){
			^$('.form_question').html(html)^;
		},2000)^;
}
</script>


^if(def $form:text && $form:type_ajax eq 'submit_send_question'){
	^submit_send_question[$iid]
}	
^if($form:question eq 'ok'){
	<script type="text/javascript">
		ok_function()^;
	</script>
}


@submit_send_question[iid]
$date_now[^date::now[]] 
$date_now[^date::create(${date_now.year};${date_now.month};${date_now.day};${date_now.hour};${date_now.minute};${date_now.second})]
$date_now[${date_now.year}-${date_now.month}-${date_now.day} ${date_now.hour}:${date_now.minute}:${date_now.second}]
^if(def $form:p){
	$idpage[$form:p]
}{
	$idpage[1]
}

$idblock[$iid]
$name[^string:js-unescape[$form:name]]
$text[^string:js-unescape[$form:text]]
$email[^string:js-unescape[$form:email]]
$email[^email_proverka[$email]]
$rep[^table::create{from	to
'	\'}]
$text[^text.replace[$rep]]
$username[^username.replace[$rep]]
^void:sql{INSERT INTO te_question (date, question, email, username, idpage, idblock) VALUES ('$date_now','$text', '$email', '$name', '$idpage', '$idblock')}

$block_cfg[^table::load[/manage/textext/modules/bquestion/options.cfg]]
$send[1]
$param[^table::sql{select value from global_setting where name='email'}]
^if($param){
	$email_setting[$param.value]
}
^if($block_cfg){
^if(^block_cfg.locate[id;$idblock]){ 
	$send[$block_cfg.email_send]
	$email_setting[$block_cfg.email]
	}
}
^if(def $email_setting && $send eq '1'){
	^try{
			^mail:send[
					$.from[postmaster]
					$.to[$email_setting]
					$.charset[$response:charset]
					$.subject[На сайте $env:SERVER_NAME задан вопрос]
					$.text[На сайте $env:SERVER_NAME задан вопрос в разделе "вопросы и ответы"

^if(def $name){${name}: }$text
					]
			]
			
						   
	}{
	$exception.handled(1)
	}
}

#$response:location[?question=ok]


@email_proverka[value]
^if(def $value){
	$error(^value.match[^^[а-яА-яa-zA-Z0-9_\-\.]+@[а-яА-яa-zA-Z0-9_\-\.]+\.[а-яА-яa-zA-Z]{2,4}^$][g]{0}{1})
	^if($error==1){
		$value[]
	}
}
$result[$value]







@form_bquestion[cms;id_answer]
^if(def $id_answer){
	$block[^table::sql{select * from te_question where idpage='$form:idpage' && idblock='$form:id' && id=$id_answer}]
}
<form name="form_send_question" id="form_send_question">
^if(def $cms){

<input type="hidden" name="id" value="$form:id">
<input type="hidden" name="idpage" value="$form:idpage">
^if(def $id_answer){
<input type="hidden" name="id_answer" value="$id_answer">
}
}
	<table width="100%">
	<tr>
		<td valign="top" width="90px">Ваше имя:</td>
		<td align="left">
			<input type="text" name="name_send" id="name_send" style="^if(def $cms){width:652px^;}{width:401px^;}"  value="^if(def $id_answer){$block.username}">
		</td>
	</tr>
	<tr>
		<td valign="top">Ваш e-mail:</td>
		<td align="left">
			<input type="text" name="email_send" id="email_send" style="^if(def $cms){width:652px^;}{width:401px^;}" onchange="email_ok('email_send')" value="^if(def $id_answer){$block.email}">
			<span id="err_email_send" class="important_field" style="display:none">Неправильный e-mail</span>
		</td>
	</tr>
	<tr>
		<td valign="top">Вопрос:<span class="important_field">*</span></td>
		<td align="left" valign="top">
			<textarea style="^if(def $cms){width:647px^;}{width:400px^;}height: 200px^;" name="text_send" id="text_send" onchange="field_ok('text_send')">^if(def $id_answer){$block.question}</textarea>
			<script type="text/javascript">
				question=^$('#text_send').val()^;
				question=question.replace(/<br>/g,'\n')^;
				^$('#text_send').val(question)^;
			</script>
			<span id="err_text_send" class="important_field" style="display:none">Введите вопрос</span>
		</td>
	</tr>
^if(def $cms){
	
	<tr>
		<td valign="top">Ответ:</td>
		<td align="left" valign="top">
			^insert_tiny_my[answer]
			<textarea style="^if(def $cms){width:651px^;}{width:400px^;}height: 200px^;" name="answer" id="answer" >^if(def $id_answer){$block.answer}</textarea>
			<span id="err_text_send" class="important_field" style="display:none">Введите ответ</span>
		</td>
	</tr>
#^if(!def $id){
#	<tr>
#		<td valign="top">Отправить уведомление:</td>
#		<td align="left" valign="top">
#			<input type="checkbox" name="send_message">
#		</td>
#	</tr>
#}
}
	<tr>
		<td></td>
		<td>
			^if(!def $cms){
			Поля, отмеченные <span class="important_field">*</span>, являются обязательными для заполнения.<br>
			Вопрос будет опубликован после модерации.
			}
		</td>
	</tr>
	<tr>
		<td></td>
		<td align="left">
			^if(def $cms){
				^if(def $id_answer){
					<input type="button" value="Сохранить" onclick="submit_send_question()">
				}{	
					<input type="button" value="Добавить" onclick="submit_send_question()">
				}
				
			}{
				<input type="button" value="Отправить" onclick="submit_send_question()">
			}
		</td>
	</tr>
	</table>
</form>
	
	
	



