Params ["_man", "_wounded"]; 
private _timer = time + 30;
// private _leftPos = _wounded modelToWorldVisualWorld [0.7,0.5,0];

_man addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];

	if("medicend" in _anim)then{
		_unit removeEventHandler [_thisEvent, _thisEventHandler]; 
		_unit setVariable ["SFSM_reviveDone", true];

	};
}];

_man attachTo [_wounded, [0,1.2,0], "face", true];
_man setDir 180;

_man action ['SWITCHWEAPON', _man, _man, 1];
_man switchMove "AmovPercMstpSrasWrflDnon";
_man playMove "amovPknlMstpSrasWrflDnon";
_man playMove "AinvPknlMstpSnonWrflDnon_AinvPknlMstpSnonWrflDnon_medic";
_man playMove "AinvPknlMstpSnonWrflDnon_AinvPknlMstpSnonWrflDnon_medic";
_man playMove "AinvPknlMstpSnonWrflDnon_medic";
_man playMove "AinvPknlMstpSnonWrflDnon_medic1";
_man playMove "AinvPknlMstpSnonWrflDnon_medic4";
_man playMove "AinvPknlMstpSnonWrflDnon_medicEnd";

waitUntil { sleep 1; 
	(_man getVariable ["SFSM_reviveDone", false] 
	|| _timer < time
	|| (!([_man, _wounded, true, 7] call SFSM_fnc_canBuddyHeal))
	)
};

// private _posMan = getPosASLVisual _man;
// private _posWounded = getPosASLVisual _wounded;
_man setVariable ["SFSM_reviveDone", nil];
detach _man;

// _man setPosASL     _posMan;
// _wounded setPosASL _posWounded;

true;