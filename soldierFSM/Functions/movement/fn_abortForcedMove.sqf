params["_man"];
[_man, "abortForcedMove", true] call SFSM_fnc_unitData;
[_man, "abortSprint",     true] call SFSM_fnc_unitData;
_man setVariable ["SFSM_animListAborted", true];

_man spawn{
   sleep 1.5;

   private _animList = _this getVariable "SFSM_animListAborted";
   if(!isNil "_animList")then{
      _this setVariable ["SFSM_animListAborted", nil];
   };

    if([_this, "abortForcedMove"] call SFSM_fnc_unitData)then{
       [_this, "abortForcedMove", false] call SFSM_fnc_unitData;
    };
    if([_this, "abortSprint"] call SFSM_fnc_unitData)then{
       [_this, "abortSprint", false] call SFSM_fnc_unitData;
    };
};
true;