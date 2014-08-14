@CLASS
btext

@pre_show[]

@show[iid]
$tableres[^table::sql{select * from te_text where id='$iid'}]
^untaint{$tableres.content}