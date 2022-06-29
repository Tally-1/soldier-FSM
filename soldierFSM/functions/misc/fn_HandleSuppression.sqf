params ["_man"];
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};//if man is in a vehicle

private _data 		= _man getVariable "SFSM_UnitData";
if(isNil "_data")then{[_man] call SFSM_fnc_InitMan};

private _action 	= [_man, "action"] 				call SFSM_fnc_unitData;
private _lastBullet = [_man, "Last_Close_Bullet"] 	call SFSM_fnc_unitData;

if((time - _lastBullet) > 1)	
then{[_man, "roundsPrSecond", 0] call SFSM_fnc_unitData};

[_man, "current suppression", (getSuppression _man)] call SFSM_fnc_unitData;

if!(_action == "none")exitWith{};

if((getSuppression _man) < SFSM_ProneTreshHold)exitwith{[_man] call SFSM_fnc_normalizeStance};

_man setUnitPos "DOWN";

true;