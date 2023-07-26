SFSM_bullets = SFSM_bullets select {
    !isNull _x 
    && {(positionCameraToWorld [0,0,0]) distance _x < 500}
};

{
    private _color    = _x getVariable ["SFSM_IconColor", [0.85,0.4,0,1]];
    private _pos      = (ASLToAGL getPosASLVisual _x);
    private _icon     = "\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa";
    private _size     = 1.5;
    private _angle    = 0;
    
    //if the bullet is fired by a marksman engaging his target.
    if(_x getVariable ["SFSM_MrkmnSht", false])then{
        _icon     = "\A3\ui_f\data\map\markers\military\objective_CA.paa";
        _size     = 0.6;
        _angle    = round (random 360);
    };
    
    drawIcon3D     [
    _icon,  //texture (icon type)
    _color, //color
    _pos,   //position
    _size,  //size X
    _size,  //size Y
    _angle, //angle
    "",     //text
    2,      //shadow
    0.015   //textSize
    ];
       
} forEach SFSM_bullets;