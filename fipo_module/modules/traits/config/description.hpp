// Module description (must inherit from base class, otherwise pre-defined entities won't be available):
class ModuleDescription : ModuleDescription
{
    description[] = {
    "The traits set here will affect the individual soldiers behaviour ingame.",
    "Use the ''Apply to'' field to select the target of the module.",
    "",
    "Untrained  0% - 25%",
    "Conscript  25% - 45%",
    "Regular    45% - 65%",
    "Veteran    65% - 85%",
    "Elite      85% - 95%",
    "Superman   95% - 100%"
    };
	
    position  = 0;   // Position is taken into effect
    direction = 0;  // Direction is taken into effect
    optional  = 2; // Synced entity is optional
    duplicate = 2;// Multiple entities of this type can be synced
    synced[]  = {"AnyPerson", "GroupModifiers"};
};
//, , , veteran og 