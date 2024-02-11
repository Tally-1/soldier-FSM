params["_man", "_fipo"];
_man attachTo [_fipo, [0,0,0]];
_man disableAI "PATH";
_man setDir 0;
// doStop _man;
_man doFollow _man;


private _azFipoData = _fipo getVariable "azFipoData";
if(!isNil "_azFipoData")then{_azFipoData set ["owner", _man];};

[_man, "Idle"] call SFSM_fnc_setAction;
[_man, "inFipo", true] call SFSM_fnc_unitData;

_man setUnitPos "MIDDLE";
_fipo synchronizeObjectsAdd [_man];
[_fipo] call SFSM_fnc_updateFipoMarker;

([_man] call SFSM_fnc_fipoStanceIndexes)#0
params["_index", "_animVar"];

if(isNil "_index")then{_index = 1;};

[_man,  [_index, _animVar]] call SFSM_fnc_animSetStance;

_man spawn {
    sleep 1; 
    detach _this;
};


if(_fipo getVariable "hitandrun")then{
    [_man, _fipo] call SFSM_fnc_initHitAndRunFipo;
};


["fipo_getIn", [_man, _fipo]] call CBA_fnc_localEvent;

true;