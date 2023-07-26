//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params['_man', '_dodge', '_targetPos', '_enemyVehicle'];
private _distance = _targetPos distance _man;
private _currentHouse = [_man] call SFSM_fnc_currentBuilding;
private _hide = !isNil '_enemyVehicle';
private _failed = _distance > 2.1 
                && {(! _dodge)
                &&{isNil '_currentHouse'
                &&{! _hide}}};

if(_failed)then
{
    [_man, "action", "Indoor cover failed"] call SFSM_fnc_unitData;
    _man doMove (getPos _man);
    sleep 2;
};

if(_dodge)
then{
        [_man, "action", "CQB dodge completed"] call SFSM_fnc_unitData;
        _man doMove (getPos _man);
        
        sleep 2;
    };

if((! _dodge)
&&{(! _failed)
&&{! _hide}})
then{
        _man disableAI 'path';
        [_man, "action", "holding cover indoors"] call SFSM_fnc_unitData;
        sleep SFSM_stayCoverPosTime;
        [_man, "action", "returning to normal"] call SFSM_fnc_unitData;
        sleep 2;
        _man enableAI 'path';
        _man doMove (getPos _man);
};

if(_hide)exitWith{[_man, _enemyVehicle, true] spawn SFSM_fnc_doHide;};

_man doFollow leader (group _man);
[_man, "action", "none"] call SFSM_fnc_unitData;
[_man, "currentDestination", [0,0,0]] call SFSM_fnc_unitData;