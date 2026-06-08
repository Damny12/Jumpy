cards=[{
	title:"Poison",
	asset:poison,
	cost:4
},{
	title:"Glide",
	asset:glide,
	cost:7
},{
	title:"Strength",
	asset:strength,
	cost:5
}]

//first card
card=cards[irandom_range(0,(array_length(cards)-1))]
newCard(273.2,300,card.asset,card.cost,card.title)

//second card
card=cards[irandom_range(0,(array_length(cards)-1))]
newCard(683,300,card.asset,card.cost,card.title)

//third card
card=cards[irandom_range(0,(array_length(cards)-1))]
newCard(1092,300,card.asset,card.cost,card.title)

//leave
leaveButton=newButton(1192,50,3,3,"",function(){
	global.enemyHp+=1
	room_goto(Levels)
})

leaveButton.sprite_index=orange_button_restart

if global.finalCoins>99 global.finalCoins=99