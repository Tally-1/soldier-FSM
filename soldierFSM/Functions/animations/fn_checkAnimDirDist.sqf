params[
	"_anim", 
	"_nick", 
	["_hashMap", createHashMap],
	["_zCamFollow", false]
];


private ["_man"];
private _testPos   = [23500, 18300, 0];
private _dirs      = [];
private _dists     = [];
private _times     = [];
private _speeds    = [];
private _endStance = "";
private _dummyParams = [typeOf player, _testPos, [], 100, "NONE"];

if((!isNil "SFSM_animTestMan")
&&{_zCamFollow})exitWith{"2nd man spawned" call dbgmsg;nil;};

if(_zCamFollow isEqualTo false)
then{_man = createAgent _dummyParams;}
else{
	 private _grp = createGroup [west, true];
	 _man = _grp createUnit _dummyParams;
	 SFSM_animTestMan = _man;
};

_man setVariable ["speeds",   []];
_man setVariable ["animTimes", []];

if(_zCamFollow)then{
	openCuratorInterface;
	sleep 2;
	[_man] spawn dbg_cam;
};

for "_i" from 1 to 5 do {
	([_man, _anim] call SFSM_fnc_getAnimData)params["_dir", "_dist", "_stance"];
	private _speed = selectMax (_man getVariable "speeds");
	private _time  = selectMax (_man getVariable "animTimes");
	_speeds pushBack _speed;
	_dirs   pushBack _dir;
	_dists  pushBack _dist;
	if(_time > 0)then{
		_times  pushBack _time;
	};

	_endStance = _stance;
};

private _speed = [_speeds,  true] call Tcore_fnc_average;
private _dir   = [_dirs,  true]   call Tcore_fnc_average;
private _dist  = [_dists, true]   call Tcore_fnc_average;
private _time  = [_times, true]   call Tcore_fnc_average;

private _data  = createHashMap;
_data set ["animName",      _anim];
_data set ["direction", round _dir];
_data set ["distance",  parseNumber (_dist  toFixed 2)];
_data set ["time",      parseNumber (_time  toFixed 2)];
_data set ["speed",     parseNumber (_speed toFixed 2)];
_data set ["stance",    _endStance];

_hashMap set [_nick, _data];

deleteVehicle _man;
SFSM_animTestMan = nil;

_data;