// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_launchPos", "_impactPos", "_shooter", "_ammoType"];

private _nearMen = _impactPos nearEntities ["CAManBase", SFSM_explosionCoverRad];//[_shooter, SFSM_explosionCoverRad] call Tcore_fnc_nearSoldiers;
_nearMen = _nearMen select {[_x, true, false, true] call SFSM_fnc_canRun;};


if(isNil "_shooter")      exitWith {"shooter undefined" call dbgmsg};
if(_nearMen isEqualTo []) exitWith {"Nobody insde range of explosion" call dbgmsg};

{
    private _available    = [_x] call SFSM_fnc_availableAiSoldier;
    private _holdingCover = "Holding cover" in ([_x] call SFSM_fnc_getAction);

    if(_available)
    then{[_x, _launchPos, _impactPos, _shooter] call SFSM_fnc_reactToExplosion;};

    if(_holdingCover)
    then{
        [_x, (getPos _x), true] call SFSM_fnc_endStayInCover;
        [_x, "Leaving cover"] spawn SFSM_fnc_flashAction;
    };

    [_x, "Near explosion!"] spawn SFSM_fnc_flashAction;

} forEach _nearMen;


true;