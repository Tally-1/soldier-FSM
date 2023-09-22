params["_AZ"];
private _pos         = _AZ get "position";
private _sides       = _AZ get "sides_present";
private _activeText  = str(_sides);
private _activeIcon  = "\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa";
private _activeColor = [1,1,1,0.8];

if(count _sides isEqualTo 1)then{
    _activeColor = [_sides#0] call SFSM_fnc_sideColor;
};

drawIcon3D [
    _activeIcon,  //Icon 
    _activeColor, //Color
    _pos,         //Pos 
    1.6,          //Icon-size A
    1.6,          //Icon-size B
    0,            //Angle  
    _activeText,  //Text 
    2,            //Shadow 
    0.04          //TextSize
];

[_AZ, _activeColor] call SFSM_fnc_AZ3DCorners;


true;