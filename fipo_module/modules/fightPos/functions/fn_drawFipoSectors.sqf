params["_fipo"];



([_fipo] call FIPO_fnc_fipoSectors)params
["_rightSector", "_centerSector", "_leftSector"];

if((_fipo getVariable ["rightFlank", -1]) > 0)then{
    _rightSector      params ["_pos", "_angle", "_width", "_distance"];
    private _txt      = ["Right ", _width, " degrees. ", _distance, " meters."] joinString"";
    private _sector   = [_rightSector, [0.2, 0.2, 0.9, 1], _txt] call FIPO_fnc_sector3D;
    [_sector] call FIPO_fnc_drawSector3D;
};

if(_fipo getVariable "dynamicfipo")then{
    _centerSector     params ["_pos", "_angle", "_width", "_distance"];
    private _txt      = ["Fire-Sector | ", _distance, " meters | ", _width, " degrees |"] joinString"";
    private _sector   = [_centerSector, [0.9, 1, 0.1, 1], _txt] call FIPO_fnc_sector3D;
    [_sector] call FIPO_fnc_drawSector3D;
};

if((_fipo getVariable ["leftFlank", -1]) > 0)then{
    _leftSector       params ["_pos", "_angle", "_width", "_distance"];
    private _txt      = ["Left ", _width, " degrees. ", _distance, " meters."] joinString"";
    private _sector   = [_leftSector, [0.3, 0.3, 0.8, 1], _txt] call FIPO_fnc_sector3D;
    [_sector] call FIPO_fnc_drawSector3D;
};

true;