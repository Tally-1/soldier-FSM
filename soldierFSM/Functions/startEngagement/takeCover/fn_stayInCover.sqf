// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man", "_endPos"];
private _coverTime   = [_man, SFSM_stayCoverPosTime] call SFSM_fnc_getCourageTime;
private _timer       = time + _coverTime;
private _stayInCover = true;
private _hitByBullet = false;
private _overrun     = false;

//disable some ai, and update state
_man disableAI "PATH";
[_man, "pathEnabeled", false]    call SFSM_fnc_unitData;
[_man, "action", "Holding cover position"]    call SFSM_fnc_unitData;
_man setCombatBehaviour "STEALTH";

while {sleep 0.5; _stayInCover} do {
    private _unconscious      = _man getVariable ["ace_isunconscious", false];
    private _injured          = (_man getVariable ["dam_ignore_injured0",false]);
    private _timedOut         = time > _timer;
    private _timeSinceLastHit = time - ([_man, "Last_Hit"]    call SFSM_fnc_unitData);

    if(isNil "_timeSinceLastHit")then{_stayInCover = false};

    _hitByBullet      = (_timeSinceLastHit < 1.1 && SFSM_breakCoverOnHit);
    _overrun          = !isNull ([_man] call SFSM_fnc_manOverrunBy);
    

    if(_timedOut 
    || _hitByBullet
    || _overrun
    || _unconscious
    || _injured)
    then{_stayInCover = false};
};

[_man, _endPos, _hitByBullet, _overrun]call SFSM_fnc_endStayInCover;


true;