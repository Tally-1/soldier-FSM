params["_victim"];
private _shooter  = _man getVariable ["SFSM_prevShooter", objNull];
private _entities = _victim nearEntities 100;

_entities insert  [0, (units group _victim),  true];
_entities pushBack _shooter;

{
    if([_x] call SFSM_fnc_functionalMan
    &&{true// _x knowsAbout   _victim isEqualTo 4
	&&{ _x isNotEqualTo _victim}})then{
    
        if([_victim, _x] call SFSM_fnc_hostile)
        then{[_x, "enemy-knocked-out"] call SFSM_fnc_moraleEvent}
        else{[_x, "friendly-knocked-out"] call SFSM_fnc_moraleEvent}

}}
forEach _entities;

[_victim, "knocked-out"] call SFSM_fnc_moraleEvent;

true;