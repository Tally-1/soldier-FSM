params["_shooter"];
if(time - SFSM_lastSoundCheck < 120)exitWith{true;};

private _weapon = ([(currentWeapon _shooter)] call BIS_fnc_itemType)#1;
private _distance = 300;

switch (_weapon) do {
						case "AssaultRifle": { _distance = 400;};
						case "MachineGun":   { _distance = 600;};
						case "SniperRifle":  { _distance = 800;};
					};

private _nearMen = _shooter nearEntities ["Man", _distance];

{
	private _action = [_X, "action"]        call SFSM_fnc_unitData;
	private _battle = [_X, "currentBattle"] call SFSM_fnc_unitData;

	if(_action == "none"
	&&{_battle == "none"})
	then{
			private _coverPos = [_x] call Tcore_fnc_coverPosSimple;
			if(isNil "_coverPos")exitWith{};
			[_x, _coverPos] call SFSM_fnc_takeCover;
		};

} forEach _nearMen;


SFSM_lastSoundCheck = time;

true; 