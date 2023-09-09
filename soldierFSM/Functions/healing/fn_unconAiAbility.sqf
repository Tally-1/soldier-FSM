params["_man", "_enable"];

if(canSuspend)
then{sleep 3;};

private _abilities = [
	"AIMINGERROR",
	"ANIM",
	"AUTOCOMBAT",
	"AUTOTARGET",
	"CHECKVISIBLE",
	"COVER",
	"FSM",
	"LIGHTS",
	"MINEDETECTION",
	"MOVE",
	"NVG",
	"PATH",
	"RADIOPROTOCOL",
	"TARGET",
	"WEAPONAIM"
];

if(_enable)exitWith{{_man enableAI _x}forEach _abilities; true;};

{_man disableAI _x}forEach _abilities;

false;