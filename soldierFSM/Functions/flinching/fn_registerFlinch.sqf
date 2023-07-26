params ["_man"];
private _flinchTimes = [_man, "flinchTimes"] call SFSM_fnc_unitData;
_flinchTimes pushBackUnique [time, (getPosASL _man)];
_flinchTimes = _flinchTimes select{
    private _timePassed = time - (_x#0);
    _timePassed < 120;
};

if(count _flinchTimes > 10)then{_flinchTimes deleteAt 0;};
[_man, "flinchTimes", _flinchTimes] call SFSM_fnc_unitData;

_flinchTimes;