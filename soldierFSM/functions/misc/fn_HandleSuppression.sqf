params ["_man"];
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};//if man is in a vehicle
private _data 		= _man getVariable "SFSM_UnitData";
if(isNil "_data")then{[_man] call SFSM_fnc_InitMan};


private _lastBullet = [_man, "Last_Close_Bullet"] 	call SFSM_fnc_unitData;
private _flinching  = [_man, "flinching"] 			call SFSM_fnc_unitData;
private _dodging 	= [_man, "dodging"] 			call SFSM_fnc_unitData;

[_man] call SFSM_fnc_StoreSuppression;

if((time - _lastBullet) > 1)	
then{[_man, "roundsPrSecond", 0] call SFSM_fnc_unitData};

if(_flinching or _dodging)exitWith{};

if((getSuppression _man) < SFSM_ProneTreshHold)exitwith{_man setUnitPos "AUTO"};

_man setUnitPos "DOWN";

true;