draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_colour(c_white)

if (hovering){
	draw_set_font(GUI_Font)
	draw_text_transformed(oCamera.x,oCamera.y-100,global.modifierDescription[$ sprite_get_name(sprite_index)],1,1,0)
	draw_text_transformed(oCamera.x,oCamera.y-60,global.modifierStatsDescription[$ sprite_get_name(sprite_index)],1,1,0)
}

draw_self()