params["_captive", "_captor"];
private _pos          = getPosASLVisual _captive;
private _dir          = getDirVisual _captive;
private _anchor       = createSimpleObject ["UserTexture1m_F", _pos, false];
private _animEh       = [_captor] call SFSM_fnc_captureAbuseAnimStartEh;

[_captive, false] call SFSM_fnc_toggleCaptureAi;
[_captor,  false] call SFSM_fnc_toggleCaptureAi;

_anchor setDir    _dir;
_anchor setPosASL _pos;

sleep 0.2;

_captive attachTo [_anchor, [0,0,0]];
_captor  attachTo [_anchor, [0,0,0]];

[_captive, _captor] remoteExecCall ["disableCollisionWith", [_captive, _captor]];
sleep 0.1;


_captor  setVariable ["SFSM_myAnchor",     _anchor,  true];
_captor  setVariable ["SFSM_myExecVictim", _captive, true];
_captor  setVariable ["SFSM_abuser",       true,     true];
_captor  setVariable ["SFSM_abuseAnimEh",  _animEh,  true];
_captive setVariable ["SFSM_abused",       true,     true];

_anchor;