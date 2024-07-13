// Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

private _smallTxt    = "<t size='0.75'>";
private _bigTxt      = "<t size='2'>";
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _signature   = ["--> ", _versionName, " setting: "] joinString "";
private _outLine     = "<t shadow='2'>";
private _aqua        = "<t color='#00ffff'>";
private _khaki       = "<t color='#acffa4'>";
private _green       = "<t color='#83ff7f'>";
private _red         = "<t color='#e51313'>";
private _end         = "</t>";
private _newLine     = "<br/>";

// private _curatorDeleted = _warningType == "curator";

private _warningText = parseText 
([
    _outLine,
    _bigTxt,_red, "!!Warning!!", _end,_end,_newLine,
    _green, "Deleting units while they are engaged in a fight, ",_aqua,"MAY",_end," cause errors.", _end, _newLine,_newLine,
    _khaki, "First kill them using the [end] button.", _newLine,
            "Then wait 2-5 seconds before deleting them.", _newLine,
            "If you ignore this, then do not complain about errors on screen..", _newLine,
            _newLine,_end,
            _smallTxt, _versionName,_end,
    _end

] joinString "");

Hint _warningText;

diag_log "DCO soldier FSM ==> Unit was deleted by curator mid battle!"