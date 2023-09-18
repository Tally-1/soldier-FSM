// Module description (must inherit from base class, otherwise pre-defined entities won't be available):
class ModuleDescription : ModuleDescription
{
    description[] = {
    "Sync this module to a Fighting Position Module (FIPO) and it will work as a Activation-Zone(AZ)",
    "By syncing this module to a FIPO that FIPO will be transformed to a dynamic FIPO regardless of other settings",
    "Multiple FIPOs can be synced to one Activation-Zone.",
    "Activation-Zone is of 2 types:",
    "1) Fire-Sector: Will activate the FIPO(s) when units are in the AZ",
    "2) Flank:        Will deactivate the FIPO(s) when units are in the AZ"

    };
    
    position  = 2;  // Position is taken into effect
    direction = 2; // Direction is taken into effect
    optional  = 2; // Synced entity is optional
    duplicate = 0; // Multiple entities of this type can be synced
    synced[]  = {"AnyPerson", "GroupModifiers"};
};