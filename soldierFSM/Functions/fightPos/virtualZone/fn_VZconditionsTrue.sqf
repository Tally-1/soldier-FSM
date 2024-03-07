if(_self call ["canBattleInit"])  exitWith{true;};
if(_self get "activatedByBattle") exitWith{false;};

private _wantedSideCount = _self get "activationtype";
private _sidesPresent    = [
    (_self get "module"),
    true,
    (_self get "allowedSides")

] call SFSM_fnc_unitsInModuleArea;

private _sideCount = count _sidesPresent;

if(_sideCount < _wantedSideCount)exitWith{false;};

true;