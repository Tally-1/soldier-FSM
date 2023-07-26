params["_man"];
_man playMoveNow "AmovPercMstpSrasWrflDnon";
_man setUnitPos "UP";

_man addEventHandler ["AnimDone", {
    params ["_man", "_anim"];
    if("amovpercmstpsraswrfldnon" in toLowerANSI _anim)
    then{
        _man removeEventHandler [_thisEvent, _thisEventHandler];
        _man setVariable ["SFSM_standing", true];
        _man spawn{sleep 1; _this setVariable ["SFSM_standing", nil];};
    };
}];