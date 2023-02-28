params["_battlefield"];
if(isNil "_battlefield")exitWith{};

private _units = (missionNamespace getVariable (_battlefield get "units"));
if(isNil "_units")exitWith{};

private _woundedNoSelfHeal = [];
private _incapacitated     = [];
private _healers           = [];
private _specialists       = ["AT-specialist", "machineGunner", "squad-leader"];

{
	private _realMan = [_x] call SFSM_fnc_isRealMan;
	private _action  = [_x, "action"] call SFSM_fnc_unitData;

	if(_realMan
	&&{!isNil "_action"})then{

		private _soldierClass = [_x] call SFSM_fnc_squadAsset;
		
		private _noSpecial    = !(_soldierClass in _specialists);
		private _unconscious  = _x getVariable ["ace_isunconscious", false];
		private _wounded      = damage _x > 0.3;
		private _bleeding     = (_x getVariable ["ace_medical_woundbleeding", 0]) > 0.1;
		private _canHeal      = _action isEqualTo "none" && {[_x] call SFSM_fnc_canSelfHeal};

		if(_unconscious)then{
			_incapacitated pushBack _x

		}else{
		if((_wounded || _bleeding) &&{! _canHeal})then{
			_woundedNoSelfHeal pushBack _x;

		}else{
		if(_noSpecial && {_canHeal})then{
			_healers pushBack _x;
			
		}}}
	};
	
} forEach _units;

[_healers, _woundedNoSelfHeal, _incapacitated];