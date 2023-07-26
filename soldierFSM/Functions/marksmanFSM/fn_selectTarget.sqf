params ["_marksman", "_targets"];
private _target = objNull;
  
_targets = _targets select {[_marksman, _x] call SFSM_fnc_viableTarget};
if(_targets isNotEqualTo [])then
{_target = [_marksman, _targets] call SFSM_fnc_getNearest;};

_target;