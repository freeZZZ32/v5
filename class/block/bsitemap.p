@CLASS
bsitemap

@show[iid]

^self.show_menu[a;0;0]
<br>
^self.show_menu[b;0;0]




@show_menu[type;parent;level][h_menu;h_menu_count;level1]
	$level1(^level.int[])
	^level1.inc[]
	$h_menu[^table::sql{select id, name, parent, uri from menus where visible='1' and id_menu='$type' and parent='$parent'  order by sortir}]
	
	^if($h_menu){
		$h_menu_count[^int:sql{select count(*) from menus where visible='1' and id_menu='$type' and parent='$parent'}]
		
		<ul style="padding: 0px 0 0px 20px^;">
			^h_menu.menu{
				
				<li style="padding: 8px 0 0px 0^;">
					<a href="^if($h_menu.id == $mainpage){/}{/^str_url[$h_menu.id]/}"><span>$h_menu.name</span></a>
					^self.show_menu[$type;$h_menu.id;$level1]
				</li>		
			}
		</ul>
		
	}	
	

	
	