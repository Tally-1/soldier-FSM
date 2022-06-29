_this addEventHandler ["CuratorObjectPlaced", {
	params ["_curator", "_entity"];

	if(_entity isKindOf "man")
	then{[_entity] call SFSM_fnc_initMan};

}];

_this addEventHandler ["CuratorGroupPlaced", {
	params ["_curator", "_group"];
	[_group] call SFSM_fnc_initGroup;
}];