################################
# 20080908 GKE
# + проставляем последний визит	
#	^void:sql{UPDATE $table_users set user_password='$pass_md5',user_lastvisit='^now.unix-timestamp[]' where user_id='$checkuserlogin.user_id'}
# + getSessionById


@CLASS
auth

##############################
# инициализация переменных
@declareVars[]
$table_users[auth_accounts]
$table_sessions[auth_asession]
$cookiename[auth_sid]
$status[ok]
$now[^date::now[]]
$nowdec1[^date::create($now-1/6)] 
$user_ip[$env:REMOTE_ADDR]
$user_ip16[^user_ip.match[(\d+)\.(\d+)\.(\d+)\.(\d+)][g]{^match.1.format[%02x]^match.2.format[%02x]^match.3.format[%02x]^match.4.format[%02x]}]


##############################
# constructor
#
@init[]
$servername[http://${env:SERVER_NAME}]
^self.declareVars[]

^if(!def $cookie:[$cookiename]){
	$gen_Sid[^self.makeRandomID[]]
	^self.WriteCookie[$cookiename;$gen_Sid]
}

^if(def $cookie:[$cookiename]){
	$session[^self.FindSession[$cookie:[$cookiename];$user_ip16]]
}{
#куки не поддерживаются
$status[cookie not enabled]
}


##############################
# FindSession
#ищем сессию в бд с кукой пользователя и возвращаем строку из таблицы $table_sessions
@FindSession[sSid;sIPAddr]
^MAIN:dbconnect{
	^void:sql{delete from $table_sessions where dt_logon < '^nowdec1.sql-string[]'}
	$findsession[^table::sql{select id, user_id, sid, ipaddr from $table_sessions where sid='$sSid' AND ipaddr='$sIPAddr'}]

#если есть, выдергиваем данные из таблицы, если нет, пишем в бд и выдергиваем данные
	^if($findsession){
		^void:sql{update $table_sessions set dt_logon='^now.sql-string[]' where sid='$sSid' AND ipaddr='$sIPAddr'}
		$result[$findsession]
	}{
		$result[^self.WriteAsession[0;$sSid;^now.sql-string[];$sIPAddr]]
	}
}

##############################
# WriteAsession
# записываем в $table_sessions строку сессии и возвращаем данные из таблицы $table_sessions
@WriteAsession[iUser;sSid;dDtlogon;sIPAddr]
^MAIN:dbconnect{
	^void:sql{insert into $table_sessions (user_id, sid, dt_logon, ipaddr) values ('$iUser', '$sSid', '$dDtlogon', '$sIPAddr')}
	$result[^table::sql{select id, user_id, sid, ipaddr from $table_sessions where sid='$sSid' AND ipaddr='$sIPAddr'}]
}


##############################
# запись кук
@WriteCookie[sName;sValue;iExpires]
^if(def $sName){
	$cookie:[$sName][
		$.value[$sValue]
		^if($iExpires){
			$.expires($iExpires)
		}{
			$.expires[session]
		}
	]
}
$result[]



##############################
# возвращает строку  random
@makeRandomID[]
$result[^math:md5[^now.sql-string[]^math:random(1000000)]]
^if(^result.length[] >= 63){$result[^result.left(63)]}


##############################
# getUserByID
# возвращаем все данные пользователя
@getUserByID[iUserID]
^if(def $iUserID){$whereid[$iUserID]}{$whereid[0]}
^MAIN:dbconnect{
	$result[^table::sql{select * from $table_users where user_id='$whereid'}]
}
##############################
# удаление пользователя
@delUserByID[iUserID]
^MAIN:dbconnect{
	^void:sql{delete from $table_users where user_id='$iUserID'}
	^void:sql{delete from $table_sessions where user_id='$iUserID'}
}

##############################
# возвращаем всех пользователей
@getAllUsers[]
^MAIN:dbconnect{
	$result[^table::sql{select * from $table_users order by user_id}]
}

##############################
# checkUserByLogin
# возвращаем кол-во пользователей у которых такой же логин
@checkUserByLogin[sLogin]
$sLogin_no_rus[^sLogin.match[\b([а-я]+)\b(\s+|^$)][gi]{}]
^MAIN:dbconnect{
	$result[^int:sql{select count(*) from $table_users where username='$sLogin'}]
}




##############################
# check email format
@isEmail[sEmail][result]
$result(
	def $sEmail
	&& ^sEmail.pos[@] > 0
	&& ^sEmail.match[^^(?:[-a-z\d\+\*\/\?!{}`~_%&'=^^^$#]+(?:\.[-a-z\d\+\*\/\?!{}`~_%&'=^^^$#]+)*)@(?:[-a-z\d_]+\.){1,60}[a-z]{2,6}^$][i]
)



##############################
# LogIn
# вход
@LogIn[sLogin;sPassword]
$pass_md5[^math:md5[$sPassword]]
^MAIN:dbconnect{
$checkuserlogin[^table::sql{select user_id from $table_users where username='$sLogin' and u_password_md5='$pass_md5'}]
	^if($checkuserlogin && def $session.id){
	^void:sql{UPDATE $table_sessions set user_id='$checkuserlogin.user_id' where id='$session.id'}
# проставляем последний визит	
	^void:sql{UPDATE $table_users set user_lastvisit='^now.unix-timestamp[]' where user_id='$checkuserlogin.user_id'}
############
	$result[login]
	}{
$result[user not fount or sid not defined]
	}
}

##############################
# LogOut
# выход
@LogOut[]
^if(def $session.id){
	^MAIN:dbconnect{
		^void:sql{UPDATE $table_sessions set user_id='0' where id='$session.id'}
	}
	^self.WriteCookie[$cookiename]
	$result[logout]
}{
	$result[sid not defined]
}

##############################
# Demon
# вход под демоном
@Demon[iUser;iSid]
#$session.sid
^if(def $iUser && def $iSid){
	^MAIN:dbconnect{
		^void:sql{UPDATE $table_sessions set user_id='$iUser' where id='$iSid'}
	}
	$result[login]
}{
	$result[iUser or iSid not defined]
}


##############################
# форма регистрации
# sType - тип формы в зависимости от проекта sAction - урл акшина sb64Back - респонс бэк в бэйс64 iUserID- ид юзера, не уверен нужен ли он нам
@registration_form[sType;sAction;sb64Back;uid;freadonly]

$p_readonly[]
^if(def $freadonly){$p_readonly[readonly]}

^if(def $uid){
	$all_user_data[^self.getUserByID[$uid]]
}{
	$all_user_data[^self.getUserByID[$session.user_id]]
}

^if($all_user_data){$targetdata[db]}{$targetdata[form]}

<form method="POST" enctype="multipart/form-data" action="$sAction" style="MARGIN-TOP: 0em^; MARGIN-BOTTOM: 0em">
<input type=hidden name="back" value="$sb64Back">
<input type=hidden name="faction" value="$sAction">
<input type=hidden name="project" value="$sType">
<input type=hidden name="from" value="$sType">
<table width="100%" border=0 cellpadding=2 cellspacing=1>
#<tr>
#<td><img src="/i/1.gif" width=150 height=1 alt="" border="0"></td>
#<td><img src="/i/1.gif" width=10 height=1 alt="" border="0"></td>
#<td width=50%><img src="/i/1.gif" width=150 height=1 alt="" border="0"></td>
#<td width=50%><img src="/i/1.gif" width=140 height=1 alt="" border="0"></td>
#</tr>

^if($all_user_data){
	$event_now[reg]
		<tr>
			<td valign=top><span class="form20">E-mail</span></td>
			<td></td>
			<td valign=top><span class="form20">$all_user_data.username</span></td>
			<td></td>
		</tr>
}{
	$event_now[new]
}

$reg_fields[^self.allFields[]]
^reg_fields.menu{
	^if(($event_now eq $reg_fields.event || $reg_fields.event eq all) && ($reg_fields.project eq main || $reg_fields.project eq $sType)){

		^if($targetdata eq db){
			^switch[$reg_fields.type]{
				^case[checkbox]{$form_value[value=^if(def $reg_fields.sql1){"$all_user_data.[$reg_fields.sql1]" ^if($all_user_data.[$reg_fields.sql1] eq 1){checked}}]}
				^case[password]{$form_value[value=""]}
				^case[DEFAULT]{$form_value[value="^if(def $reg_fields.sql1){$all_user_data.[$reg_fields.sql1]}"]}
			}
			
		}{
			^switch[$reg_fields.type]{
				^case[text]{$form_value[value="$form:[$reg_fields.name]"]}
				^case[checkbox]{$form_value[value="1" ^if($form:[$reg_fields.name]==1){checked}]}
				^case[password]{$form_value[value=""]}
				
			}
			
		}
		
		^if($reg_fields.type eq "hidden"){
			<input id="$reg_fields.name" name="$reg_fields.name" type="$reg_fields.type" value="$reg_fields.public">
		}{
		<tr>
			<td valign=top width="80px"><span class="form20">$reg_fields.public</span></td>
			<td valign=top width="20px"><span class="reg_name_red">$reg_fields.ob</span></td>
			<td valign=top width="200px">
				<input $p_readonly class="v3input" id="$reg_fields.name" name="$reg_fields.name" type="$reg_fields.type" style="width:100%"
					^if($reg_fields.maxl > 0){maxlength="$reg_fields.maxl"} $form_value>
				

			
			</td>
			<td valign=top><span class="reg_comment">
				^if($reg_fields.name eq login){
					
					^self.InsertScriptCheck[]
					<a onclick="checkLogin(self)" href="#"><div style="display:inline-block^; padding:0 6px^;
					  background-color:#CDFF8D^;
					  border:1px solid #666666^;
					  color:#333333^;
					  cursor:pointer^;
					  line-height:26px^;			
					">Проверить</div></a>
					<div id="ErrorLogin"></div>
					
				}			
			
#			$reg_fields.comment</span>
</td>
		</tr>
		}	
			
	}
}


<tr>
	<td></td>
	<td></td>
	<td colspan=2>
	<span class="reg_name"><b>Внимание!</b> Поля, отмеченные </span>
	<span class="reg_name_red">*</span>
	<span class="reg_name">, являются обязательными для заполнения</span>
	</td>
</tr>





<tr>
	<td></td>
	<td></td>
	<td valign=top><input class="v3button_big" type="submit" name="registration" value="Готово" ^if(def $p_readonly){disabled}></td>
	<td></td>
</tr>
</table>
</form>




@NewUserfast[hParams]
$gen_logpwd[^self.makeRandomID[]]
^MAIN:dbconnect{
	^if(^self.checkUserByLogin[$gen_logpwd] eq 0){
	^void:sql{INSERT into $table_users (username, u_password_md5, user_email, fio, phone) values ('$gen_logpwd', '^math:md5[$gen_logpwd]', '$hParams.email', '$hParams.fio', '$hParams.phone')}

^self.LogIn[$gen_logpwd;$gen_logpwd]
$response:location[${servername}/basket/order/]


	}{
	Ошибка, повторите попытку
	}
}



@NewUser[hParams;sProject]
$new_user_error[]


#^if(def $hParams.cimage){
#^use[/class/controlimage.p]
#	^if(!def ^controlimage:proverka_controlimage[$hParams.cimage;$hParams.maxid]){
#		$new_user_error[$new_user_error Не верно введены Контрольные цифры.]
#	}
#
#}{
#$new_user_error[$new_user_error Не заполнено поле Контрольные цифры.]
#}


^if(def $hParams.login){
	^if(^self.isEmail[$form:login]){
		^if(^self.checkUserByLogin[$hParams.login] eq 0){
#			login - $hParams.login ok
		}{
			$new_user_error[$new_user_error Логин уже занят.]
		}
	}{
		$new_user_error[$new_user_error E-mail некорректен.]
	}
}{
$new_user_error[$new_user_error Не заполнено поле "Логин".]
}



#^if(def $hParams.password){
#	^if($hParams.password eq $hParams.confirm){
#	}{
#	$new_user_error[$new_user_error Пароли не совпадают.]
#	}
#}{
#$new_user_error[$new_user_error Не заполнено поле "Пароль".]
#}




#^if(def $hParams.email){
#	^if(^self.isEmail[$hParams.email]){
#	}{
#	$new_user_error[$new_user_error E-mail некорректен.]
#	}
#}{
#$new_user_error[$new_user_error Не заполнено поле "E-mail".]
#}

#проверка заполненности необходимых полей проекта
	$reg_fields[^self.allFields[]]
	^reg_fields.menu{
		^if($reg_fields.project eq $sProject && $reg_fields.ob eq '*' && ($reg_fields.event eq all || $reg_fields.event eq new)){
			^if(!def $form:[$reg_fields.name]){
				$form_def_error[error]
				$new_user_error[$new_user_error Не заполнено поле $reg_fields.public]
			}
		}
	}
	

^if(def $new_user_error){
<span class=reg_name>Возникли следующие ошибки:</span><br><span class=reg_name_text_red>$new_user_error</span>

^self.registration_form[$sProject;$hParams.faction;$hParams.back]

}{



	^if($form_def_error eq error){
		^self.registration_form[$sProject;$hParams.faction;$hParams.back]
	}{
		all ok1<br><br>

#############

$my_rnd_password(20000 + ^math:random(10000))


	$new_sql_fields[username, u_password_md5, user_email, user_regdate]
	
#	$new_sql_values['$form:login', '^math:md5[$form:password]', '$form:email', '^now.unix-timestamp[]']
	$new_sql_values['$form:login', '^math:md5[$my_rnd_password]', '$form:email', '^now.unix-timestamp[]']
	
	^reg_fields.menu{
		^if(($reg_fields.project eq $sProject || $reg_fields.project eq main) && ($reg_fields.troub ne y) && ($reg_fields.event eq all || $reg_fields.event eq new)){
			$new_sql_fields[$new_sql_fields, $reg_fields.sql1]
			$new_sql_values[$new_sql_values, '$form:[$reg_fields.name]']
		}
	}
#поля: $new_sql_fields<br>
#значения: $new_sql_values<br>

^MAIN:dbconnect{
	^void:sql{insert into $table_users ($new_sql_fields) values ($new_sql_values)}

	$gs_company[^string:sql{select value from global_setting where name='company'}[$.default[]]]

}




#отправляем емейл с паролем

^try{

			$body[$form:fio, теперь Вы зарегистрированный пользователь Интернет-магазина $gs_company http://${env:SERVER_NAME} ^#0A
Ваш пароль: $my_rnd_password

С уважением, 
$gs_company]
	
		^mail:send[
				$.from[postmaster]
				$.to[$form:login]
				$.charset[$response:charset]
				$.subject[Регистрация в Интернет-магазине $gs_company http://${env:SERVER_NAME}]
				$.text[$body]
		]
		
                       
}{
$exception.handled(1)
}


#^self.LogIn[$form:login;$form:password]
^self.LogIn[$form:login;$my_rnd_password]


###########


#############
#$result[$form:back]
$response:location[^untaint{$form:back}]
#$resp[^string:base64[$form:from]] 
#$response:location[$servername^untaint{$resp}]

#project - $sProject

	}

}




@EditUser[hParams;sProject]
$edit_user_error[]
$new_password[]
^if(def $hParams.password){
	^if($hParams.password eq $hParams.confirm){
#	password $hParams.password ok
		$new_password[, u_password_md5='^math:md5[$form:password]']
	}{
		$edit_user_error[$edit_user_error Пароли не совпадают.]
	}
}

#^if(def $hParams.email){
#	^if(^self.isEmail[$hParams.email]){
##	email $hParams.email ok
#	}{
#	$edit_user_error[$edit_user_error E-mail некорректен.]
#	}
#}{
#	$edit_user_error[$edit_user_error Не заполнено поле "E-mail".]
#}

^if(def $edit_user_error){
<span class=reg_name>Возникли следующие ошибки:</span><br><span class=reg_name_text_red>$edit_user_error</span>

^self.registration_form[$sProject;$hParams.faction;$hParams.back]

}{

#проверка заполненности необходимых полей проекта
	$reg_fields[^self.allFields[]]
	^reg_fields.menu{
		^if($reg_fields.project eq $sProject && $reg_fields.ob eq '*' && ($reg_fields.event eq all || $reg_fields.event eq reg)){
			^if(!def $form:[$reg_fields.name]){$form_def_error[error]}
		}
	}

	^if($form_def_error eq error){
		^self.registration_form[$sProject;$hParams.faction;$hParams.back]
	}{
		all ok1<br><br>
	$new_sql_fields_update[user_email='$form:email' $new_password]
	^reg_fields.menu{
		^if(($reg_fields.project eq $sProject && ($reg_fields.event eq all || $reg_fields.event eq reg)) || ($reg_fields.project eq main && $reg_fields.troub eq n)){
			^if(def $reg_fields.sql1){
				$new_sql_fields_update[$new_sql_fields_update, $reg_fields.sql1='$form:[$reg_fields.name]']
			}
			
		}
	}
#поля: $new_sql_fields_update<br>
#project: $sProject
###
^MAIN:dbconnect{
	^void:sql{UPDATE $table_users set $new_sql_fields_update WHERE user_id='$session.user_id'}
}
$response:location[^untaint{$form:back}]


	}
}


# задаем новый пароль для пользователя
@User_New_Pass[hParams]
^if(def $hParams.password && $hParams.user_id){
	
	^MAIN:dbconnect{
		^void:sql{UPDATE $table_users set u_password_md5='^math:md5[$hParams.password]' WHERE user_id='$hParams.user_id'}
	}
}


@allFields[]
#$result[^table::load[/registration.table]]
$result[^table::load[/class/auth/registration.table]]


@InsertScriptCheck[]
<script type="text/javascript">
function checkLogin(sel)
{
		
		jQuery.get("/class/auth/checklogin.html", { login: jQuery("#login").val(), uid: Math.random()},
		function(data){
			jQuery('#ErrorLogin').html(data);
		});
		
		
		return false^;

}




		
</script>

















