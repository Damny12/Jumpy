// moving
moveDir=0
moveSpd=2
defaultMoveSpd=2
xspd=0
yspd=0

//ticking
ticks=0

//jumping
defaultgrav=0.275
defaultjump=-5

grav=defaultgrav
defaultTermVel=6
termvel=defaultTermVel
jmpspd=defaultjump

//oxygen
oxygen=10
naturalDrain=0.003
movementDrain=0.001
enemyDrain=0.1
maxOxygen=10
drainMult=1

drainIncrease=Count(global.modifiers,GrowingPressure)*0.04

//enemy stuff
iframes=0

//attacking
attackCooldown=30
attackDmg=1
attackDebounce=0
attackLength=20

//coins
drawCoin=false
coinFrame=0
makingCoins=false
coinCount=0
coins=0
secondDelay=1

//skills
skillSet=global.skills
attackDmg=1+Count(skillSet,"Strength")

//poison
poisonTicks=[]
poisonDmg=1

//glide
glideToggle=false
glideGrav=defaultgrav/10
glideTerminal=defaultTermVel/2
glideSpeed=defaultMoveSpd
glideSoftCapSpeed=0.02+defaultgrav

//poison timing
for(var i=0;i<Count(skillSet,"Poison");i++){
	array_push(poisonTicks,60*(i/Count(skillSet,"Poison")))
}

if (Count(skillSet,"Poison")==0){
	poisonDmg=0
}else{
	poisonDmg=1
}


//currency
global.finalOxygen=floor(oxygen)

//modifier creation
for (var i =0;i<array_length(global.modifiers);i++){
	instance_create_depth(372+i*32,y+128,3,CardModifier,{
		sprite_index:array_get(global.modifiers,i)
	})
}