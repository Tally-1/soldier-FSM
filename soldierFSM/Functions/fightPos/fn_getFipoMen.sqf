// returns all ai-units assigned to a fighting position, both if in a position already
// or if currently moving to one.
// Not best practise, but I decided to also remove any erroneous fipoMen from their
// figthingPos.

private _fipoMen = allUnits select 
    {
        private _fipoGotten = [_x, "inFipo"]call SFSM_fnc_unitData;
        private _action     = [_x] call SFSM_fnc_getAction;
            
        if(isNil "_fipoGotten") then{_fipoGotten = false;};
        if(isNil "_action")     then{_action     = "none";};

        private _error = [_x, _action, _fipoGotten] call SFSM_fnc_checkFipoError;
         
        if(_error)then{
            [_x] call SFSM_fnc_getOutFipo;
            [_x, "Fipo Error", 30] call SFSM_fnc_flashAction;
        };

        //the man is in a fighting-pos if there is no error an inFipo fnc returns true;
        ([_x, true] call SFSM_fnc_inFipo
        &&{! _error})
        || _fipoGotten;
};

_fipoMen;