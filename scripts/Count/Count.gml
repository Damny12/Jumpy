function Count(array, item){
	var _return = 0
	for (var i=0; i<array_length(array); i++){
		if (item==array[i]){
			_return+=1
		}
	}
	return _return
}