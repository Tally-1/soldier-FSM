params["_man", "_fipo"];

if!(side _man in (_fipo getVariable "allowedSides"))exitWith{false;};

private _isLeader = (leader (group _man)) isEqualTo _man;
if((_fipo getVariable "allowsql") isEqualTo false
&&{_isLeader                      isEqualTo true})     
exitWith {false;};


if((_fipo getVariable "allowmed") isEqualTo false
&&{[_man] call SFSM_fnc_isMedic   isEqualTo true})
exitWith {false;};


if((_fipo getVariable "allowats")   isEqualTo false
&&{[_man] call SFSM_fnc_isATSoldier isEqualTo true})
exitWith {false;};


if((_fipo getVariable "allowmgn")       isEqualTo false
&&{[_man] call SFSM_fnc_isMachineGunner isEqualTo true})
exitWith {false;};

if((_fipo getVariable "allowmar")  isEqualTo false
&&{[_man] call SFSM_fnc_isMarksman isEqualTo true})
exitWith {false;};

//Inactive fire-sector on a dynamic fipo.
private _dynamic = _fipo getVariable "dynamicFipo";
if(_dynamic isEqualTo true
&&{[_fipo, _man] call SFSM_fnc_dynamicFipoActive isEqualTo false})
exitWith{false;};


true;