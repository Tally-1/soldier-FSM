params ["_man", "_forceLeave"];
private _turret = vehicle _man;
private _stayIn = [_man, _turret, _forceLeave] call SFSM_fnc_canStayInTurret;
if(_stayIn)exitWith{};

[[name _man, " left his turret"]] call dbgmsg;
_man action ["getOut", _turret];
_man doFollow (leader (group _man));

true;