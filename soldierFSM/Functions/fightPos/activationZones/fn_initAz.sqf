params["_activationZone"];

private _activationSides = [_activationZone] call SFSM_fnc_getAzSides;
private _fipos           = [_activationZone] call SFSM_fnc_getAzFipos;
private _knowledgeBase   = _activationZone getVariable "activationknowledge";
private _knowledge       = 4 * _knowledgeBase;
private _pos             = getPosATLVisual _activationZone;
private _area            = [_activationZone] call SFSM_fnc_getAzArea;
private _corners         = _area call SFSM_fnc_getAreaCorners;
private _radius          = (selectMax [(_area#1), (_area#2)])*2;
private _modeInt         = _activationZone getVariable "type";
private _mode            = "activate";


if(_modeInt isEqualTo 1)then{_mode = "deactivate";};


private _objData = [ 
/*---------------Settings--------------*/
    ["#type",       "fipo-activation-zone"],
    ["#flags", [/*"unscheduled",*/"sealed"]],
    ["#noCopy",     true],

/*----------------Values---------------*/
    ["module",             _activationZone],
    ["sides",              _activationSides],
    ["knowledge",          _knowledge],
    ["knowledge_base",     _knowledge],
    ["fipos",              _fipos],
    ["position",           _pos],
    ["area",               _area],
    ["corners",            _corners],
    ["radius",             _radius],
    ["units",              []],
	["sides_present",      []],
    ["active",             false],
    ["mode",               _mode],
    ["mode_code",          _modeInt],
    ["last_fipo_handling", time],
    ["last_activated",     time],

/*----------------Methods--------------*/
    ["getUnits",        {[]    call SFSM_fnc_getUnitsInAz}],
    ["update",          {[]    call SFSM_fnc_updateAz}],
    // ["onSidesChanged",  {[]    call SFSM_fnc_onAzSidesChanged}],
    ["hostilePresent",  {_this call SFSM_fnc_hostilePresentInAz}]
];

private _az = createHashMapObject [_objData];

_activationZone setVariable ["SFSM_AzData", _az];

_az;