params["_man"];
private _eh =
_man addEventHandler ["AnimDone", {
    params ["_man", "_animation"];

    private _anim = _man getVariable "SFSM_idleAnim";

    if((toLower _anim) in (toLower _animation))then{
        _man setVariable ["SFSM_idleAnimDone", true];
        _man removeEventHandler [_thisEvent, _thisEventHandler];
        // _man playMoveNow "AmovPercMstpSrasWrflDnon";

        _man spawn{
            sleep 1; 
            _this setVariable ["SFSM_idleAnimDone", nil];
            _this setVariable ["SFSM_idleAnim", nil];
            _this setVariable ["SFSM_idleAnimEh", nil]
        };
    };

}];

_man setVariable ["SFSM_idleAnimEh", _eh];
_eh;