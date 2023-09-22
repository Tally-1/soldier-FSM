params["_AZ"];
private _pos   = _AZ get "position";
private _color = [0.85,0.4,0,0.7];
private _text  = "Fire Zone";
private _icon  = "\a3\ui_f\data\igui\cfg\simpletasks\letters\z_ca.paa";

if(_AZ get "mode_code" isEqualTo 1)
then{
    _text  = "Flank Zone";
    _color = [0.1,0.5,0,0.7];
};

if(_AZ get "active")then{
    _color deleteAt 3;
    _color pushBack 1;
	[_AZ] call SFSM_fnc_activeAZ3D;

};


drawIcon3D [
    _icon,     //Icon 
    _color,    //Color
    _pos,      //Pos 
    1,         //Icon-size A
    1,         //Icon-size B
    0,         //Angle  
    _text,     //Text 
    2,         //Shadow 
    0.03       //TextSize
];

[_AZ, _color] call SFSM_fnc_AZ3DLines;

true;