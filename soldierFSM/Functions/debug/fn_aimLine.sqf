params["_man"];
private _eyePos     = ASLToAGL eyePos _man;
private _endEyeLine = _eyePos vectorAdd (eyeDirection _man vectorMultiply 100);
private _weaponPos  = [_man, "righthand"] call SFSM_fnc_selectionPos;
private _endWeapon  = _weaponPos vectorAdd (_man weaponDirection currentWeapon _man vectorMultiply 100);

private _wpsL = [_weaponPos, [-0.1,0,0]] call SFSM_fnc_addToPosValues;
private _wpsR = [_weaponPos, [0.1,0,0]]  call SFSM_fnc_addToPosValues;
private _wpsU = [_weaponPos, [0,0,0.1]]  call SFSM_fnc_addToPosValues;
private _wpsD = [_weaponPos, [0,0,-0.1]] call SFSM_fnc_addToPosValues;

private _line      = [_weaponPos, _endWeapon, [0.4, 1, 0.9, 1]];
private _lineLeft  = [_wpsL, _endWeapon, [1,0,0,1]];
private _lineRight = [_wpsR, _endWeapon, [0,1,0,1]];
private _lineUp    = [_wpsU, _endWeapon, [0,0,1,1]];

drawLine3D _line;
drawLine3D _lineLeft;
drawLine3D _lineRight;
drawLine3D _lineUp;
drawLine3D _lineDown;