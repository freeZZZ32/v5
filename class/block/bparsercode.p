@CLASS
bparsercode

@show[iid]
$tableres[^table::sql{select * from te_text where id='$iid'}]
^process{^taint[as-is][$tableres.content]}