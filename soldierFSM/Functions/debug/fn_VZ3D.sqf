params[
	["_virtualZone", nil, [createHashmap]]
];
private _pos   = _virtualZone get "position";
private _color = [0.4, 1, 0.9, 0.5];
private _text  = "Virtual Zone";
private _icon  = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_saveas_ca.paa";

if  (_virtualZone get "active")then{
	_text  = "Virtual Zone (Active)";
	_color = [0.9,0.6,0.3,1];
};

drawIcon3D [
    _icon,  //Icon 
    _color, //Color
    _pos,   //Pos 
    1.1,    //Icon-size A
    1.1,    //Icon-size B
    0,      //Angle  
    _text,  //Text 
    2,      //Shadow 
    0.03    //TextSize
];

[
	_virtualZone, 
	_color,
	true

] call SFSM_fnc_AZ3DCorners;