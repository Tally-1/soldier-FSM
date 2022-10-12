params ["_man"];
if!([_man] call SFSM_fnc_isRealMan)exitWith{};


if!(typeOf (vehicle _man) == typeOf _man)exitwith{};

//if man is in a vehicle
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};

//if the man has not been initialized.
private _data 		= _man getVariable "SFSM_UnitData";
if(isNil "_data")exitWith{[_man] call SFSM_fnc_InitMan};

//no players should be affected by this function
if([_man] call Tcore_fnc_isPlayer)exitWith{};



private _action 	= [_man, "action"] 				call SFSM_fnc_unitData;
private _lastBullet = [_man, "Last_Close_Bullet"] 	call SFSM_fnc_unitData;


if((time - _lastBullet) > 1)	
then{[_man, "roundsPrSecond", 0] call SFSM_fnc_unitData};

[_man, "current suppression", (getSuppression _man)] call SFSM_fnc_unitData;



if((getSuppression _man) < SFSM_ProneTreshHold)
exitwith{
	
//3x spam, because ArmA, some functions do not execute for unknown reasons.
	_man setUnitPos "AUTO";
	_man setUnitPos "AUTO";
	_man setUnitPos "AUTO";
	[_man] call SFSM_fnc_normalizeStance;
	};
if!(_action == "none")exitWith{};

if((getSuppression _man) > SFSM_ProneTreshHold)
then{_man setUnitPos "DOWN"};

true;