params["_man", "_enable"];
private _abilities = [
	"MOVE",
	"CHECKVISIBLE",
	"PATH",
	"AUTOTARGET",
	"AUTOCOMBAT"
];

if(_enable)exitWith{{_man enableAi _x;} forEach _abilities;};

{_man enableAi _x;} forEach _abilities;

true;