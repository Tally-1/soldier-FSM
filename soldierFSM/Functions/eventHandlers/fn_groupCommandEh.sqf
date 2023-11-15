params["_group"];
_group addEventHandler [
	"CommandChanged", 
	{_this call SFSM_fnc_onCommandChange;}
];