params["_man", "_turret", "_timer"];
if([_man, _turret] call SFSM_fnc_canGetInTurret)exitwith{true;};
if(time > _timer)exitwith{true;};
if(!alive _man)exitwith{true;};
if(_man getVariable ["ace_isunconscious", false])exitwith{true;};
if(!([_turret, true] call SFSM_fnc_turretAvailable))exitwith{true;};
false;