params["_man", "_endPos", "_hitByBullet"];


private _action = [_man, "action"]	call SFSM_fnc_unitData;
private _evadePos = _endPos;

if(_action in ["none", "dodging", "dodging to cover"])exitWith{};

//reEnable ai, and update state
_man enableAI "PATH";
[_man, "pathEnabeled", true]call SFSM_fnc_unitData;
[_man, "action", "none"]	call SFSM_fnc_unitData;
_man setCombatBehaviour "AWARE";


if(_hitByBullet)
exitWith{
			private _enemyPos = getPos (_man getVariable "SFSM_enemy");
			if(!isNil "_enemyPos")then{_evadePos = _enemyPos};
			
			_unit setVariable ["SFSM_enemy", nil];
			[_man, _evadePos, false] call SFSM_fnc_Dodge;
	true;
};