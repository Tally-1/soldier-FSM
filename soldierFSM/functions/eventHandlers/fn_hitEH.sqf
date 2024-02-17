// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params["_man"];
_man addEventHandler ["Hit", {
    params ["_man", "_source", "_damage", "_instigator"];

    private _vehicle = vehicle _man;

    if!([_man] call SFSM_fnc_isRealMan)     exitWith{};
    if([_man, true] call SFSM_fnc_isPlayer) exitWith{};

    _man setVariable["SFSM_prevShooter", _instigator, true];

    //Handle morale 
    [_man] call SFSM_fnc_moraleOnHit;

    //Handle marksman-hit
    private _sniper = _man getVariable "SFSM_myAssasin";
    if(!isNil "_sniper" && {_sniper isEqualTo _instigator})then{
        [_instigator, _man] spawn SFSM_fnc_handleMarksmanHit;
    };

    //Handle fighting positions
    private _fipo = [_man] call SFSM_fnc_getFipo;
    if(!isNil "_fipo")then{
        [_man, _fipo] spawn SFSM_fnc_handleFipoHit;
    };

    _fipo = [_instigator] call SFSM_fnc_getFipo;
    if(!isNil "_fipo"
    &&{alive _man
    &&{side _man != side _instigator}})then{
        private _weapon = (currentWeapon _instigator);
        [_instigator, nil, _weapon] spawn SFSM_fnc_multiplyRF;
    };

    if(([_instigator] call SFSM_fnc_getAction)isEqualTo"Counter Attacking")then{
        private _weapon = (currentWeapon _instigator);
        [_instigator, nil, _weapon] spawn SFSM_fnc_multiplyRF;
    };
    


    //Remove damage if caused by sprinting
    if(_man getVariable ["SFSM_Sprinting",false]
    &&{isNull _instigator})exitWith{
        ["Damage caused by sprinting", 2] call dbgmsg;
        private _dmg = damage _man; 
        _man setDamage (_dmg - _damage);
        true;
    };
    
    //used in the stayInCover function
    [_man, "Last_Hit", time] call SFSM_fnc_unitData;
    _man setVariable ["SFSM_enemy", _source];

    //check conditions before initiating healing
    private _action = [_man, "action"] call SFSM_fnc_unitData;
    if("hunker" in _action)exitWith{};

    //Stop holding if the man is in a cover-pos
    if(_action isEqualTo "Holding cover position")
    exitWith{
                [_man, (getPos _man), true] call SFSM_fnc_endStayInCover; 
                "end cover, hit by bullet" call dbgmsg;
            };
    


    
    if("eviv" in _action)exitwith{};
    if(_man getVariable ["SFSM_Sprinting", false])   exitwith{false;};

    private _legDamage = getAllHitPointsDamage _man # 2 # 10;

    if!([_man] call SFSM_fnc_canSelfHeal)exitWith{
        ["wounded_no_medkit", [_man]]   call CBA_fnc_localEvent;
    };


    if(_legDamage > 0.4)exitWith{[_man] spawn SFSM_fnc_proneHeal;};
    

    private _canHealBody = (damage _man)>0.3 
                         &&{SFSM_EmergencyHealing == "whole-body"
                         &&{_action isEqualTo "none"}};
    
    if(_canHealBody)exitWith{[_man] spawn SFSM_fnc_proneHeal;};

    //stop bleeding if ACE is in use
    if(SFSM_aceLoaded 
    &&{(_man getVariable ["ace_medical_woundbleeding", 0]) > 0.1
    &&{SFSM_EmergencyHealing == "whole-body"}})exitWith{
        [_man] spawn SFSM_fnc_proneHeal;
    };

    true;
        
}];

