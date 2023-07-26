params["_man"];
private _knee = [_man, "rightlegroll"] call SFSM_fnc_selectionPos;

drawIcon3D[
            "\A3\ui_f\data\map\markers\military\ambush_CA.paa", //Icon     
            [0.1,0.5,0,1],    //Color
            _knee,            //Pos 
            0.3,              //Icon-size  
            0.3,              //Icon-size  
            0,                //angle 
            "Forced move",    //text 
            2,                //shadow 
            0.0275            //TextSize
    ];

true;