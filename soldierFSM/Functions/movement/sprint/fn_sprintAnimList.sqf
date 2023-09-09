params[
	"_man", 
	"_destination"
];
private _sprint       = SFSM_moveAnims get "sprint-front";
private _anims        = [];
private _distance     = _man distance _destination;
private _animCount    = floor ((_distance / 3.2)*0.9);
private _animDistance = _animCount * (_sprint get "distance");
private _remaining    = _distance - _animDistance;

for "_i" from 1 to _animCount do {_anims pushBack (_sprint get "animName")};


_anims;