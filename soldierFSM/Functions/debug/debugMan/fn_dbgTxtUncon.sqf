params["_pos"];
private _icon            = "\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa";
private _text            = "Unconscious";
private _color           = [0.49, 0.12, 0.12, 0.8];
private _healerDeathTime = floor(time - ([_man, "healerDeathTime"] call SFSM_fnc_unitData));

if(_healerDeathTime < 60)then{ 
    _text  = ["Medic died ", _healerDeathTime, " seconds ago."]joinString"";
    _icon  = "\A3\ui_f\data\map\markers\handdrawn\objective_CA.paa";
    _color = [0.9, 0.1, 0.1, 1];
};

drawIcon3D[
            _icon,        
            _color,    
            _pos,    
            1,         
            1,         
            0,              
            _text, 
            2,             
            0.03        
        ];
true;