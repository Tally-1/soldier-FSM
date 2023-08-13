params["_victim", "_killer", "_instigator"];
private _entities = _victim nearEntities 100;
_entities insert  [0, (units group _victim),  true];
_entities insert  [0, [_killer, _instigator], true];

{
    if([_x] call SFSM_fnc_functionalMan
    &&{ true//_x knowsAbout _victim isEqualTo 4
	})then{
    
        if([_victim, _x] call SFSM_fnc_hostile)
        then{[_x, "enemy-killed"] call SFSM_fnc_moraleEvent}
        else{[_x, "friendly-killed"] call SFSM_fnc_moraleEvent}

}}
forEach _entities;

true;