params["_man", "_pos"];
private _hitBy = _man getVariable ["SFSM_hitByMarksman", false];

private _color = [0.7, 0.2, 0.2, 1];
private _size  = 1;
private _text  = "hunted";

if(_hitBy)then{
    _color = [1,0,0,1];
    _size  = 1.5;
    _text  = "hit by marksman";

};

drawIcon3D[
            "\A3\ui_f\data\map\markers\military\destroy_CA.paa",        
            _color,    
            _pos,    
            _size,         
            _size,         
            0,              
            _text, 
            2,             
            0.03        
    ];

true;