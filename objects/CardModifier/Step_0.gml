hovering = position_meeting(device_mouse_x(0), device_mouse_y(0), self)

x+=oCamera.xspd
y+=oCamera.yspd

global.modifierDescription={
	"GrowingPressure":"Your oxygen drain will drain faster every second.",
	"CrabClaw":"Crabs take more oxygen from you when attacking."
}

global.modifierStatsDescription={
	"GrowingPressure":$"{global.drainMult}x",
	"CrabClaw":$"{Count(global.modifiers,CrabClaw)}x"
}