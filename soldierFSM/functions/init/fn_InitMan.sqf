params["_man"];
private _data = _man getVariable "SFSM_UnitData";
if(!isNil "_data")exitWith{};
// if!([_man] call SFSM_fnc_isRealMan)exitWith{};

// if(isPlayer _man)exitwith{};
if([(group _man)] call Tcore_fnc_nilNull)exitWith{};

private _unitData = createHashMap;

// Setting all time variables to -300 to allow for 
// proper reactions from the start of the game  

_unitData set 	["Last_Hit", 	        -300];
_unitData set 	["Last_Close_Bullet", 	-300]; 
_unitData set 	["last_bullet_fired", 	-300];
_unitData set 	["flinchTimer", 		-300];
_unitData set 	["dodgeTimer", 			-300];
_unitData set 	["reactFireTimer",		-300];
_unitData set 	["lastBattle",		    -300];
_unitData set   ["last_time_in_cover",  -300];
_unitData set   ["last_AmmoCheck",      -300];
_unitData set 	["roundsPrSecond", 		0];
_unitData set 	["action", 				"none"];
_unitData set 	["currentBattle",		"none"];
_unitData set 	["currentBuilding",     "none"];
_unitData set 	["targetBuilding",      "none"];
_unitData set 	["currentDestination",	[0,0,0]];
_unitData set 	["hashValue", 			hashvalue _man];
_unitData set 	["current suppression", (getSuppression _man)];
_unitData set   ['pathEnabeled',        (_man checkAIFeature "PATH")];
_unitData set 	["hunkObjectHash", 	    []];
_man setVariable["SFSM_UnitData", 		_unitData, true];

if(_man getVariable ["SFSM_Excluded",false])exitWith{};

[_man] call SFSM_fnc_SuppressedEH;
[_man] call SFSM_fnc_firedEH;
[_man] call SFSM_fnc_hitEH;

_man addEventHandler ["Deleted", {
		private _building = _unitData get "currentBuilding";
		if!(_building == "none")
		then{missionNamespace setVariable [_building, nil, true];};
		diag_log "Soldier FSM ==> unit deleted";
	}];



true;