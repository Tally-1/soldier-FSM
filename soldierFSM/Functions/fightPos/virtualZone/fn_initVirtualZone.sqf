params[
    ["_module", objNull, [objNull]]
];
private _area            = [_module] call SFSM_fnc_getAzArea;
private _corners         = _area call SFSM_fnc_getAreaCorners;
private _fipos           = (entities "SFSM_FIPO" select {_x inArea _area &&{!(_x in synchronizedObjects _module)}});
private _activationtype  = _module getVariable "activationtype";
private _battleActivated = _activationtype isEqualTo 4;
private _allowedSides    = [];
private _radius          = (selectMax [(_area#1), (_area#2)])*2;

if(_module getVariable "activatedByEast")        then{_allowedSides pushBack east;};
if(_module getVariable "activatedByWest")        then{_allowedSides pushBack west;};
if(_module getVariable "activatedByIndependent") then{_allowedSides pushBack independent;};

private _dataArr = [
	["module",                           _module],
    ["position",         getPosATLVisual _module],
    ["area",                               _area],
    ["radius",                           _radius],
    ["corners",                         _corners],
	["activatedByBattle",       _battleActivated],
    ["activationtype",           _activationtype],
	["active",                              true],
	["physicalFipos",                     _fipos],
	["virtualFipos",                          []],
	["allowedSides",               _allowedSides],
    ["canActivate",       SFSM_fnc_canActivateVz],
    ["activate",       SFSM_fnc_unVirtualizeZone],
    ["canDeActivate",   SFSM_fnc_canDeActivateVz],
    ["deActivate",       SFSM_fnc_virtualizeZone],
    ["toggleZone",             SFSM_fnc_toggleVz],
    ["conditionsTrue", SFSM_fnc_VZconditionsTrue],
    ["canBattleInit",   SFSM_fnc_canBattleInitVz]
];

private _data = createHashmapObject [_dataArr];

private _lines3D = [_poiModule] call FRLI_fnc_poi3DLines;
_data set ["lines", _lines3D];

_module setVariable ["SFSM_vzData", _data];

true;