// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

if(!isNil "SFSM_Custom3Dpositions")then{
private _color = [0.6,0.6,0.1,1];
private _icon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
private _size  = 1; 
private _i = 0;

    {
        private _pos = _x#0;
        private _txt = _x#1;
        drawIcon3D     [
                        _icon,            
                        _color,
                        _pos,    
                        1,         
                        1,         
                        0,              
                        _txt, 
                        2,             
                        0.035
                    ];
        _i = _i+1;
    } forEach SFSM_Custom3Dpositions;

};