/*
Old Tally function:

params["_man"];
private _multiplier = 0.5 / skill _man;
private _coolDown   = 7.5*_multiplier;

if(_coolDown > 15)then{_coolDown = 15};
if(_coolDown <  5)then{_coolDown =  5};

_coolDown;
*/

//New Yip function:
params["_man"];

// Yip: Added randomness to cooldown based on courage.
private _skillCourage = _man skill "courage";
private _morale       = [_man, "morale"] call SFSM_fnc_unitData;
if(isNil "_morale")exitWith{0.01;};

if(_morale isEqualTo 0)       then{_morale       = 0.00001;};
if(_skillCourage isEqualTo 0) then{_skillCourage = 0.00001;};//to avoid zero divisor error.

private _moraleCoef  = 1 / _morale;
private _multiplier  = 0.5 / _skillCourage; 
private _coolDown    = (4 + (Random 11)) * _multiplier;

if((behaviour _man) isEqualTo "STEALTH")then{
	_coolDown = _coolDown*2;
};

if((behaviour _man) isEqualTo "COMBAT")then{
	_coolDown = _coolDown*0.5;
};

_coolDown = _coolDown*_moraleCoef;

if(_coolDown > 20)then{_coolDown = 20};
if(_coolDown <  4)then{_coolDown =  4};

// _coolDown = _morale*0.5;

_coolDown;