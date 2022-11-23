private _grenadePanic = false;
params["_man", "_grenadePanic"];
private _leader = ((leader (group _man)) == _man);

if(_leader&&{!(_grenadePanic)})exitWith{true};

private _loadout = getUnitLoadout _man;

removeAllWeapons _man;

[_man, "action", "No cover panic!"]	call SFSM_fnc_unitData;

_man switchMove "ApanPercMstpSnonWnonDnon_ApanPknlMstpSnonWnonDnon";
_man playMove 	"ApanPpneMstpSnonWnonDnon_G02";
sleep 5;

if!(alive _man)exitWith{[_man, "action", "none"] call SFSM_fnc_unitData};

_man switchMove "AmovPpneMstpSrasWrflDnon_AmovPpneMstpSrasWpstDnon";
_man setUnitLoadout _loadout;
[_man, "action", "none"] call SFSM_fnc_unitData;

private _enemy = ([_man, 300, 'enemies'] call Tcore_fnc_nearKnownEnemies)#0;
if!(isNil "_enemy")then{[_man, _enemy] call SFSM_fnc_Dodge};

true;