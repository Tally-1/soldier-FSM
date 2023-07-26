params["_player"];
if(isNil "SFSM_fnc_callPlayerMedic")                    exitWith{false;};
if(_player call SFSM_fnc_inVehicle)                     exitWith{false;};
if((!isNil "SFSM_playerHealing")&&{SFSM_playerHealing}) exitWith{false;};
if(count (units group _player)<2)                       exitWith{false;};
if!([_player] call SFSM_fnc_playerNeedsMedic)           exitWith{false;};
if([_player] call SFSM_fnc_isUncon)                     exitWith{false;};

private _healer = [_player] call SFSM_fnc_getGroupHealer;
if(isNil "_healer")exitWith{false;};

true;