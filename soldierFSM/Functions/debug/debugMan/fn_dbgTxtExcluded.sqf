params["_man"];
private _actionTxt = [_man] call SFSM_fnc_getAction;
private _pos       = ASLToAGL(aimPos _man);

if(_actionTxt isEqualTo "none")
then{_actionTxt = ""};

drawIcon3D[
            "\a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",            
            [1,0,0,1],    
            _pos,    
            0.5,         
            0.5,         
            0,              
            _actionTxt, 
            2,             
            0.1        
        ];

true;