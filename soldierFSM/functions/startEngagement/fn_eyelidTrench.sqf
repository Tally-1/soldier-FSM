// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _grenadePanic = false;
params["_man", "_grenadePanic"];
private _leader = ((leader (group _man)) == _man);

if(_leader&&{!(_grenadePanic)})exitWith{true};

private _loadout = getUnitLoadout _man;

removeAllWeapons _man;

[_man, "action", "No cover panic!"]    call SFSM_fnc_unitData;

_man switchMove "ApanPercMstpSnonWnonDnon_ApanPknlMstpSnonWnonDnon";
_man playMove     "ApanPpneMstpSnonWnonDnon_G02";
sleep 5;

if!(alive _man)exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

_man switchMove "AmovPpneMstpSrasWrflDnon_AmovPpneMstpSrasWpstDnon";
_man setUnitLoadout _loadout;
[_man, "action", "none"] call SFSM_fnc_unitData;

private _enemy = ([_man, 300, 'enemies'] call Tcore_fnc_nearKnownEnemies)#0;
if!(isNil "_enemy")then{[_man, _enemy] spawn SFSM_fnc_Dodge};

true;