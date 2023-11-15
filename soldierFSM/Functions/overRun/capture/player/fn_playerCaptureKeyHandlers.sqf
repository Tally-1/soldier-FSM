private _keyDown = ["KeyDown", "_this call SFSM_fnc_playerCaptureOnKeyDown;"];
private _keyUp   = ["KeyUp",   "_this call SFSM_fnc_playerCaptureOnKeyUp;"];
private _downEh  = (findDisplay 46) displayAddEventHandler _keyDown;
private _upEh    = (findDisplay 46) displayAddEventHandler _keyUp;

player setVariable ["SFSM_captureKeyDown", _downEh];
player setVariable ["SFSM_captureKeyUp",   _upEh];

true;