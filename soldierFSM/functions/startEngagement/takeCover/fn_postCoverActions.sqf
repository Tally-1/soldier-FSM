params ["_man"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
if(isNil "_battleKey")exitWith{"PostCover battleKey undefined" call dbgmsg};

private _battleField = SFSM_battles get _battleKey;
if(isNil "_battleField")exitWith{};

private _reacting = [_man, _battleField] call SFSM_fnc_reactToVehicles;

if!(_reacting)
then{[_man] spawn SFSM_fnc_randomHunkerInit};


true;