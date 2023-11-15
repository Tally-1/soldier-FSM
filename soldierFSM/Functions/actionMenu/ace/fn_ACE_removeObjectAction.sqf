params [
	"_object", 
	"_parentPath", 
	"_actionName"
];
if(isNil "_actionName")
exitWith{"Could not remove ACE action, _actionName is nil" call dbgmsg;};

private _actionList = _object getVariable ["ace_interact_menu_actions", []];

{
    if (((_x select 0) select 0) isEqualTo _actionName &&
        {(_x select 1) isEqualTo _parentPath}) exitWith {
        _actionList deleteAt _forEachIndex;
    };
} forEach _actionList;

_actionList;