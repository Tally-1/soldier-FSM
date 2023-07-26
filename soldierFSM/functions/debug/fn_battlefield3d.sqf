// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _camPos = (positionCameraToWorld [0,0,0]);
{
            private _pos       = _y get "center";
            private _radius    = _y get "radius";
            private _distance  = (_camPos distance2D _pos);
            private _inside   = _distance < (_radius * 1.5);

            private _infoPos   = [_pos#0, (_pos#1+(_radius*0.2)), 0];
            private _infoText  = _y get "currentAction";
            private _showInfo  = !(_infoText == "none");

            if(_inside)
            then{
                    private _name      = ["Battlefield ", (_y get "name")] joinString "";
                    private _posCount  = round(_radius / 5);
                    private _positions = [_pos, _radius, _posCount] call Tcore_fnc_get360Positions;
                    private _covPosHash= (_y get "coverPositions");
                    private _wCovpos   = _covPosHash get "west";
                    private _eCovpos   = _covPosHash get "east";
                    private _gCovpos   = _covPosHash get "independent";
                    private _icon      = "\A3\ui_f\data\map\markers\handdrawn\end_CA.paa";
                    //private _hnkObjs   = missionNamespace getVariable (_y get "hunkerObjects");
                    //private _hnkPos    = [_hnkObjs] call Tcore_fnc_posFromObjArr;
                    
                    [_pos, nil, _name]call SFSM_fnc_drawObjectMarker;
                    [_positions] call SFSM_fnc_multiple3dmarkers;
                    //[_hnkPos] call SFSM_fnc_multiple3dmarkers;
/*
                    [_wCovpos, [0,0.3,0.6,1], "", _icon, 0.5, 200] call SFSM_fnc_multiple3dmarkers;
                    [_eCovpos, [0.5,0,0,1], "",   _icon, 0.5, 200] call SFSM_fnc_multiple3dmarkers;
                    [_gCovpos, [0,0.5,0,1], "",   _icon, 0.5, 200] call SFSM_fnc_multiple3dmarkers;
*/                    
                    if(_showInfo)then
                    {[_infoPos, [0.6,0.6,1,1], _infoText]call SFSM_fnc_drawObjectMarker};
                    [_y] call SFSM_fnc_hunkerObj3d;
                    
                };
        } forEach SFSM_Battles;