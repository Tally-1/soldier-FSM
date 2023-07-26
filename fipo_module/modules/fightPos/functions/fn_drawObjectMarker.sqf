private _color = [0.6,0.6,0.1,1];
private _text  = "";
private _icon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
private _size  = 1; 
private _maxDistance = 500;
params["_position", "_color", "_text", "_icon", "_size", "_maxDistance"];

private _camPos   = (positionCameraToWorld [0,0,0]);
private _distance = (_camPos distance2D _position);

if(_distance < _maxDistance)
then{
        drawIcon3D     [
                    _icon,            
                    _color,
                    _position,    
                    1,         
                    1,         
                    0,              
                    _text, 
                    2,             
                    0.03
                ];
};