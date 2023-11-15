params["_captive", "_captor", "_forceExecution"];
private _animList    = ["Acts_Executioner_Standing", "Acts_Executioner_Standing"];
private _isPlayer    = [_captive] call SFSM_fnc_isPlayer;
private _addSquat    = (random 1 > 0.5);
private _addBackhand = random 1 > 0.5;//true;//
private _addForehand = random 1 > 0.5;//true;//
private _execute     = [_captive, _captor, _forceExecution] call SFSM_fnc_allowCaptureExecution;

if(_isPlayer)    then {_addSquat = true;};
if(_addSquat)    then {_animList append ["Acts_Executioner_Squat", "Acts_Executioner_Squat_End", "Acts_Executioner_Standing"];};
if(_addBackhand) then {_animList pushBack "Acts_Executioner_Backhand";};
if(_addForehand) then {_animList pushBack "Acts_Executioner_Forehand";};
if(_isPlayer)    then {_animList pushBack "Acts_Executioner_Standing";};
if(_execute)     then {_animList pushBack "Acts_Executioner_Kill";};

_animList pushBack "Acts_Executioner_Kill_End";

_animList;