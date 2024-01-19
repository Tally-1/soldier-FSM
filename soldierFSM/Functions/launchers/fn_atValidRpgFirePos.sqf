params[
    ["_man",      nil, [objNull]],
    ["_building", nil, [objNull]]
];
private _buildingPos = [_building] call SFSM_fnc_buildingCenterPosASL;
private _aimPos      = aimpos _man;

if(stance _man isEqualTo "PRONE")
then{_aimPos = ATLToASL ([_aimPos#0, _aimPos#1, 1])};

private _canShoot = [_aimPos, _buildingPos, _man, _building] call SFSM_fnc_isValidRpgFirePos;

_canShoot;