params ["_man"];

if!(SFSM_emergencyRearm)exitWith{false;};

if!([_man] call SFSM_fnc_isRealMan)exitWith{false;};
if!(_man checkAIFeature "PATH")exitWith{false;};

if(_man getVariable ["SFSM_Sprinting", false])   exitwith{false;};
if(_man getVariable ["ace_isunconscious", false])exitWith{false;};


private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")exitWith{false;};
if(_action isNotEqualTo "none")exitWith{false;};

private _battle = [_man, "currentBattle"] call SFSM_fnc_unitData;
if(_battle isEqualTo "none")exitWith{false;};

private _lastAmmoCheck = [_man, "last_AmmoCheck"] call SFSM_fnc_unitData;
if(time - _lastAmmoCheck < 10)exitWith{false;};

true;