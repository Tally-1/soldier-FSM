params["_man", "_fipo"];
_man attachTo [_fipo, [0,0,0]];
_man disableAI "PATH";
_man setDir 0;
doStop _man;

[_man, "Idle"] call SFSM_fnc_setAction;
[_man, "inFipo", true] call SFSM_fnc_unitData;
[_man] call SFSM_fnc_fipoFiredEH;

_man setUnitPos "MIDDLE";
_fipo synchronizeObjectsAdd [_man];
[_fipo] call SFSM_fnc_updateFipoMarker;

_man spawn {
    sleep 1; 
    detach _this;
};

private _captives = (_fipo nearEntities 2)select{_x getVariable ["SFSM_surrendered", false]};
{
    [_x, _man] call SFSM_fnc_capture;
    
} forEach _captives;



["fipo_getIn", [_man, _fipo]] call CBA_fnc_localEvent;
true;