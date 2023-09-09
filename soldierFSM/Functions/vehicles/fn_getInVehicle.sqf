// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _role = "gunner";
params["_vehicle", "_man", "_role"];
private _otherSidePresent = [_vehicle, _man] call SFSM_fnc_otherSideInVehicle;
if(_otherSidePresent)exitWith{};

[_vehicle, _man] call SFSM_fnc_initGetInVehicle;
private _vPos = (getPos _vehicle);

// private _move = 
[
    _man,  //unit 
    _vPos,//position 
    30,   //timeout (optional)
    5,    //minimum distance to position in order to complete move. (optional)
    2     // sleep between each repetition of doMove. (optional)

] call SFSM_fnc_forceMove2;

// waitUntil{sleep 0.1; scriptDone _move;};

if((!alive _vehicle)
||(!alive _man)
||((_man distance2D _vehicle)>10))exitWith{
    [_vehicle, _man] call SFSM_fnc_endGetInVehicle;
    };


private _gunner = (gunner _vehicle);
private _driver = (driver _vehicle);
if(_role == "gunner"
&&{!alive _gunner})
then{
        _gunner action ["Eject", _vehicle];
        _man assignAsGunner _vehicle;
        _man action ["getInGunner", _vehicle];
};

if(_role == "driver"
&&{!alive _driver})
then{
        _driver action ["Eject", _vehicle];
        _man assignAsDriver _vehicle;
        _man action ["getInDriver", _vehicle];
};

[_vehicle, _man] call SFSM_fnc_endGetInVehicle;
true;