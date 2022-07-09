class_name Character

enum Temper{Noisy,Shy, Paranoid, Normal}

enum Caliber{Skinny, Normal, Fat, Muscular}

enum Status{Poor, Average, Rich}

enum Special{Lovers, Copilote, Glinette, Steward, Star, SuperMan, Bishop}

var temper = {
	"Noisy" : { 
		"speed" : 0.5,
		"fear" : 0.5,
		"anger" : 2.0
		"strength" : 2.0,
		"protector" : 2.0
	},
	"Shy" : {
		"speed" : 0.5,
		"fear" : 2.0,
		"anger" : 0.5
		"strength" : 1.0,
		"protector" : 0.5
	},
	"Paranoid" : {
		"speed" : 0.5,
		"fear" : 2.0,
		"anger" : 2.0
		"strength" : 1.0,
		"protector" : 2.0
	},
	"Normal" : {
		"speed" : 1.0,
		"fear" : 1.0,
		"anger" : 1.0,
		"strength" : 1.0,
		"protector" : 1.0
	}
}

var caliber = {
	"Skinny" : {
		"speed" :2.0,
		"fear" : 2.0,
		"anger" : 1.0,
		"protector" : 0.5,
		"strength" : 1.0
	},
	"Normal" : {
		"speed" : 1.0,
		"fear" : 1.0,
		"anger" : 1.0,
		"protector" : 1.0,
		"strength" : 1.0
	},
	"Fat" : {
		"speed" : 0.5,
		"fear" : 0.5,
		"anger" : 2.0,
		"protector" : 2.0,
		"strength" : 1.0
	},
	"Muscular" : {
		"speed" :2.0,
		"fear" : 0.5,
		"anger" : 2.0,
		"protector" : 2.0,
		"strength" :2.0
	}
}

var status = {
	"Poor" : {
		"speed" :2.0,
		"fear" : 2.0,
		"anger" : 0.5,
		"protector" : 2.0,
		"strength" : 1.0
	}, 
	"Average" : {
		"speed" :1.0,
		"fear" : 1.0,
		"anger" : 1.0,
		"protector" : 1.0,
		"strength" : 1.0
	},
	"Rich" : {
		"speed" :0.5,
		"fear" : 1.0,
		"anger" : 2.0,
		"protector" : 0.5,
		"strength" : 2.0
	}
	}

var special = {
	"Lovers" : {},
	"Copilote" : {},
	"Galinette" : {},
	"Steward" : {},
	"Star" : {},
	"SuperMan" : {},
	"Bishop" : {}
	}

var temper_type: int
var caliber_type: int
var status_type: int
var is_special: bool
var special_type : int

func init(_temper_type, _caliber_type, _status_type, _is_special, _special_type):
	temper_type = _temper_type
	caliber_type = _caliber_type
	status_type = _status_type
	is_special = _is_special
	_special_type = _special_type

func get_temper():
	return temper[Temper[temper_type]]
	
func get_caliber():
	return caliber[Caliber[caliber_type]]
	
func get_status():
	return status[Status[status_type]]
	
func get_special():
	if is_special : 
		return special[Special[special_type]]
	else :
		return {}
