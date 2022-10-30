params["_man", "_building"];
private _buildingVarName = ["Occupied building ", (name _man), (getPos _building)] joinString "_";
[_man, "targetBuilding", _buildingVarName] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, _building];

//launchPos is defined in the canRpgHouse function.
private _launchPos = [_man, "currentDestination"] call SFSM_fnc_unitData;

if(isNil "_launchPos"
|| _launchPos isEqualTo [0,0,0])
exitWith{"could not find a position to launch from" call dbgmsg;};

[_man, "action", "CQB: Engaging house with launcher"] call SFSM_fnc_unitData;

_man setAnimSpeedCoef SFSM_sprintSpeed;

if((_launchPos distance2D _man) > 3)
then{
	private _move = [
			_man,      //unit 
			_launchPos,//position 
			30,        //timeout (optional)
			2,         //minimum distance to position in order to complete move. (optional)
			3          // sleep between each repetition of doMove. (optional)
			] spawn SFSM_fnc_forceMoveToPos;

	waitUntil{sleep 1.5; scriptDone _move;};
};

_man setAnimSpeedCoef 1;

if(!alive _man)
exitWith{
		"man died before using launcher" call dbgmsg;
		[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
		missionNamespace setVariable [_buildingVarName, nil];
		[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
	};


private _buildingPos = AGLToASL ([(getPos _building)#0, (getPos _building)#1, 2]);
private _hasLOS = ([_man, "VIEW", _building] checkVisibility [(aimPos _man), _buildingPos]) > 0.8;

if!(_hasLOS)exitWith{
	[_man, "action", "failed to get LOS on the building"] call SFSM_fnc_unitData;
	sleep 3;
	_man doMove (getPos _man);
	_man doFollow (leader(group _man));
	[_man, "action", "none"] call SFSM_fnc_unitData;
	[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
	[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
	missionNamespace setVariable [_buildingVarName, nil];
	};

_buildingPos = ASLToAGL _buildingPos;
_man doWatch _buildingPos;
_man setVariable ["SFSM_missileTarget", _buildingPos];
sleep 1;
private _dir = (_man getDir _building);
_man setDir _dir;
ddd doWatch objNull;
private _doFire = [_man, nil, _dir] spawn SFSM_fnc_forceFireLauncher;
waitUntil{scriptDone _doFire;};

_man setVariable ["SFSM_missileTarget", nil];
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;
[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow (leader(group _man));
missionNamespace setVariable [_buildingVarName, nil];