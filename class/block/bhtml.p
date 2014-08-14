@CLASS
bhtml

@show[iid]
$tableres[^table::sql{select * from te_text where id='$iid'}]
^untaint{$tableres.content}
