// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

if(!isNil "SFSM_Custom3Dpositions")then{
private _defaultIcon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";

    {
        _x params[
            ["_pos",   nil,             [[]]],
            ["_txt",   "",              [""]],
            ["_color", [0.6,0.6,0.1,1], [[]]],
            ["_icon",  _defaultIcon,    [""]],
            ["_size",  1,                [0]]
        ];

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

    } forEach SFSM_Custom3Dpositions;

};