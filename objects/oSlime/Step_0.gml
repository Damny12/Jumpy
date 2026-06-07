//inputs
var right_key = keyboard_check(vk_right)||keyboard_check(ord(global.rightKey))
var left_key = keyboard_check(vk_left)||keyboard_check(ord(global.leftKey))
var up_key = keyboard_check_pressed(vk_space)||keyboard_check(ord(global.spaceKey))
var attack_key = keyboard_check(ord("E"))||keyboard_check(ord(global.attackKey))

if (keyboard_check(vk_escape)&&keyboard_check(vk_shift)) {
    game_end(0)
}

if (keyboard_check(vk_f1)&&keyboard_check(vk_shift)) {
	global.finalOxygen=floor(oxygen-2.2)
	coinCount=global.finalOxygen
	coins=coinCount
	makingCoins=true
}

var _ground=layer_tilemap_get_id("Ground")
var _bouncers=[oCorpse]
var _killers=layer_tilemap_get_id("Die")
var _enemies=global.enemies

//update
global.drainMult=drainMult
ticks++

//x movement

//direction
moveDir=right_key-left_key

//xspd
xspd=moveDir*moveSpd

//collison
var _subpixel = 0.5

if (place_meeting(x+xspd,y,_ground)){
	var _pixelCheck= _subpixel*sign(xspd)
	
	while(!place_meeting(x+xspd,y,_ground)){
		x+=_pixelCheck
	}
	
	xspd=0
}

//damaging
for (var i=0;i<array_length(_enemies);i++){
	if (place_meeting(x,y,_enemies[i]) and iframes<=0){
		oxygen-=enemyDrain*drainMult*_enemies[i].damageMult
		iframes=25
		if (yspd<=0){
			yspd=-5
		} else{
			yspd*=-2
			if (abs(yspd)>6 and sign(yspd)!=0){ 
				yspd=6*sign(yspd)
			}
		}
		glideToggle=false
	}
}

//Movement

//Y movement

//move
y+=yspd
x+=xspd

//gravity
yspd+=grav
if (yspd>termvel){
	yspd=termvel
}

//bouncin' on the trampoline
if (place_meeting(x,y,_bouncers)){
	if (yspd<=0){
			yspd=-5
		} else{
			yspd*=-2
			if (abs(yspd)>6 and sign(yspd)!=0){ 
				yspd=6*sign(yspd)
			}
	}
	glideToggle=false
}

//jump that
if (up_key and place_meeting(x,y+(1*sign(grav)),_ground)){
	yspd=jmpspd
	oxygen+=jmpspd*naturalDrain*3*drainMult
}

//y collide
_subpixel = 0.5 //might need changing later

if (place_meeting(x,y+yspd,_ground)){
	var _pixelCheck= _subpixel*sign(yspd)
	
	while(!place_meeting(x,y + yspd,_ground)){
		y+=_pixelCheck*sign(grav)
	}
	
	yspd=0
	glideToggle=false
}

//Hanging
if (place_meeting(x,y-2,layer_tilemap_get_id("Ground"))){
			grav=-defaultgrav
			jmpspd=1
			oxygen-=movementDrain*drainMult
	}else{
			grav=defaultgrav
			jmpspd=defaultjump
}

//glide
if (Count(skillSet,"Glide") >= 1 && yspd >= termvel-2.5){
	glideToggle=true
}

if (glideToggle){
	grav=glideGrav
	moveSpd=glideSpeed
	if (yspd>glideTerminal){
		yspd-=glideSoftCapSpeed
	}
}else{
	moveSpd=defaultMoveSpd
	termvel=defaultTermVel
}

//sprite changing
function change(){
	if (glideToggle){
		sprite_index=sSlimeGlide
		return
	}
	
	if (sign(round(yspd))<0){
		sprite_index=sJumpSlime
		return  
	}
	
	if (sign(round(yspd))>0){
		sprite_index=sFallSlime
		return
	}
	
	if (sign(xspd)==1){
		sprite_index=sMovRight
		return
	}
	
	if (sign(xspd)==-1){
		sprite_index=sMoveLeft
		return
	}
	
	if (sign(xspd)==0){
		sprite_index=sSleepSlime
		return
	}
}

//die
if (place_meeting(x,y,_killers)) oxygen-=naturalDrain*10*drainMult

//oxygen
oxygen-=naturalDrain*drainMult
oxygen-=movementDrain*xspd*moveDir*drainMult

if (oxygen<2.2*(maxOxygen/10)){
	room_restart()
}

//attacking
if (attack_key && attackDebounce<=0){
	attackObject=instance_create_layer(x,y,"PlayerStuff",oAttack,{
        image_xscale:sign(xspd)
    })
	attackDebounce=attackCooldown+attackLength
}

if (place_meeting(x,y,oLadder) and makingCoins==false){
	global.finalOxygen=floor(oxygen-2.2)
	coinCount=(global.finalOxygen*global.coinOxygenConversion)+global.finalEnemyKillCoins
	coins=coinCount
	makingCoins=true
}

iframes-=1
attackDebounce-=1

//increase drain
if (ticks mod 60==0){
    drainMult+=drainIncrease
    global.coinOxygenConversion+=drainIncrease
}

//coin
if (makingCoins){
	drainMult=0
	if (coinFrame==0){
		randX=irandom_range(0,180)
		randY=irandom_range(0,180)
		drawCoin=true
	}
	
	coinFrame+=1
	
	if (coinFrame==round(secondDelay*30/coinCount)){
		coins-=1
		global.finalCoins+=1
	}
	
	if (coinFrame==round(secondDelay*60/coinCount)){
		drawCoin=false
		coinFrame=0
	}
	
	if (coins<=0){
		makingCoins=false
		room_goto(Shop)
	}
}

change()