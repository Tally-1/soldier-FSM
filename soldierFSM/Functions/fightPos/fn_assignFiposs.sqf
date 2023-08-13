// params["_men", "_fiposs"];
// if(_men isEqualTo [])    exitWith{};
// if(_fiposs isEqualTo []) exitWith{};

// {
//    private _fipo = [_x, _fiposs] call SFSM_fnc_selectFipo;
//    if(!isNil "_fipo")then{
//       [_x, _fipo] spawn SFSM_fnc_moveInFipo;
//       _fiposs deleteAt (_fiposs find _fipo);
//    };

// } forEach _men;