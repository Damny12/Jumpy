var _blue=make_colour_rgb(20,125,255)
var _cyan=make_colour_rgb(0,155,255)
//rectangle (frame)
draw_line_width_colour(10,60,10,300,10,_cyan,_cyan)
draw_line_width_colour(110,60,110,300,10,_cyan,_cyan)
draw_line_width_colour(5,60,115,60,10,_cyan,_cyan)
draw_line_width_colour(5,300,115,300,10,_cyan,_cyan)
//60 gap

draw_rectangle_colour(15,65,105,(300/maxOxygen)*oxygen,_blue,_blue,_blue,_blue,false)

display_set_gui_size(view_wport[0], view_hport[0])