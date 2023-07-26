// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_battleField"];

private _action = [_man, "action"] call SFSM_fnc_unitData;
if(isNil "_action")
exitWith{
    "reactToVehicles, action undefined" call dbgmsg;
    false;
    };

private _occupied = ("Hiding" in _action 
                  || "hiding" in _action
                  || "hide" in _action
                  || "Targeting" in _action 
                  || "weapon" in _action 
                  || "holding" in _action);

private _playerLead = ((leader (group _man)) in allPlayers);


if(_occupied)exitWith{false};
 
//get nearest high-level enemy vehicle [_x] call SFSM_fnc_emergencyRearm;
private _majorThreat = [_man, _battleField] call SFSM_fnc_unkillableEnemyVehicle;


//proceed as normal if there are no enemy high-level vehicle
if(isNull _majorThreat)exitWith{false};



//Performance-wise this block would be better to put before the threat-check, 
//however the debug-message might cause confusion for testers if there are no vehicles present at the battlefield
if(_playerLead 
&& {!(SFSM_PlayerGrpDodge)})
exitWith{
            "player groups blocked from dodging, will not hide from vehicles" call dbgmsg; 
            false;
        };


//try to pick up launcher
private _atSpecialist    = ([_man] call SFSM_fnc_squadAsset) == "AT-specialist";
private _hasAtAmmo       = [_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon;
private _rearming        = false;

if!(_atSpecialist)
then{_rearming = [_man] call SFSM_fnc_emergencyRearm};
if  (_rearming) exitWith{true};


//check visibility / hearing
private _manPos          = eyePos _man;
private _enemyPos        = eyePos _majorThreat;
private _visibleToThreat = ([_man, "VIEW", _majorThreat] checkVisibility [_manPos, _enemyPos]) > 0.1;
private _vehicleHeard    = ([_man, _majorThreat] call SFSM_fnc_vehicleHeard);
private _detected        = (_visibleToThreat || _vehicleHeard);

if(_vehicleHeard)
then{["A vehicle was detected by hearing", 2] call dbgmsg};

//proceed as normal if man cannot be seen by enemy vehicle
if!(_detected)exitWith{false};


//if a vehicle is found and the man has a AT launcher, then repeat init-fight actions
if(_atSpecialist
&&{_hasAtAmmo
&&{SFSM_AtSpecHuntVehicles}})
exitWith{[_man] spawn SFSM_fnc_AtSpecialistInitFight; true};


//if there is a high-level threat present and the man has no launcher or no misiles.

if!(SFSM_hideFromVehicles)exitWith{"Man will not hide, hiding has been deactivated" call dbgmsg; false;};




//check for near available houses to hide in.
private _takeCoverIndoors = false;
private _canDodge = [_man, true] call SFSM_fnc_canDodge;
private _house = [(getPos _man), SFSM_DodgeDistance] call SFSM_fnc_nearestAvailableHouse;
if(_canDodge
&&{!isNil '_house'})
then{
      
      private _coverPos = [_man, _house, false, _majorThreat] call SFSM_fnc_moveIntoHouseInit;
      _takeCoverIndoors = !(_coverPos isEqualTo [0,0,0]);
};

//If house can be used as cover exit here.
if(_takeCoverIndoors)exitWith{true;};


private _hidePos = [_man, _majorThreat] call SFSM_fnc_findHidePos;
private _posFound = typeName _hidePos == "ARRAY";

if(_posFound)
exitWith{
            [_man, _hidePos, _majorThreat] spawn SFSM_fnc_hideFromVehicle;
            true;
        }; 


//If no hidden positions are found in the battlefield-grid, a standard coverPosition will be used
private _hideDir = _majorThreat getDir _man;
private _searchPos = getPos _man;
_searchPos = [_searchPos#0, _searchPos#1, _hideDir, SFSM_DodgeDistance] call Tcore_fnc_sinCosPos;

_hidePos = [_man, _searchPos, (SFSM_DodgeDistance*2)] call SFSM_fnc_getCoverPos;
_posFound = (!isNil "_hidePos" && {typeName _hidePos == "ARRAY"});

if(_posFound)
exitWith{
            [_man, _hidePos, _majorThreat] spawn SFSM_fnc_hideFromVehicle;
            true;
        };


"No place to hide found, running away from vehicle" call dbgmsg;

if!(surfaceIsWater _searchPos)
exitWith{[_man, _searchPos, _majorThreat] spawn SFSM_fnc_hideFromVehicle; true};

false;