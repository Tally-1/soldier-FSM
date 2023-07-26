// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_man", "_target"];
private _actionTimer   = time + 3;
private _weapon        = currentWeapon _man;
private _weaponData       = [_weapon] call ObjScan_fnc_weaponData;
private _grenadeMuzzle = [_weapon] call SFSM_fnc_glRifle;
private _glMuzzleName  = _grenadeMuzzle # 0;
private _glAmmoCapacity= _grenadeMuzzle # 1;
private _hasGl         = !(_glMuzzleName == "");
private _weaponModes   = _weaponData get "weapon-modes";
private _fireMode       = "";

[_man, "action", "return direct fire"]    call SFSM_fnc_unitData;
_man doTarget _target;

if(_hasGL)
then{
        private _script = [_man, _target, 3, _glMuzzleName, _glAmmoCapacity] spawn SFSM_fnc_unitTounitForcedFire;
        waitUntil {sleep 0.1; scriptDone _script};
    };

/*get rapid fireMode */
if("Full" in _weaponModes)    then{_fireMode = (_weaponModes get "Full") get "cfgName"};
if("Burst" in _weaponModes)    then{_fireMode = (_weaponModes get "Burst") get "cfgName"};
if!(_fireMode == "")        then{_man selectWeaponTurret [_weapon, [], _weapon, _fireMode]};

while{(alive _man
&&{time < _actionTimer
&&{(!(_man getVariable ["ace_isunconscious", false]))
&&{!(_man getVariable ["dam_ignore_injured0",false])}}})}
do    {
        private _timeLeft = (_actionTimer - time);
        [_man, _target, 1, _weapon, 1] spawn SFSM_fnc_unitTounitForcedFire;
        
        if(!alive _target)then{_target = _man findNearestEnemy _man};
        if(isNull _target)exitWith{};

        _man doWatch  _target;
        _man doFire      _target;

        sleep 0.1;
    };

[_man] call SFSM_fnc_endReactiveFire;