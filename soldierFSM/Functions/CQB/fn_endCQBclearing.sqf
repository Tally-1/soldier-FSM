params["_man", "_startSpeedMode", "_building"];
private _buildingVarName = [_man, "targetBuilding"] call SFSM_fnc_unitData;
missionNamespace setVariable [_buildingVarName, nil];
[_man, "targetBuilding", "none"] call SFSM_fnc_unitData;
[_man, "action", "none"] call SFSM_fnc_unitData;

_man doMove (getPos _man);
[_man] doFollow leader (group _man);
_man setUnitPos "AUTO";
_man setAnimSpeedCoef 1;
_man setSpeedMode _startSpeedMode;
true;