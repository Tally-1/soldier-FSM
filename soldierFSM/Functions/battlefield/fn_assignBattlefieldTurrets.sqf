params["_battlefield"];
private _center = _battlefield get "center";
private _radius = _battlefield get "radius";

while {sleep 10; !isNil "_battlefield"} do {

	if(isNil "_battlefield")exitWith{};

	private _groups = missionNamespace getVariable   (_battlefield get "groups");
	private _vehicles = _center nearEntities ["staticWeapon", _radius];

	if((!isNil "_vehicles") && {!isNil "_groups"})then{
		[_vehicles, _groups] spawn SFSM_fnc_manAllTurrets;
	};

	[_battlefield] call SFSM_fnc_leaveBattlefieldTurrets;

	if(isNil "_battlefield")exitWith{};
};

["Ended battlefield turret assignement", 2]call dbgmsg;
true;