//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description: This function is used to determine if a battle should end. It is called by the SFSM_fnc_battlefieldLoop function.

// Params: _battleField (hashMap) - The battlefield object to check.

// Return value: (boolean) - True if the battle should end, false if not.

// Example: [_battleField] call SFSM_fnc_battleEnded;


params ['_battleField'];
private _timePassed = time - (_battlefield get "Started");
private _name       = _battlefield get 'name';

//Do not enda a battle if it just started.
if(_timePassed < 60)exitwith{false};

//end the battle if there is only 1 side left.
private  _sides = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
if(count _sides < 2)
exitWith{
            [[str (_sides#0), ' Has won battle at ', _name, '!']] call dbgmsg;
            true;
        };


//Get the last unit who fired his weapon, and measure the time since he shot.
private _units = missionNamespace getVariable (_battleField get 'units');
_units = ([_units, [], { [_x, "last_bullet_fired"] call SFSM_fnc_unitData;}, "ASCEND"] call BIS_fnc_sortBy);
private _lastToShoot = _units#(count _units-1);
private _lastGunshot = [_lastToShoot, "last_bullet_fired"] call SFSM_fnc_unitData;

if(isNil "_lastGunshot")then{_lastGunshot = 0};

private _lastShotTime = time - _lastGunshot;


//End the battle if there are less than 2 units engaged and over 120s since last shot.
private  _unitsFighting = [_battleField] call SFSM_fnc_battlingUnits;
if(count _unitsFighting < 2
&&{_lastShotTime > 120})
exitWith{
            [['Ending battle at ', _name, '. ', _lastShotTime, ' Seconds since last shot']] call dbgmsg;
            true;
        }; 

false;