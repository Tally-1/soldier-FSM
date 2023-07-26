params["_fipo"];
private _synced = (synchronizedObjects _fipo) select {
    ([_x, true] call SFSM_fnc_canRun
  &&{[_x, _fipo] call SFSM_fnc_fipoAllowedMan})
};

//if a group was synced to the fipo then move in an available man from said group.
// private _groups = (synchronizedObjects _fipo) select {_x isKindOf "group";};
// if(_groups isNotEqualTo [])then{
//     private _group = _groups#0;
//     private _units = units _group select {
//     ([_x, true] call SFSM_fnc_canRun
//     &&{[_x, _fipo] call SFSM_fnc_fipoAllowedMan})
//     };

//     _synced append _units;
// };



if(_synced isEqualTo [])exitWith{
    [_fipo] call SFSM_fnc_clearFipo; 
    false;
};

private _man    = [_fipo, _synced] call SFSM_fnc_getNearest;
private _group  = group _man;
private _leader = leader _group;

[_fipo, [_man]] call SFSM_fnc_clearFipo;
[_man, _fipo] call SFSM_fnc_getInFiPo;

if(_man isEqualTo _leader)then{
    [_group, "fipoGroup", true] call SFSM_fnc_groupData;
};

true;