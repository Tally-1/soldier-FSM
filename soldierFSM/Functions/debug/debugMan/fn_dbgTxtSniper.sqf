params["_man", "_pos"];
private _hitTarget = _man getVariable ["SFSM_hitTarget", false];


private _color     = [0,1,0.9,1];
private _size      = 0.5;
private _text      = _man getVariable ["SFSM_marksmanAction", "hunting"];
private _icon      = "\A3\ui_f\data\map\groupicons\selector_selectedEnemy_ca.paa";

if(_hitTarget)then{
    _color = [1,0,0,1];
    _size  = 1;
    _text  = "hit target";
    _icon  = "\a3\Ui_F_Curator\Data\CfgMarkers\minefield_ca.paa";
};

if((!alive _victim)
&&{!isNull _victim})then{
    _text = "target down";
    _size = 1;
    _icon = "\a3\Ui_F_Curator\Data\CfgMarkers\minefieldAP_ca.paa";
};

if([_victim] call SFSM_fnc_isUncon)then{
    _text = "target incapacitated";
    _size = 1;
    _icon = "\A3\ui_f\data\map\markers\handdrawn\objective_CA.paa";
};
    
drawIcon3D[
            _icon,        
            _color,    
            _pos,    
            0.5,         
            0.5,         
            0,              
            _text, 
            2,             
            0.03        
        ];

true;