// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

params ["_battleField"];
if!(SFSM_Debugger)exitWith{};

private _markers   = [];
private _centerPos = (_battleField get "center");
private _radius    = (_battleField get "radius");
private _areaName  = (_battleField get "name");
private _zones     = (_battleField get "zones");
private _coverPos  = (_battleField get "coverPositions");
private _gridHash  = missionNamespace getVariable (_battleField get 'grid');



private _marker1 = [_centerPos, _radius] call SFSM_fnc_drawCircle;
private _marker2 = [_centerPos, _areaName, 1] call SFSM_fnc_posMarker;
{_markers pushback _x}forEach[_marker1, _marker2];



{
      private _cMarker = [_x] call Tcore_fnc_ClusterMarker;
    _markers pushback _cMarker;
}forEach _clustersData;



{
    private _color = ["Color",_x] joinString "";
    private _pos   = _y#0;
    private _Radius= _y#1;

    if(count _pos > 2)
    then{
            private _zMarker = [_pos, _Radius, nil, _color] call SFSM_fnc_drawCircle;
            _markers pushBack _zMarker;
        };

} forEach _zones;

if(isNil "_coverPos")    exitWith{_battleField set ["markers", _markers]; _markers};
if(count _coverPos > 100)exitWith{_battleField set ["markers", _markers]; _markers};

{
    private _color = ["Color",_x] joinString "";
    private _newMarkers = [_Y, _color] call SFSM_fnc_drawCoverPositions;
    _markers append _newMarkers;
} forEach _coverPos;


if(!isNil "_gridHash")
then{
        private _hfWest   = _gridHash get 'hiddenFromWest';
        private _hfEast   = _gridHash get 'hiddenFromEast';
        private _hfGuer   = _gridHash get 'hiddenFromGuer';

        {
            private _marker = [_x, "", 0.7, 'colorBlue', "Contact_dot1"] call SFSM_fnc_posMarker;
            _markers pushBackUnique _marker;
        } forEach _hfWest;

        {
            private _marker = [_x, "", 0.7, 'colorRed', "Contact_dot1"] call SFSM_fnc_posMarker;
            _markers pushBackUnique _marker;
        } forEach _hfEast;


        /*
        {
            private _marker = [_x, "", 0.7, 'colorGreen', "Contact_dot1"] call SFSM_fnc_posMarker;
            _markers pushBackUnique _marker;
        } forEach _hfGuer;
        */
};

_battleField set ["markers", _markers];

_markers;