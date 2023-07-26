// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_grenade", "_source"];
private _velocity = velocityModelSpace _grenade;
// sleep 1;
private _timer = time + 4;

waitUntil {
        private _touchingGround = ((getPos _grenade)#2) < 0.1;
        private _stopped = speed  _grenade < 0.1;
        ((_touchingGround
        &&{_stopped})
        || (time > _timer));
    };

private _nearSoldiers = [_grenade, (_grenade nearEntities 15 select {[_x, true] call SFSM_fnc_canRun;})] call Tcore_fnc_sortByDist;

if(count _nearSoldiers == 0)exitWith{};

private _nearest      = _nearSoldiers#0;
private _canThrowBack = SFSM_throwBackGrenade 
                      && {(_nearest distance2D _grenade)<7};

if(_canThrowBack)
then{
    _nearSoldiers = _nearSoldiers select {_x != _nearest};
    [_nearest, _grenade, _velocity, _source] spawn SFSM_fnc_throwBackGrenade;
    ["grenade_throwback", [_nearest, _grenade]] call CBA_fnc_localEvent;
    };

if(count _nearSoldiers == 0)exitWith{};

{
    private _action = [_x, "action"] call SFSM_fnc_unitData;
    if(!isNil "_action")then{[_grenade, _x, 30, true] spawn SFSM_fnc_evadeGrenade;};
    
} forEach _nearSoldiers;

true;