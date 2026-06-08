hovering = position_meeting(device_mouse_x(0), device_mouse_y(0), self)
if (hovering && mouse_check_button_pressed(mb_left)) {
	func()
}
if (room==Levels && followPlayer){
	x+=oSlime.xspd
	y+=oSlime.yspd
}

if (keyboard_check(vk_escape)&&keyboard_check(vk_shift)) game_end(0)
try {
	if (waiter.done){
		task()
}} catch(_expect){}