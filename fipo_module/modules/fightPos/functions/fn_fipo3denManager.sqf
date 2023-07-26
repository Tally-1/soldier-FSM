//All code implementing actual functionality is placed in the main SFSM addon.
//See the "\soldierFSM\functions\fightPos\" folder for more.
//Anything found here is mostly related to the 3DEN editor

private _mode            = param [0,"",[""]];
private _input           = param [1,[],[[]]];
private _logic           = _input param [0,objNull,[objNull]]; // Module logic
private _isActivated     = _input param [1,true,[true]];       // True when the module was activated, false when it is deactivated
private _isCuratorPlaced = _input param [2,false,[true]];      // True if the module was placed by Zeus

if!(is3DEN)exitWith{};

private _group = FIPO_indicatorGroup;
if(isNil "_group")then{
	FIPO_indicatorGroup = createGroup civilian;
};


// Default object init (does not work in eden)
if(_mode == "init") exitwith{};

// When added to the world (seems to not work)
if(_mode == "registeredToWorld3DEN")exitwith{};

// When removed from the world (by deletion or undoing creation)
if(_mode == "unregisteredFromWorld3DEN")exitwith{
	[_logic] call FIPO_fnc_deleteIndicators;	
};

// When connection to object changes (new a connection is added or existing one removed)
if(_mode == "connectionChanged3DEN")exitwith{};


// When some attributes were changed (including position and rotation)
if(_mode == "attributesChanged3DEN")
exitwith{
	[_logic] call FIPO_fnc_fipoChanged;
};


// When object is being dragged
if(_mode == "dragged3DEN")exitwith{};

true;