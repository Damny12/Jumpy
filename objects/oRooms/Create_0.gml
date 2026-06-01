///@description Creates Rooms On Start
ground=layer_tilemap_get_id("Ground")
die=layer_tilemap_get_id("Die")
stop=layer_tilemap_get_id("Stop")

//changes seed
randomise()

picks=0

//block section
flat=[[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0]]
stairup=[[0,0],[1,0],[1,-1],[2,-1],[2,-2],[2,0],[3,0],[3,-1],[3,-2],[3,-3]]
stairdown=[[0,0],[0,1],[0,2],[0,3],[1,1],[1,2],[1,3],[2,2],[2,3],[3,3]]
drop=[[1,4]]
stick=[[0,-3],[1,-3],[2,-3],[3,-3],[4,0],[1,0,1],[2,0,1],[3,0,1],[1,1],[2,1],[3,1],[4,0]]

//enemies
dropoff=[[0,0,0],[1,0,0],[2,0,0],[3,0,0],[2,-1,2],[4,0,0],[5,2,0]]
pit=[[0,0,0],[1,0,0],[1,1,0],[1,2,0],[2,2,0],[3,2,0],[4,2,0],[5,2,0],[6,2,0],[6,1,0],[6,0,0],[2,-3,0],[3,-3,0],[4,-3,0],[5,-3,0],[7,0,0],[5,1,2],[8,0,0]]
higher=[[0,0,0],[1,-1,0],[2,-2,0],[3,-2,0],[3,-3,2],[4,-2,0],[5,-2,1],[6,-2,1],[7,-2,0],[5,-1,0],[6,-1,0],[8,-2,0],[9,-1,0]]
plateu=[[0,0,0],[1,0,0],[2,-1,0],[3,-1,0],[4,-1,0],[5,-1,0],[6,-1,0],[7,-1,0],[8,-1,0],[5,-2,2],[9,0,0]]

//flat,stairup,stairdown,drop,stick
blocks=[flat,stairup,stairdown,drop,stick]
enemies=[dropoff,pit,higher,plateu]

//globals
roommin=4
roommax=7

function PositionDifference(tilegroup){
    var _firstX=tilegroup[0][0]
    var _lastX=tilegroup[array_length(tilegroup)-1][0]
    
    var _firstY=tilegroup[0][1]
    var _lastY=tilegroup[array_length(tilegroup)-1][1]
    
    return([
        _firstX-_lastX,
        _firstY-_lastY
    ])
}
show_debug_message(PositionDifference(dropoff))

function TileGround(tiles){
	//tile
	var _startX=x
	var _startY=y
	for (i=0;i<array_length(tiles);i++){
		enemy=0
		tile=tiles[i]
		x=_startX
		y=_startY
		for (position=0;position<array_length(tile);position++){			
			if (position==0){
				x+=tile[position]*32
			}
			
			if (position==1){
				y+=tile[position]*32
			}
			
			if(position==2){
				enemy=tile[position]
			}
		}
		
		//make tile
		if enemy==0 {
			tilemap_set_at_pixel(ground,1,x,y)
		}
		
		if enemy==1 {
			tilemap_set_at_pixel(die,2,x,y)
		}
		
		if enemy>=2 {
			y+=32
			instance_create_layer(x,y,"Enemy",global.enemies[enemy-2])
		}
	}
}

//flat ground
x-=128
TileGround(flat)

var _pick
var _lastPick = 0
var _prohibited=[]

var _amount=irandom_range(roommin,roommax)

//make multiple blocks
repeat (_amount) {
	if (irandom_range(1,2) == 1){		
		_prohibited=[]
		_pick=irandom_range(0,array_length(enemies)-1)
		
		//prevent repeats
		while (_pick==_lastPick) {
			_pick=irandom_range(0,array_length(enemies)-1)
		}
		
		//prevent invalid postions
		while (array_contains(_prohibited,_pick)) {
			_pick=irandom_range(0,array_length(enemies)-1)
		}
		
		//tile
		TileGround(enemies[_pick])
		_lastPick=_pick
	} else{
		picks+=1
		_pick=irandom_range(0,array_length(blocks)-1)
		_prohibited=[]
		
		//prevent repeats
		while (_pick==_lastPick) {
			_pick=irandom_range(0,array_length(blocks)-1)
		}
		
		if (y>=700){
			_prohibited=[2,3]
		}
		if (y<=100){
			_prohibited=[1]
		}
	
		if picks==_amount{
			array_push(_prohibited,1)
			array_push(_prohibited,2)
			array_push(_prohibited,3)
		}
		
		//prevent invalid postions
		while (array_contains(_prohibited,_pick)) {
			_pick=irandom_range(0,array_length(blocks)-1)
		}
		
		//tile
		TileGround(blocks[_pick])
		_lastPick=_pick
	}
}

//finish them
TileGround(flat)
instance_create_layer(x,y-32,"Ladder",oLadder)


//fill the gaps

//go right from left
for (x=0;x<room_width;x+=32){
	
	//go up from bottom
	var _continue=true
	for (y=768;_continue==true;y-=32){		
		if (tilemap_get_at_pixel(ground,x,y)==1){
			_continue=false
		}
		
		if (tilemap_get_at_pixel(die,x,y)==1){
			_continue=false
		}
		
		if (tilemap_get_at_pixel(stop,x,y)==1){
			_continue=false
		}
		
		if (y==0){
			_continue=false
		}
		
		if (tilemap_get_at_pixel(ground,x,y)==0 and _continue==true){
			tilemap_set_at_pixel(ground,1,x,y)
		}
	}
}
