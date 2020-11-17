player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    _pos = getPos _unit;

    [_unit, _pos] remoteExec ["BM_fnc_weaponFired", 2]; 
}];