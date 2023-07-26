params["_man", "_suppression"];
private _txt = [_man, _suppression] call SFSM_fnc_dbgTxtActionText;
if(_txt isEqualTo "")exitWith{};

private _color     = [_txt] call SFSM_fnc_actionColor;
private _3dPos     = (ASLToAGL getPosASL _man);
private _pos       = [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.3)];

drawIcon3D     [
                "",            
                _color,    
                _pos,    
                0.2,         
                0.2,         
                0,              
                _txt,
                2,             
                0.03        
            ];

true;