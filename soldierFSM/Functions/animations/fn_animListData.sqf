params[
	["_multiSpawn", true], 
	["_copy", true],
	["_zCamFollow", false],
	["_animList",
[
	["AmovPercMevaSlowWrflDf",  "sprint-front"],
	["AmovPercMevaSlowWrflDfr", "sprint-front-right"],
	["AmovPercMevaSlowWrflDfl", "sprint-front-left"],

	["AmovPercMrunSrasWrflDf",  "jog-front"],
	["AmovPercMrunSrasWrflDfr", "jog-front-right"],
	["AmovPercMevaSrasWrflDr",  "jog-right"],
	["AmovPercMrunSrasWrflDfl", "jog-front-left"],
	["AmovPercMevaSrasWrflDl",  "jog-left"],

	["AmovPercMtacSrasWrflDb",  "walk-back"],
	["AmovPercMtacSrasWrflDf",  "walk-front"],
	["AmovPercMwlkSrasWrflDf",  "walk-front-slow"],

	["AmovPercMtacSrasWrflDfr", "walk-front-right"],
	["AmovPercMtacSrasWrflDr",  "walk-right"],
	["AmovPercMtacSrasWrflDfl", "walk-front-left"],
	["AmovPercMtacSrasWrflDl",  "walk-left"]
	
]]];

private _scripts = [];
private _animationMaps = createHashMap;
{
	sleep 0.1;
	if(_multiSpawn)then{
	private _script = [_x#0, _x#1, _animationMaps] spawn SFSM_fnc_checkAnimDirDist;
	_scripts pushBackUnique _script;
	}else{
		[_x#0, _x#1, _animationMaps, _zCamFollow] call SFSM_fnc_checkAnimDirDist;
	};
} forEach _animList;

if(_multiSpawn)then{waitUntil { sleep 1; [_scripts] call SFSM_fnc_threadsFinished;};};

hint str _animationMaps;
copyToClipboard str _animationMaps;