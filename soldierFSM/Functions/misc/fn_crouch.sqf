params["_man"];
_man playMoveNow "AadjPknlMstpSrasWrflDdown";
_man setUnitPos "MIDDLE";

_man addEventHandler ["AnimDone", {
    params ["_man", "_anim"];
    if("amovpknlmstpsraswrfldnon" in toLowerANSI _anim)
    then{
        _man removeEventHandler [_thisEvent, _thisEventHandler];
        _man setVariable ["SFSM_crouching", true];
        _man spawn{sleep 1; _this setVariable ["SFSM_crouching", nil];};
    };
}];