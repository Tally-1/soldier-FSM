params ["_man"];
private _fipo = [_man] call SFSM_fnc_getFipo;
if(isNil "_fipo")                                 exitWith{};
if(_fipo getVariable "hitAndRun" isEqualTo false) exitWith{};


private _eh =
_man addEventHandler ["Fired", {
   params ["_man"];
	if!([_man, true] call SFSM_fnc_inFipo)exitWith{};
   if(_fipo getVariable "hitAndRun" isEqualTo false) exitWith{};

	private _fipo  = [_man] call SFSM_fnc_getFipo;
   private _shots = _fipo getVariable "shotsFired";
   private _max   = _fipo getVariable "hitAndRunMaxShots";

   _shots = _shots+1;

   if(_shots >= _max)exitWith{
      private _msg = "Leaving fipo, max shots fired.";
      [[_msg], 2] call dbgmsg;
      [[_msg], 1] call dbgmsg;
      [_man, _msg] spawn SFSM_fnc_flashAction;
      [_man, true] call SFSM_fnc_getOutFipoHitAndRun;
   };
	
   _fipo setVariable ["shotsFired", _shots];

}];

_man setVariable ["SFSM_fipoFiredHrEh", _eh];

true;