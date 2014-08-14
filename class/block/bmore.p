@CLASS
bmore

@show[iid]
$tableres[^table::sql{select * from te_text where id='$iid'}]




<script type="text/javascript">
^$(document).ready(function () {
^$("#ext_div_${tableres.id}").hide()^;
^$("#a_sho_${tableres.id}").hide()^;

^$("#a_ext_${tableres.id}").click(function () {
^$("#a_sho_${tableres.id}").toggle('slow')^;
^$("#a_ext_${tableres.id}").hide()^;
^$("#ext_div_${tableres.id}").toggle('slow')^;
})^;

^$("#a_sho_${tableres.id}").click(function () {
^$("#a_ext_${tableres.id}").toggle('slow')^;
^$("#a_sho_${tableres.id}").hide()^;
^$("#ext_div_${tableres.id}").toggle('slow')^;
})^;

})^;
</script>


#<div id="a_ext_${tableres.id}"  style="width:100%^;margin-top:5px^;text-align:center^;cursor:pointer^; border:1px dashed #ffffff^;padding:3px^;display:inline-block^;"><span class="color_marker">Подробнее &darr^;</span></div>
<div id="a_ext_${tableres.id}" class="zakladka"  style="width:100%^;margin-top:5px^;text-align:center^;cursor:pointer^; border:0px^;padding:3px^;display:inline-block^;"><span class="color_marker">Подробнее &darr^;</span></div>


#<div id="ext_div_${tableres.id}" style="padding:10px^;margin-top:5px^;border:1px dashed #ffffff^;">
<div id="ext_div_${tableres.id}" class="zakladka" style="padding:10px^;margin-top:5px^;border:0px^;">

^untaint{$tableres.content}


#<div id="a_sho_${tableres.id}"  style="width:100%^;text-align:center^;cursor:pointer^; border-top:1px dashed #ffffff^;padding:3px^;display:inline-block^;"><span class="color_marker">Кратко &uarr^;</span></div>
<div id="a_sho_${tableres.id}" class="zakladka" style="width:100%^;text-align:center^;cursor:pointer^; border-top:0px^;padding:3px^;display:inline-block^;"><span class="color_marker">Кратко &uarr^;</span></div>

</div>

<p>&nbsp^;</p>