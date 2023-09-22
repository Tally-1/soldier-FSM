params["_fipo"];
([_fipo] call SFSM_fnc_getAzFipoZones)
params["_allZones", "_fireZones", "_flankZones"];

// private _sides = [_fipo] call SFSM_fnc_fipoDefineSides;
private _pos   = getPosATLVisual _fipo;

private _objData = [ 
/*---------------Settings--------------*/
    // ["#type",   "Az-fipo"],
    ["#flags",  [/*"unscheduled",*/"sealed"]],
    ["#noCopy", true],

/*----------------Values---------------*/
    ["module",      _fipo],
    ["all_zones",   _allZones],
    ["fire_zones",  _fireZones],
    ["flank_zones", _flankZones],
    // ["sides",       _sides],
    ["position",    _pos],
    ["owner",       objNull],
    ["active_actions", false],
    ["activeForSides", []],

/*----------------Methods--------------*/
    ["isActive",         {_this call SFSM_fnc_azFipoActive}],
    ["getOut",           {[]    call SFSM_fnc_azFipoGetOut}]
];

private _azFipo = createHashMapObject [_objData];

// _fipo setVariable ["azFipo",     true];
_fipo setVariable ["azFipoData", _azFipo];
_fipo setVariable ["dynamicFipo", false];
// _fipo setVariable ["posname", "Activation Zone FIPO", true];

_azFipo;