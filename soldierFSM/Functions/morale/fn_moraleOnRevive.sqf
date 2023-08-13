params["_unconscious"];
private _entities = _unconscious nearEntities 100;

{
    if([_x] call SFSM_fnc_functionalMan
    &&{ true//_x knowsAbout   _unconscious isEqualTo 4
	&&{ _x isNotEqualTo _unconscious}})then{
    
        if(([_unconscious, _x] call SFSM_fnc_hostile) isEqualTo false)
        then{[_x, "friendly-revived"] call SFSM_fnc_moraleEvent};

}}
forEach _entities;

[_unconscious, "revived"] call SFSM_fnc_moraleEvent;


true;