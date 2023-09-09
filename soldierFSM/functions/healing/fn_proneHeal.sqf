// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: Makes a man drop to the ground before healing himself.
// Return value: none 
// Example: [_mySoldado] spawn SFSM_fnc_proneHeal;

private _actionText = "none";
params[
    "_man",        //object(man)
     "_actionText" //string(text describing the action - optional)
];

private _vehicle = vehicle _man;
private _inVehicle = typeOf _vehicle != typeOf _man;

// if(_inVehicle)then{
//     [["In a vehicle"], 2] call dbgmsg;
// };

if(_inVehicle
&&{_vehicle isKindOf "StaticWeapon"
&&{gunner _vehicle == _man}})then{ 
    [["Ejecting from vehicle"], 2] call dbgmsg;
    _man action ["getOut", _vehicle];
    _man setVariable ["SFSM_myVehicle", _vehicle];
};

//return fire
private _returnFire = [_man, true] call SFSM_fnc_canReactFire;
if(_returnFire)then{ 

private _enemy = _man getVariable ["SFSM_enemy", objNull];
if(!alive _enemy)exitWith{};

private _friendlyFire = [(side _man), (side _enemy)] call BIS_fnc_sideIsFriendly;
if(_friendlyFire)exitWith{};


// private _fireAtEnemy = 
[_man, _enemy] call SFSM_fnc_reactFire;
// waitUntil { sleep 1; scriptDone _fireAtEnemy;};

};


//Heal
private _timer = time + 3;
private _standAnim     = "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";
private _crouchAnim    = "AmovPknlMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";

// [_man, "action", "emergency heal"] call SFSM_fnc_unitData;
[_man, "emergency heal"] spawn SFSM_fnc_flashAction;
[_man, _actionText] call SFSM_fnc_endHealEH;

["emergency_heal", [_man]]   call CBA_fnc_localEvent;

switch (stance _man) do
    {
        case "STAND" :    {_man playMove _standAnim };
        case "CROUCH":     {_man playMove _crouchAnim};
    };

waitUntil{
            sleep 0.1;
            ((stance _man) == "prone"
            or !alive _man
            or time > _timer)
        };

_man action ["HealSoldierSelf", _man];

if(SFSM_aceLoaded)then{

_man setVariable ["ace_medical_openwounds", nil, true];
_man setVariable ["ace_medical_woundbleeding", 0, true];

};


true;