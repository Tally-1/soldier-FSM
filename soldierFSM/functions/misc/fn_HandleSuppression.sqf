params ["_man"];
private _data 		= _man getVariable "SFSM_UnitData";
if(isNil "_data")then{[_man] call Tally_Fnc_SFSM_InitMan};


private _lastBullet = [_man, "Last_Close_Bullet"] 	call Tally_Fnc_SFSM_unitData;
private _flinching  = [_man, "flinching"] 			call Tally_Fnc_SFSM_unitData;
private _dodging 	= [_man, "dodging"] 			call Tally_Fnc_SFSM_unitData;

[_man] call Tally_fnc_StoreSuppression;

if((time - _lastBullet) > 1)	
then{[_man, "roundsPrSecond", 0] call Tally_Fnc_SFSM_unitData};

if(_flinching or _dodging)exitWith{};

if((getSuppression _man) < SFSM_ProneTreshHold)exitwith{_man setUnitPos "AUTO"};

_man setUnitPos "DOWN";

true;