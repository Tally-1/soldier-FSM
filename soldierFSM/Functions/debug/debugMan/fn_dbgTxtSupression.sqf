params["_pos", "_color", "_suppression"];
private _txt = ["Supression: ", _suppression] joinString "";

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