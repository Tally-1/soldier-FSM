params ["_man"];
private _battleKey = [_man, "currentBattle"] call SFSM_fnc_unitData;
// if(_battleKey == "none")exitWith{};
private _battleField    = SFSM_battles get _battleKey;
if(isNil '_battleField')exitWith{};
_battleField