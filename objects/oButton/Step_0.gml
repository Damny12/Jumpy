hovering = position_meeting(device_mouse_x(0), device_mouse_y(0), self)
if (hovering && mouse_check_button_pressed(mb_left)) {
	func()
}
if (room==Levels && follow_player){
	x+=oCamera.xspd
	y+=oCamera.yspd
}

try {
	if (waiter.done){
		task()
}} catch(_expect){}