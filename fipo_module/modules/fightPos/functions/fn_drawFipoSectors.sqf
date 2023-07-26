params["_fipo"];
private _sectors = [_fipo] call FIPO_fnc_flankSectors;

if(_fipo getVariable ["rightFlank", -1] > 0)then{
    private _width = round (180*(_fipo getVariable "sfsm_rightflankwidth"));
    private _txt = ["Right ", _width, " degrees. ", (_fipo getVariable "rightFlank"), " meters."] joinString"";
    private _right = [_sectors#0, [0.2, 0.2, 0.9, 1], _txt] call FIPO_fnc_sector3D;
    [_right] call FIPO_fnc_drawSector3D;
};

if((_fipo getVariable ["leftFlank", -1]) > 0)then{
    private _width = round (180*(_fipo getVariable "sfsm_leftflankwidth"));
    private _txt = ["Left ", _width, " degrees. ", (_fipo getVariable "leftFlank"), " meters."] joinString"";
    private _left = [_sectors#1, [0.2, 0.2, 0.9, 1], _txt] call FIPO_fnc_sector3D;
    [_left] call FIPO_fnc_drawSector3D;
};

true;