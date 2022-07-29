params ["_man"];

if!(SFSM_emergencyRearm)exitWith{false};

private _battleKey   = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battleField =  SFSM_Battles get _battleKey;

if(isNil "_battleField")exitWith{false};

private _launcher = secondaryWeapon _man;
if!(_launcher == "")exitWith{};

private _weapon     = [_man, _battleField] call SFSM_fnc_getBattlefieldWeapon;

if(isNil "_weapon")exitWith{false};

[_man, _weapon] spawn SFSM_fnc_pickUpWeapon;

true;