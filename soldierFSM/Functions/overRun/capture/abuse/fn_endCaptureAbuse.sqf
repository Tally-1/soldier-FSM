params[
	"_captive", 
	"_captor",
	["_forced", false]
];
private _animEh = _captor getVariable "SFSM_abuseAnimEh";
private _anchor = _captor getVariable "SFSM_myAnchor";

if(isNil "_animEh")exitWith{};

_captor removeEventHandler ["AnimChanged", _animEh];

[_captive, _captor] remoteExecCall ["enableCollisionWith", [_captive, _captor]];

[_captive, true] call SFSM_fnc_toggleCaptureAi;
[_captor,  true] call SFSM_fnc_toggleCaptureAi;

deleteVehicle _anchor;

_captor  setVariable ["SFSM_myAnchor",     nil, true];
_captor  setVariable ["SFSM_myExecVictim", nil, true];
_captor  setVariable ["SFSM_abuseAnimEh",  nil, true];
_captor  setVariable ["SFSM_abuser",       nil, true];
_captive setVariable ["SFSM_abused",       nil, true];

if(_forced)then{
		_captor setAnimSpeedCoef 3;
		[
			_captor, 
			"amovpercmstpsraswrfldnon",
			[
				[_captor],
				false,
				{(_this#0) setAnimSpeedCoef 1;}
			]
		] call SFSM_fnc_animThenExec;
	};

true;